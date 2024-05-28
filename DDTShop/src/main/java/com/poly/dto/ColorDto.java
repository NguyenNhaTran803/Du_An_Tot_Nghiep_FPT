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
public class ColorDto {
private Long id;
	
	@NotBlank(message = "{notblank.colorName}")
	private String name;
}
