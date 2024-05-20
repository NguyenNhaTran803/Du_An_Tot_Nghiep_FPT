package com.poly.dto;

import com.poly.common.Pay;
import com.poly.common.Ship;
import com.poly.common.Status;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class OrderHistory {

	private Long id;
	private int quantity;
	private float totail;
	private Pay pay;
	private Ship ship;
	private Status status;
}
