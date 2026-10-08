package com.smartcarbo.model.service;

import com.smartcarbo.dto.LoginResponse;
import com.smartcarbo.model.entity.Usuario;
import com.smartcarbo.model.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

@Autowired
private UsuarioRepository usuarioRepository;

public LoginResponse autenticar(String email, String senha) {

    Usuario usuario = usuarioRepository
            .findByEmailAndSenha(email, senha)
            .orElse(null);

    if (usuario == null) {
        return null;
    }

    return new LoginResponse(
            usuario.getId(),
            usuario.getNome(),
            usuario.getEmail()
    );
}

}
