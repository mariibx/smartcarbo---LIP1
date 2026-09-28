package com.smartcarbo.controller;

import com.smartcarbo.model.entity.Usuario;
import com.smartcarbo.model.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private AuthService authService;

    @PostMapping("/signin")
    public Usuario login(@RequestBody Usuario usuario) {

        return authService.autenticar(
                usuario.getEmail(),
                usuario.getSenha()
        );
    }
}