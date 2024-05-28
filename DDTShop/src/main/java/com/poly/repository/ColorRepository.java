package com.poly.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.poly.model.Color;

@Repository
public interface ColorRepository extends JpaRepository<Color, Long> {

	Page<Color> findAllByNameLike(String keyword, Pageable pageable);
	
}
