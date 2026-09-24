package com.smartcarbo.model.service;

import com.smartcarbo.model.entity.Usuario;
import com.smartcarbo.model.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    public Usuario autenticar(String email, String senha) {
        
        return usuarioRepository
        .findByEmailAndSenha(email, senha)
        .orElse(null);
    }

}
