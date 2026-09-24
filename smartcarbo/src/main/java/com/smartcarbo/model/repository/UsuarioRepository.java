package com.smartcarbo.model.repository;

import com.smartcarbo.model.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UsuarioRepository extends JpaRepository<Usuario, Long> {

}