package com.poly.controller.shop;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.client.ClientProtocolException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.poly.common.MailType;
import com.poly.common.Role;
import com.poly.component.GoogleUtils;
import com.poly.dto.GoogleDto;
import com.poly.dto.Login;
import com.poly.dto.MailInfo;
import com.poly.dto.Register;
import com.poly.model.User;
import com.poly.service.SecurityService;
import com.poly.service.UserService;
import com.poly.service.MailerService;
@Controller
@RequestMapping(value = "ddt/auth")
public class ShopAuthController {

	@Autowired
	UserService userService;
	
	@Autowired
	MailerService mailerService;

	@Autowired
	SecurityService securityService;

	@Autowired
	GoogleUtils googleUtils;

	@PostMapping(value = "/login")
	@ResponseBody
	public ResponseEntity<String> loginSubmit(@RequestBody Login login) {
		if (!userService.existsByUsername(login.getUsername()))
			return new ResponseEntity<String>("Tên đăng nhập không tồn tại", HttpStatus.INTERNAL_SERVER_ERROR);
		securityService.autoLogin(login.getUsername(), login.getPassword());
		return new ResponseEntity<String>("Chúc mừng bạn đã đăng nhập thành công.", HttpStatus.OK);
	}

	@PostMapping(value = "/register")
	@ResponseBody
	public ResponseEntity<String> registerSubmit(@RequestBody Register register) {
		if (userService.existsByUsername(register.getUsername()))
			return new ResponseEntity<String>("Tên đăng nhập đã được sử dụng", HttpStatus.INTERNAL_SERVER_ERROR);
		if (userService.existsByEmail(register.getEmail()))
			return new ResponseEntity<String>("Email đã được sử dụng", HttpStatus.INTERNAL_SERVER_ERROR);
		User user = new User();
		user.setUsername(register.getUsername());
		user.setEmail(register.getEmail());
		user.setPassword(register.getPassword());
		user.setLogin(true);
		user.setRole(Role.ROLE_USER);
		userService.saveOrUpdate(user);
		
		sendRegistrationEmail(user.getEmail(), MailType.REGISTER);
		return new ResponseEntity<String>("Chúc mừng bạn đã đăng ký thành công.", HttpStatus.OK);
	}
	
	public String sendRegistrationEmail(String toEmail, MailType mailType) {
		String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();
	    Object[] object = new Object[1];
	    object[0] = baseUrl + "/auth/login"; // Đường dẫn đến trang đăng nhập sau khi đăng ký
	    List<Object[]> list = new ArrayList<>();
	    list.add(object);
	    
	    String mailSubject = "";
	    switch (mailType) {
	        case FORGOT:
	            mailSubject = "Quên mật khẩu";
	            break;
	        case REGISTER:
	            mailSubject = "Đăng ký thành công";
	            break;    
	        case SUCCESS_SERVICE:
	            mailSubject = "Dịch vụ được kích hoạt thành công";
	            break;
	        // Thêm các loại mail mới nếu cần
	    }

	    MailInfo mailInfo = new MailInfo(toEmail, "Đăng ký thành công", list, MailType.REGISTER);
	    
	    try {
	    	 mailerService.send(mailInfo);
		} catch (MessagingException e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return baseUrl;
	    
	}

	@GetMapping(value = "/logout")
	public ResponseEntity<String> logout(HttpServletRequest request, HttpServletResponse response) {
		securityService.logout(request, response);
		return new ResponseEntity<String>(HttpStatus.OK);
	}

	@GetMapping("/login-google")
	public String loginGoogle(HttpServletRequest request) throws ClientProtocolException, IOException{
		String code = request.getParameter("code");
		if (code == null || code.isEmpty()) {
			return "redirect:/ddt/home?google=error";
		}
		String accessToken = googleUtils.getToken(code);
		GoogleDto google = googleUtils.getUserInfo(accessToken);
		if (!userService.existsByEmail(google.getEmail())) {
			User user = new User();
			user.setUsername(google.getId());
			user.setEmail(google.getEmail());
			user.setPassword(google.getId());
			user.setLogin(true);
			user.setRole(Role.ROLE_USER);
			userService.saveOrUpdate(user);
		}
		securityService.autoLogin(google.getId(), google.getId());
		return "redirect:/ddt/home";
	}
}
