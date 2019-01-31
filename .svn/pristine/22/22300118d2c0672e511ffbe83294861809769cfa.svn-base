package com.upc.common.exception.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class EgumeExceptionController {

	@GetMapping("/500_Error_Page")
	public String serverErr() {
		return "error/500";
	}
	
	@GetMapping("/400_Error_Page")
	public String badRequestErr() {
		
		return "error/400";
	}
	
	@GetMapping("/error_Page")
	public String defaultErr() {
		
		return "error/error";
	}
}
