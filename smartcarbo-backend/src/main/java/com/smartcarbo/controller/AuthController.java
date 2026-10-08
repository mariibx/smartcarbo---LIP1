package com.smartcarbo.controller;

import com.smartcarbo.dto.LoginRequest;
import com.smartcarbo.dto.LoginResponse;
import com.smartcarbo.model.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

@Autowired
private AuthService authService;

@PostMapping("/login")
public ResponseEntity<LoginResponse> login(@RequestBody LoginRequest loginRequest) {

    LoginResponse resposta = authService.autenticar(
            loginRequest.getEmail(),
            loginRequest.getSenha()
    );

    if (resposta == null) {
        return ResponseEntity
                .status(HttpStatus.UNAUTHORIZED)
                .build();
    }

    return ResponseEntity.ok(resposta);
}

}
