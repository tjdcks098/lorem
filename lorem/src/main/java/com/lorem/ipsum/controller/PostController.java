package com.lorem.ipsum.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.lorem.ipsum.commons;
import com.lorem.ipsum.commons.USER_LEVEL;
import com.lorem.ipsum.exception.SessionFailException;
import com.lorem.ipsum.model.BoardModel;
import com.lorem.ipsum.model.logon.UserModel;
import com.lorem.ipsum.model.post.PostFileModel;
import com.lorem.ipsum.model.post.PostInfoModel;
import com.lorem.ipsum.service.BoardService;
import com.lorem.ipsum.service.LogonService;
import com.lorem.ipsum.service.PostContentsService;
import com.lorem.ipsum.service.PostInfoService;
import com.lorem.ipsum.service.ReplyService;

@CrossOrigin
@RestController
public class PostController {

	@Autowired
	LogonService logonService;

	@Autowired
	PostInfoService postInfoService;

	@Autowired
	PostContentsService postContentsService;

	@Autowired
	ReplyService replyService;

	@Autowired
	BoardService boardService;

	ModelAndView mv = new ModelAndView();

	@RequestMapping("/likeReply.{type}")
	public String likeReply(HttpSession session, HttpServletRequest request, @PathVariable String type) {
		try {
			commons.logonCheck(session, logonService);
		} catch (SessionFailException e) {
			String src = null;
			if (e.getCode() == SessionFailException.NOT_LOGIN)
				src = "if(confirm('로그인이 필요한 서비스입니다.\\n로그인 하시겠습니까?'))" + "{location.href='../login'}";
			else {
				src = "alert(" + e.getMsg() + ");" + "if(confirm('로그인이 필요한 서비스입니다.\\n로그인 하시겠습니까?'))"
						+ "{location.href='../login';}";
			}
			return src;
		}

		String p_id = request.getParameter("postId");
		String b_name = request.getParameter("name");
		String r_index = request.getParameter("r_index");
		String u_id = ((UserModel) session.getAttribute("user")).getU_id();
		String src = "";
		if (type.equals("do")) {
			if (replyService.likeReply(b_name, p_id, r_index, u_id)) {
				src = "history.go(0);";
			} else {
				src = "alert('처리도중 오류가 발생했습니다.')";
			}
		} else {
			if (replyService.unlikeReply(b_name, p_id, r_index, u_id)) {
				src = "history.go(0);";
			} else {
				src = "alert('처리도중 오류가 발생했습니다.')";
			}
		}
		return src;
	}

	@RequestMapping("/edit")
	public ModelAndView editPost(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		try {
			commons.logonCheck(session, logonService);
			String b_name = request.getParameter("name");
			String p_id = request.getParameter("postId");
			ArrayList<PostFileModel> files = postContentsService.getFiles(p_id, b_name);
			String p_title = postInfoService.getPostInfo(b_name, p_id).getP_title();
			String contents = postContentsService.getContents(Integer.valueOf(p_id), b_name).getP_contents();
			mv.addObject("files", files);
			mv.addObject("name", b_name);
			mv.addObject("postId", p_id);
			mv.addObject("title", p_title);
			mv.addObject("contents", contents);
			mv.setViewName("page/board/edit");
		} catch (SessionFailException e) {
			mv.addObject("msg", e.getMsg());
			mv.addObject("redirect", request.getHeader("Referer"));
			mv.setViewName("logic/result");
		}
		commons.setAlwaysReload(response);

		return mv;
	}

	@RequestMapping("/edit.do")
	public String edit_do(HttpServletRequest request, HttpServletResponse response, String title, String contents,
			String board, String postId, String[] delImage, String[] delFile, List<MultipartFile> images,
			List<MultipartFile> files, HttpSession session) {

		try {
			commons.logonCheck(session, logonService);
			String b_name = null;
			String p_id = null;
			int countI = 0;
			try {
				b_name = URLDecoder.decode(board, "utf-8");
				p_id = URLDecoder.decode(postId, "utf-8");
			} catch (UnsupportedEncodingException e1) {
				e1.printStackTrace();
			}
			String path = "C:\\SpringWorkSpace\\lorem\\src\\main\\webapp\\WEB-INF\\postUpload\\";
			File dir = new File(path);

			if (!dir.isDirectory())
				dir.mkdir();
			String u_id = ((UserModel) session.getAttribute("user")).getU_id();
			PostInfoModel post = postInfoService.getPostInfo(b_name, p_id);
			if (b_name == null || p_id == null || post == null || !post.getU_id().equals(u_id)) {
				return "유효하지 않은 접근입니다.:../welcome";
			} else {
				if (postInfoService.editPost(b_name, p_id, title)
						&& postContentsService.editContents(p_id, b_name, contents)) {
					try {
						if (delFile != null) {
							ArrayList<String> fl = new ArrayList<String>();
							for (String s : delFile) {
								fl.add(postContentsService.getFile(p_id, b_name, s, "file").getF_url());
							}
							for (String s : fl) {
								postContentsService.delFile(p_id, b_name, s);
								File del = new File(s);
								del.delete();
							}
						}
						if (delImage != null) {
							ArrayList<PostFileModel> refImage = postContentsService.getFiles(p_id, b_name);
							ArrayList<String> il = new ArrayList<String>();
							for (String s : delImage) {
								il.add(postContentsService.getFile(p_id, b_name, s, "img").getF_url());
							}
							for (int i = 0; i < refImage.size(); i++)
								if (refImage.get(i).getF_type().equals("file")) {
									refImage.remove(i);
									i--;
								}

							for (String s : il) {
								for (int j = 0; j < refImage.size(); j++) {
									if (refImage.get(j).getF_url().equals(s)) {
										postContentsService.delFile(p_id, b_name, s);
										File del = new File(s);
										del.delete();
										refImage.remove(j);
										break;
									}
								}
							}
							countI = refImage.size();
						}
						if (images != null)
							for (int i = 0; i < images.size(); i++) {
								String f_url = path + b_name + "_" + post.getP_id() + "_img_"
										+ images.get(i).getOriginalFilename();
								File save = new File(f_url);
								postContentsService.addFile(post.getP_id(), b_name, "img" + (i + countI + 1),
										images.get(i).getOriginalFilename(), f_url);
								images.get(i).transferTo(save);
							}
						if (files != null)
							for (int i = 0; i < files.size(); i++) {
								String f_url = path + "\\" + b_name + "_" + post.getP_id()
										+ "_file_" + files.get(i).getOriginalFilename();
								File save = new File(f_url);
								postContentsService.addFile(post.getP_id(), b_name, "file",
										files.get(i).getOriginalFilename(), f_url);
								files.get(i).transferTo(save);
							}
						return "수정되었습니다.:../post?&name=" + b_name + "&postId=" + post.getP_id();
					} catch (Exception e) {
						e.printStackTrace();
						return "파일 업로드에 실패했습니다." + e.getMessage() + ":../post?&name=" + b_name + "&postId="
								+ post.getP_id();
					}
				} else {
					return "글을 수정하는데 실패했습니다.:";
				}
			}
		} catch (SessionFailException e) {
			return e.getMsg();
		}

	}

	@RequestMapping("/delPost")
	private ModelAndView delPost(HttpSession session, HttpServletRequest request) throws IOException {
		try {
			mv.setViewName("logic/result");
			commons.logonCheck(session, logonService);
			String b_name = request.getParameter("name");
			String p_id = request.getParameter("postId");
			String u_id = ((UserModel) session.getAttribute("user")).getU_id();
			ArrayList<PostFileModel> files = postContentsService.getFiles(p_id, b_name);
			if (postInfoService.delPost(u_id, p_id, b_name)) {
				try {
					if (files != null) {
						for (PostFileModel file : files) {
							File target = new File(file.getF_url());
							target.delete();
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			mv.addObject("name", b_name);
			mv.addObject("postId", p_id);
			mv.addObject("redirect", "../board");
		} catch (SessionFailException e) {
			mv.addObject("msg", e.getMsg());
			mv.addObject("redirect", request.getHeader("Referer"));
		}
		return mv;
	}

	@GetMapping("post/download")
	private Resource download(HttpServletRequest request, HttpSession session) throws IOException {
		request.setCharacterEncoding("utf-8");

		try {
			commons.logonCheck(session, logonService);
		} catch (SessionFailException e) {
			return null;
		}

		InputStream is = null;
		File file = null;

		String p_id = request.getParameter("postId");
		String b_name = request.getParameter("name");
		String f_name = request.getParameter("f_name");
		PostFileModel fileInfo = postContentsService.getFile(p_id, b_name, f_name, "file");

		try {
			file = new File(fileInfo.getF_url());
			is = new FileInputStream(file);
		} catch (FileNotFoundException fe) {
		}
		return new InputStreamResource(is);

	}

	@GetMapping("/post/like.{type}")
	public ModelAndView likeDo(@PathVariable String type, HttpServletRequest request, HttpSession session) {
		String b_name = request.getParameter("name");
		String p_id = request.getParameter("postId");
		UserModel user = (UserModel) session.getAttribute("user");
		PostInfoModel postInfo = postInfoService.getPostInfo(b_name, p_id);
		try {
			commons.logonCheck(session, logonService);
			String u_id = user != null ? user.getU_id() : null;
			try {
				if (type.equals("do")) {
					postInfoService.addLike(u_id, p_id, b_name);
				} else {
					postInfoService.subLike(u_id, p_id, b_name);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (SessionFailException e) {
			mv.addObject("logonMsg", e.getMsg());
		}
		mv.addObject("postId", p_id);
		mv.addObject("name", b_name);
		mv.addObject("boardList", boardService.getBoardList());
		mv.addObject("postInfo", postInfo);
		if (user != null)
			mv.addObject("like", postContentsService.isLike(user.getU_id(), Integer.valueOf(p_id), b_name));
		mv.addObject("postContents", postContentsService.getContents(Integer.valueOf(p_id), b_name));
		mv.addObject("postFile", postContentsService.getFiles(p_id, b_name));
		mv.addObject("replyList", replyService.getPostReplies(Integer.valueOf(p_id), b_name));

		mv.setView(new RedirectView("../board/post"));
		return mv;
	}

	@GetMapping(value = "/postUpload/view/{f_name}")
	public ResponseEntity<byte[]> viewImage(@PathVariable String f_name) throws IOException {
		InputStream istream = null;
		ResponseEntity<byte[]> image = null;
		try {
			HttpHeaders headers = new HttpHeaders();
			istream = new FileInputStream("C:\\SpringWorkSpace\\lorem\\src\\main\\webapp\\WEB-INF\\postUpload\\"
					+ f_name);
			image = new ResponseEntity<byte[]>(IOUtils.toByteArray(istream), headers, HttpStatus.CREATED);
		} catch (Exception e) {
			e.printStackTrace();
			image = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			if (istream != null)
				istream.close();
		}
		return image;
	}

	@RequestMapping("/write")
	public ModelAndView write(HttpServletResponse response, HttpServletRequest request, HttpSession session) {
		String b_name = (String) request.getParameter("name");
		mv.addObject("name", b_name);
		try {
			commons.logonCheck(session, logonService);
			mv.addObject("boardList", boardService.getBoardList());
		} catch (SessionFailException e) {
			mv.addObject("logonMsg", e.getMsg());
		}

		mv.setViewName("page/board/write");
		return mv;
	}

	@RequestMapping("/write.do")
	public String write_do(HttpServletRequest request, HttpServletResponse response, String title, String contents,
			String board, List<MultipartFile> images, List<MultipartFile> files, HttpSession session) {
		String b_name = null;
		try {
			b_name = URLDecoder.decode(board, "utf-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		String type=boardService.getBoardInf(b_name).getB_type();
		try {
			commons.logonCheck(session, logonService);

			String path = "C:\\SpringWorkSpace\\lorem\\src\\main\\webapp\\WEB-INF\\postUpload\\";
			File dir = new File(path);

			if (!dir.isDirectory())
				dir.mkdir();
			String u_id = (String) ((UserModel) session.getAttribute("user")).getU_id();
			if (b_name == null) {
				return "유효하지 않은 접근입니다." + ":../welcome";
			} else {
				PostInfoModel newPost = postInfoService.newPost(title, u_id, b_name);
				if (newPost != null&&contents!=null) {
					postContentsService.setContents(newPost.getP_id(), b_name, contents);
					try {
						if (images != null)
							for (int i = 0; i < images.size(); i++) {
								String f_url = path + b_name + "_" + newPost.getP_id()
										+ "_img_" + images.get(i).getOriginalFilename();
								File save = new File(f_url);
								postContentsService.addFile(newPost.getP_id(), b_name, "img" + (i + 1),
										images.get(i).getOriginalFilename(), f_url);
								images.get(i).transferTo(save);
							}
						if (files != null)
							for (int i = 0; i < files.size(); i++) {
								String f_url = path + b_name + "_" + newPost.getP_id()
										+ "_file_" + files.get(i).getOriginalFilename();
								File save = new File(f_url);
								postContentsService.addFile(newPost.getP_id(), b_name, "file",
										files.get(i).getOriginalFilename(), f_url);
								files.get(i).transferTo(save);
							}

						return "게시되었습니다." + ":../post?&name=" + b_name + "&postId=" + newPost.getP_id();
					}catch (Exception e) {
						e.printStackTrace();
						return "파일 업로드에 실패했습니다." + ":../post?&name=" + b_name + "&postId=" + newPost.getP_id();
					}
				} else {
					if(type.equals("noContents"))return "borad";
					return "글을 게시하는데 실패했습니다." + ":";
				}
			}
		} catch (SessionFailException e) {
			if(type.equals("noContents"))return "login";
			return e.getMsg() + ":../login";
		}
	}

	@RequestMapping("/post")
	public ModelAndView post(HttpServletRequest request, HttpSession session, HttpServletResponse response)
			throws UnsupportedEncodingException {
		request.setCharacterEncoding("utf-8");
		String p_id = (String) request.getParameter("postId");
		String b_name = (String) request.getParameter("name");
		String view = (String) request.getParameter("view");
		String target =null;
		String key = null;
		if(view!=null&&view.equals("search")) {
		target = request.getParameter("target");
		 key = request.getParameter("key");
		}
		PostInfoModel postInfo = postInfoService.getPostInfo(b_name, p_id);
		BoardModel board = boardService.getBoardInf(b_name);
		UserModel user = (UserModel) session.getAttribute("user");
		try {
			commons.logonCheck(session, logonService);
			mv.addObject("logonMsg", null);
			if (user.getU_level() > board.getB_rlevel()) {
				mv.addObject("errMsg",
						USER_LEVEL.valueOf(board.getB_rlevel()) + "(" + board.getB_rlevel() + "등급)이상 이용 가능한 게시판 입니다.");
			} else {
				mv.addObject("errMsg", null);
				mv.addObject("likeReply", replyService.getLikedReplies(user.getU_id(), b_name, p_id));
				mv.addObject("like", postContentsService.isLike(user.getU_id(), Integer.valueOf(p_id), b_name));
				if (view != null && view.equals("new") && !user.getU_id().equals(postInfo.getU_id())) {
					postInfoService.addView(p_id, b_name);
				}
			}
		} catch (SessionFailException e) {
			mv.addObject("logonMsg", e.getMsg());
			if (board.getB_rlevel() < 10) {
				mv.addObject("errMsg", "로그인 후 이용 가능한 게시판 입니다.");
			} else {
				mv.addObject("like", null);
				mv.addObject("errMsg", null);
			}
		}
		mv.addObject("postId", p_id);
		mv.addObject("name", b_name);
		if(view!=null&&view.equals("search")&&key != null) {
			mv.addObject("key", key);
			mv.addObject("target", target);
		}
		mv.addObject("boardList", boardService.getBoardList());
		mv.addObject("postInfo", postInfo);
		mv.addObject("postContents", postContentsService.getContents(Integer.valueOf(p_id), b_name));
		mv.addObject("postFile", postContentsService.getFiles(p_id, b_name));
		mv.addObject("replyList", replyService.getPostReplies(Integer.valueOf(p_id), b_name));
		mv.setViewName("page/board/post");
		commons.setAlwaysReload(response);
		return mv;
	}

	@RequestMapping(value = "/post/reply")
	public ModelAndView reply(HttpServletRequest request, HttpSession session) {
		try {
			commons.logonCheck(session, logonService);
			UserModel user = (UserModel) session.getAttribute("user");
			String p_id = (String) request.getParameter("postId");
			String b_name = (String) request.getParameter("name");
			String contents = (String) request.getParameter("contents");
			replyService.submit(Integer.valueOf(p_id), user.getU_id(), contents, b_name);
			mv.addObject("msg", null);
		} catch (SessionFailException e) {
			mv.addObject("msg", e.getMsg());
		}
		mv.addObject("redirect", commons.baseUrl + "post");
		mv.setViewName("logic/result");
		return mv;
	}

	@RequestMapping(value = "/rdel")
	public ModelAndView rdel(HttpServletRequest request, HttpSession session) {
		try {
			commons.logonCheck(session, logonService);
			String p_id = request.getParameter("postId");
			String b_name = request.getParameter("name");
			String r_index = request.getParameter("index");
			replyService.del(p_id, b_name, r_index);
			mv.addObject("msg", null);
		} catch (SessionFailException e) {
			mv.addObject("msg", e.getMsg());
		}
		mv.addObject("redirect", commons.baseUrl + "post");
		mv.setViewName("logic/result");
		return mv;
	}
}
