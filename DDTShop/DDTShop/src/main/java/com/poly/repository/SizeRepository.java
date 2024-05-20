package com.poly.repository;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.poly.model.Size;

@Repository
public interface SizeRepository extends JpaRepository<Size, Long> {

	Page<Size> findAllByNameLike(String keyword, Pageable pageable);
	
	Optional<Size> findByName(String name);
	
}
