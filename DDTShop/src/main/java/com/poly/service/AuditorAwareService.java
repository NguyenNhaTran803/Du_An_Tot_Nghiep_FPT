package com.poly.service;

import java.util.Optional;

import org.springframework.data.domain.AuditorAware;

import com.poly.model.User;

public class AuditorAwareService implements AuditorAware<User> {

	@Override
	public Optional<User> getCurrentAuditor() {
		return Optional.empty();
	}

}
