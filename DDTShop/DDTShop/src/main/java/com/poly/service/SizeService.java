package com.poly.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.poly.model.Size;

public interface SizeService {
	Optional<Size> saveOrUpdate(Size user);

	Optional<Size> findById(Long id);
	
	Optional<Size> findByName(String name);

	void deleteById(Long id);

	List<Size> findAll();

	Page<Size> findAllByNameLike(String keyword, Pageable pageable);

	boolean hasProducts(Long sizeId);

	List<Size> getAllSizes();
}
