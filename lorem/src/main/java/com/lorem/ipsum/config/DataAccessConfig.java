package com.lorem.ipsum.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

@Configuration
@MapperScan(basePackages = "com.lorem.ipsum.dao")
public class DataAccessConfig {
	@Bean
	public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception{
		SqlSessionFactoryBean factoryBean=new SqlSessionFactoryBean();
		
		factoryBean.setDataSource(dataSource);
		factoryBean.setMapperLocations(
				new PathMatchingResourcePatternResolver().getResources("mybatis/mapper/*.xml")
				);
		return factoryBean.getObject();
	}
	public SqlSessionTemplate sessionTemplate(SqlSessionFactory sqlSessionFactory) {
		return new SqlSessionTemplate(sqlSessionFactory);
	}
}
