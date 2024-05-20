package com.poly.component;

import java.io.IOException;

import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.poly.dto.GoogleDto;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Component
public class GoogleUtils {

	@Value("${google.link.get.token}")
	private String link;

	@Value("${google.app.id}")
	private String clientId;

	@Value("${google.app.secret}")
	private String clientSecret;

	@Value("${google.redirect.uri}")
	private String redirectUri;

	@Value("${google.link.get.user_info}")
	private String linkInfo;

	public String getToken(final String code) throws ClientProtocolException, IOException {
		String response = Request.Post(link)
				.bodyForm(Form.form().add("client_id", clientId).add("client_secret", clientSecret)
						.add("redirect_uri", redirectUri).add("code", code).add("grant_type", "authorization_code")
						.build())
				.execute().returnContent().asString();
		ObjectMapper mapper = new ObjectMapper();
		JsonNode node = mapper.readTree(response).get("access_token");
		return node.textValue();
	}

	public GoogleDto getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
		String linkGetUserInfo = linkInfo + accessToken;
		String response = Request.Get(linkGetUserInfo).execute().returnContent().asString();
		ObjectMapper mapper = new ObjectMapper();
		GoogleDto google = mapper.readValue(response, GoogleDto.class);
		return google;
	}

}