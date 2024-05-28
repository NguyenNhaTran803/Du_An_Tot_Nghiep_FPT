package com.poly.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.domain.AuditorAware;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

import com.poly.model.User;
import com.poly.service.AuditorAwareService;

@Configuration
@EnableJpaAuditing(auditorAwareRef = "auditorProvider")
public class AuditableConfig {

	@Bean
	AuditorAware<User> auditorProvider() {
		return new AuditorAwareService();
	}
}