package com.lorem.ipsum;

import java.util.ArrayList;
import java.util.Collections;

import lombok.val;

public class rangeList {
	ArrayList<Range> ranges;
	Range limitRange;
	public rangeList() {
		ranges = new ArrayList<Range>();
	}
	public rangeList getRangesInRange(int min, int max) {
		rangeList temp=new rangeList();
		Range target=new Range(min, max);
		for(Range range:ranges) {
			if(target.isDuple(range))
				temp.add(range);
		}
		return temp;
	}
	public rangeList getInnerRangesInRange(int min, int max) {
		rangeList temp=new rangeList();
		Range target=new Range(min, max);
		for(Range range:ranges) {
			if(target.isInclude(range))
				temp.add(range);
		}
		return temp;
		
	}
	public String toString() {
		String str="[";
		if(size()!=0)str+=ranges.get(0).toString();
		for(int i=1; i<size(); i++)str+=ranges.get(i).toString();;
		str+="]";
		return str;
	}
	public void setLimitless() {
		limitRange=null;
	}
	public void setLimit(int min, int max) {
		limitRange=new Range(min,max);
	}
	public void add(int start_point, int end_point) {
		add(new Range(start_point, end_point));
	}
	public void add(Range range) {
		if(range.startPoint>=range.endPoint)return;
		if(limitRange!=null) {
			if(limitRange.isInclude(range.startPoint)<0)
				range.startPoint=limitRange.startPoint;
			else if(limitRange.isInclude(range.startPoint)>0)return;
			if(limitRange.isInclude(range.endPoint)>0)
				range.endPoint=limitRange.endPoint;
			else if(limitRange.isInclude(range.endPoint)<0)return;
		}
		
		if (size() == 0) {
			ranges.add(range);
			return;
		}
		for (int i = 0; i < size(); i++) {
			if(get(i).isDuple(range)) {
				range=range.sumRange(remove(i));
				i--;
				continue;
			}
		}
		ranges.add(range);
	}
	public void sort() {
		for(int i=0; i<ranges.size()-1; i++) {
			for(int j=0; j<ranges.size()-i-1; j++) {
				if(ranges.get(j).startPoint>ranges.get(j+1).startPoint) {
					ranges.add(j+2,ranges.get(j));
					ranges.remove(j);
				}
			}
		}
	}
	public int size() {
		return ranges.size();
	}
	public Range remove(int index) {
		return ranges.remove(index);
	}
	public Range get(int index) {
		return ranges.get(index);
	}
	public int getStartPoint(int index) {
		return ranges.get(index).startPoint;
	}

	public int getEndPoint(int index) {
		return ranges.get(index).endPoint;
	}
	public class Range{
		int startPoint, endPoint;
		public Range(int start_point, int end_point) {
			startPoint=start_point;
			endPoint=end_point;
		}
		public int isInclude(int value) {
			if(value<startPoint)return -1;
			if(value>endPoint)return 1;
			return 0;
		}
		public boolean isInclude(Range range) {
			int sp=isInclude(range.startPoint), ep= isInclude(range.endPoint);
			if(sp>=0&&ep<=0)return true;
			return false;
		}
		public boolean isDuple(Range range) {
			int sp=isInclude(range.startPoint), ep= isInclude(range.endPoint);
			if(sp*ep<=0)
				return true;
			return false;
		}
		public Range sumRange(Range range) {
			
			int newSP=startPoint>range.startPoint?startPoint:range.startPoint;
			int newEP=endPoint>range.endPoint?endPoint:range.endPoint;
			return new Range(newSP, newEP);
		}
		public Range subRange(Range range) {
			int newSP=startPoint>range.startPoint?startPoint:range.startPoint;
			int newEP=endPoint>range.endPoint?endPoint:range.endPoint;
			return new Range(newSP, newEP);
		}
		public String toString() {
			return "("+startPoint+", "+endPoint+")";
		}
	}
}