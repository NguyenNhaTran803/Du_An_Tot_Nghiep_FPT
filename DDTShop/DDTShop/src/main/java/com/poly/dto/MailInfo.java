package com.poly.dto;

import java.util.List;

import com.poly.common.MailType;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MailInfo {
	private String from;
	private String to;
	private String[] cc;
	private String[] bcc;
	private String subject;
	private List<Object[]> body;
	private String[] attachments;
	private MailType mailType;

	public MailInfo(String to, String subject, List<Object[]> body, MailType mailType) {
		this.from = "huynhhuutinh0948@gmail.com";
		this.to = to;
		this.subject = subject;
		this.body = body;
		this.mailType = mailType;
	}
}
