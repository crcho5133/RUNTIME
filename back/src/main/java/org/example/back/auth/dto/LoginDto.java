package org.example.back.auth.dto;

import lombok.Data;
import lombok.Getter;

@Data
public class LoginDto {
	private String accessToken;
	private String fcmToken;
}
