package com.poly.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poly.model.OrderDetail;
import com.poly.repository.OrderDetailRepository;
import com.poly.service.OrderDetailService;

@Service
public class OrderDetailServiceImpl implements OrderDetailService {
	
	@Autowired
	OrderDetailRepository orderDetailRepository;

	@Override
	public Optional<OrderDetail> saveOrUpdate(OrderDetail orderDetail) {
		OrderDetail orderDetailOld = orderDetailRepository.save(orderDetail);
		return Optional.of(orderDetailOld);
	}

	@Override
	public List<OrderDetail> findAllByOrderId(Long id) {
		List<OrderDetail> list = orderDetailRepository.findAllByOrderId(id);
		return list;
	}

	@Override
	public List<Object[]> statisticsRevenueMonthByYear(int year) {
		return orderDetailRepository.statisticsRevenueMonthByYear(year);
	}

	@Override
	public List<Object[]> getSalerByDate(String dateNow, String dateTo) {
		return orderDetailRepository.getSalerByDate(dateNow, dateTo);
	}

	@Override
	public List<Object[]> getSalerByMonth(int month) {
		return orderDetailRepository.getSalerByMonth(month);
	}

	@Override
	public List<Object[]> getSalerByYear(int year) {
		return orderDetailRepository.getSalerByYear(year);
	}
	
	
}