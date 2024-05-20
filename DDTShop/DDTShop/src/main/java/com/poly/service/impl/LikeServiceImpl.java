package com.poly.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poly.model.Like;
import com.poly.repository.LikeRepository;
import com.poly.service.LikeService;

@Service
public class LikeServiceImpl implements LikeService {

	@Autowired
	LikeRepository likeRepository;

	@Override
	public Optional<Like> saveOrUpdate(Like like) {
		Like likeOld = likeRepository.save(like);
		return Optional.of(likeOld);
	}

	@Override
	public void deleteById(Long id) {
		likeRepository.deleteById(id);
	}

	@Override
	public List<Like> findAllByUserId(String id) {
		return likeRepository.findAllByUserId(id);
	}

	@Override
	public List<Object[]> statisticsLikeMonthByYear(int year) {
		return likeRepository.statisticsLikeMonthByYear(year);
	}

	@Override
	public List<Object[]> statisticsLikeCategory() {
		return likeRepository.statisticsLikeCategory();
	}
}