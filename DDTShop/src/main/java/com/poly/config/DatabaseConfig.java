package com.poly.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DatabaseConfig {
	@Value("${spring.datasource.url}")
	private String url;

	@Value("${spring.datasource.username}")
	private String user;

	@Value("${spring.datasource.password}")
	private String password;

	@Value("${spring.datasource.driverClassName}")
	private String driverClass;

	private String secretKey = "MollaShopSpringBootAndThymeleaf";

	@Bean
	DataSource dataSource() {
		DataSourceBuilder dataSourceBuilder = DataSourceBuilder.create();
		dataSourceBuilder.url(CryptionAES.decrypt("E5fwcoNPyM1LJwpw1iG1U9QIcGA00f3uyGiFDWrp0hZ/ebQENOdN9wZrtp0b2SjN7i2sJequse+e09CfCmzBNCdSGm7ZVBIESGC04mhgpDALLs2/dt0PQrtEepijHy3GrtVi4XLWZOYnJWd17v0YUQ==", secretKey));
		dataSourceBuilder.driverClassName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		dataSourceBuilder.username(CryptionAES.decrypt("SWvaQWyvQiuxKWA69ifROQ==", secretKey));
		dataSourceBuilder.password(CryptionAES.decrypt("JmmWp5/KW6B8exohDdqmNg==", secretKey));
		return dataSourceBuilder.build();
	}
	
}