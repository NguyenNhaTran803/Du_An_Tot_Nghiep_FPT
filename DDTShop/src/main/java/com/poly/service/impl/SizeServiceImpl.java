package com.poly.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.poly.model.Color;
import com.poly.model.Size;
import com.poly.repository.SizeRepository;
import com.poly.service.SizeService;

@Service
public class SizeServiceImpl implements SizeService {

	@Autowired
	SizeRepository sizeRepository;

	@Override
	public Optional<Size> saveOrUpdate(Size size) {
		Size sizeOld = sizeRepository.save(size);
		return Optional.of(sizeOld);
	}

	@Override
	public Optional<Size> findById(Long id) {
		return sizeRepository.findById(id);
	}

	@Override
	public Optional<Size> findByName(String name) {
		return sizeRepository.findByName(name);
	}
	
	@Override
	public void deleteById(Long id) {
		sizeRepository.deleteById(id);
	}

	@Override
	public List<Size> findAll() {
		return sizeRepository.findAll();
	}

	@Override
	public Page<Size> findAllByNameLike(String keyword, Pageable pageable) {
		return sizeRepository.findAllByNameLike(keyword, pageable);
	}

	@Override
	public boolean hasProducts(Long sizeId) {
		// Kiểm tra xem có sản phẩm nào liên quan đến category không
		Size size = sizeRepository.findById(sizeId).orElse(null);

		if (size != null && size.getProducts() != null && !size.getProducts().isEmpty()) {
			return true;
		}

		return false;
	}

	@Override
	public List<Size> getAllSizes() {
		return sizeRepository.findAll();
	}
}
