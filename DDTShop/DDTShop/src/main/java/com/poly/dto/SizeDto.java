package com.poly.dto;

import javax.validation.constraints.NotBlank;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class SizeDto {
private Long id;
	
	@NotBlank(message = "{notblank.sizeName}")
	private String name;
}
