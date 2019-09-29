package com.example.helloworld;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.net.InetAddress;
import java.net.UnknownHostException;

@SpringBootApplication
public class HelloworldApplication {

	@Value("${TARGET:World}")
	String target;

	@RestController
	class HelloworldController {
		@GetMapping("/")
		String hello() {
			InetAddress ip;
			String hostname;
			try {
				ip = InetAddress.getLocalHost();
				hostname = ip.getHostName();
				return "<h1>Hello " + target + "!</h1><br>Hostname:"+hostname;
			} catch (UnknownHostException e) {
				return e.toString();
			}
		}
	}

	public static void main(String[] args) {
		SpringApplication.run(HelloworldApplication.class, args);
	}
}
