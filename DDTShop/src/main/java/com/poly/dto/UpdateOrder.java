package com.poly.dto;

import com.poly.common.Pay;
import com.poly.common.Status;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class UpdateOrder {
	private Long id;
	private Pay pay;
	private Status status;
}
