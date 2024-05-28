package com.poly.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.poly.model.Brand;

public interface BrandService {
	Optional<Brand> saveOrUpdate(Brand brand);
	
	Optional<Brand> findById(Long id);
	
	void deleteById(Long id);
	
	List<Brand> findAll();
	
	Page<Brand> findAllByNameLike(String keyword, Pageable pageable);

	boolean hasProducts(Long brandId);
}