package com.poly.controller.admin;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.poly.common.MailType;
import com.poly.common.Role;
import com.poly.config.CryptionAES;
import com.poly.dto.Login;
import com.poly.dto.MailInfo;
import com.poly.dto.Register;
import com.poly.model.User;
import com.poly.service.MailerService;
import com.poly.service.SecurityService;
import com.poly.service.SessionService;
import com.poly.service.UserService;

@Controller
@RequestMapping(value = "auth")
public class AuthController {

	@Autowired
	UserService userService;

	@Autowired
	SecurityService securityService;

	@Autowired
	MailerService mailerService;

	@Autowired
	SessionService session;

	@GetMapping(value = "/login")
	public String login(Login login) {
		if (securityService.isAuthenticated()) {
			return "redirect:/home";
		}
		return "auth/admin/login";
	}

	@PostMapping(value = "/login/submit")
	public String loginSubmit(Model model, @Valid @ModelAttribute(name = "login") Login login, BindingResult result,
			HttpServletRequest request, HttpServletResponse response) {
		securityService.logout(request, response);
		if (result.hasErrors()) {
			model.addAttribute("error", "Lỗi định dạng");
			return "auth/admin/login";
		}
		if (!userService.existsByUsername(login.getUsername())) {
			model.addAttribute("error", "Tên đăng nhập không tồn tại");
			return "auth/admin/login";
		}
		User user = userService.findByUsername(login.getUsername()).get();
		if (user.getRole() != Role.ROLE_ADMIN) {
			model.addAttribute("error", "Tài khoản không phải là tài khoản admin");
			return "auth/admin/login";
		}
		securityService.autoLogin(login.getUsername(), login.getPassword());
		return "redirect:/home";
	}

	@GetMapping(value = "/register")
	public String register(Register register) {
		if (securityService.isAuthenticated()) {
			return "redirect:/home";
		}
		return "auth/admin/register";
	}

	@PostMapping(value = "/register/submit")
	public String registerSubmit(Model model, @Valid @ModelAttribute(name = "register") Register register,
			BindingResult result, HttpServletRequest request, HttpServletResponse response) {
		securityService.logout(request, response);
		if (result.hasErrors()) {
			model.addAttribute("error", "Lỗi định dạng");
			return "auth/admin/register";
		}
		if (userService.existsByUsername(register.getUsername())) {
			model.addAttribute("error", "Tên đăng nhập đã được sử dụng");
			return "auth/admin/register";
		}
		if (userService.existsByEmail(register.getEmail())) {
			model.addAttribute("error", "Email đã được sử dụng");
			return "auth/admin/register";
		}
		//String email = register.getEmail();
		//MailInfo mailInfo = new MailInfo(email, "Đăng ký thành công", , MailType.FORGOT);
		User user = new User();
		user.setUsername(register.getUsername());
		user.setEmail(register.getEmail());
		user.setPassword(register.getPassword());
		user.setLogin(true);
		user.setRole(Role.ROLE_ADMIN);
		userService.saveOrUpdate(user);
		
		sendRegistrationEmail(user.getEmail(), MailType.REGISTER);
		return "redirect:/auth/login";
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
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		securityService.logout(request, response);
		return "redirect:/auth/login";
	}

	@GetMapping(value = "/forgot-password")
	public String forgotPassword() {
		return "auth/admin/forgot-password";
	}

	@PostMapping(value = "/forgot-password/submit")
	public String forgotPasswordSubmit(Model model, @RequestParam(name = "email") String email,
			HttpServletRequest request, HttpServletResponse response) {
		securityService.logout(request, response);
		if (!userService.existsByEmail(email)) {
			model.addAttribute("error", "Email không tồn tại tài khoản nào");
			return "auth/admin/forgot-password";
		}
		User user = userService.findByEmail(email).get();
		if (user.getRole() != Role.ROLE_ADMIN) {
			model.addAttribute("error", "Email không phải là tài khoản admin");
			return "auth/admin/forgot-password";
		}
		String baseUrl = ServletUriComponentsBuilder.fromRequestUri(request).replacePath(null).build().toUriString();
		Object[] object = new Object[1];
		object[0] = baseUrl + "/auth/forgot-password/reset-password?reset="
				+ CryptionAES.encrypt(user.getUsername(), "MollaShopSpringBootAndThymeleaf");
		List<Object[]> list = new ArrayList<>();
		list.add(object);
		MailInfo mailInfo = new MailInfo(email, "Quên mật khẩu", list, MailType.FORGOT);
		System.out.println(list);
		System.out.println(mailInfo);
		
		try {mailerService.send(mailInfo);
		} catch (MessagingException e) {
			e.printStackTrace();
			model.addAttribute("error", "Gửi emai không thành công");
			return "auth/admin/forgot-password";
		}
		model.addAttribute("message", "Một thông báo quên mật khẩu đã gửi tới email của bạn");
		return "auth/admin/forgot-password";
	}

	@GetMapping(value = "/forgot-password/reset-password")
	public String resetPassword(@RequestParam(name = "reset") String reset) {
		String username = CryptionAES.decrypt(reset, "MollaShopSpringBootAndThymeleaf");
		session.set("reset-password", username);
		return "auth/admin/reset-password";
	}

	@PostMapping(value = "/forgot-password/reset-password/submit")
	public String resetPasswordSubmit(Model model, @RequestParam(name = "password") String password,
			@RequestParam(name = "againPassword") String againPassword, HttpServletRequest request,
			HttpServletResponse response) {
		securityService.logout(request, response);
		if (!password.equals(againPassword)) {
			model.addAttribute("error", "Mật khẩu xác nhận không khớp với mật khẩu. Vui lòng nhập lại");
			return "auth/admin/reset-password";
		}
		String username = session.get("reset-password");
		Optional<User> user = userService.changePassword(username, password);
		
		String baseUrl = ServletUriComponentsBuilder.fromRequestUri(request).replacePath(null).build().toUriString();
		Object[] object = new Object[2];
		object[0] = baseUrl + "/auth/login";
		object[1] = user.get().getUsername();
		List<Object[]> list = new ArrayList<>();
		list.add(object);
		MailInfo mailInfo = new MailInfo(user.get().getEmail(), "Dịch vụ", list, MailType.SUCCESS_SERVICE);
		try {
			mailerService.send(mailInfo);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		session.remove("reset-password");
		return "redirect:/auth/login";
	}
}
