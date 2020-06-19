package com.lorem.ipsum;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;


@SpringBootApplication
@MapperScan("com.lorem.ipsum.mapper")

public class LoremApplication {

	public static void main(String[] args) {
		SpringApplication.run(LoremApplication.class, args);
	}

}
