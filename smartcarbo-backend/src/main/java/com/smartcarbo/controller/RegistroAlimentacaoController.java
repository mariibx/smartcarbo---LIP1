package com.smartcarbo.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.smartcarbo.model.entity.RegistroAlimentacao;
import com.smartcarbo.model.service.RegistroAlimentacaoService;

@RestController
@RequestMapping("/api/v1/registros-alimentacao")
public class RegistroAlimentacaoController {

    @Autowired
    private RegistroAlimentacaoService registroAlimentacaoService;

    @GetMapping
    public List<RegistroAlimentacao> listar() {
        return registroAlimentacaoService.listar();
    }

    @PostMapping
    public RegistroAlimentacao salvar(
            @RequestBody RegistroAlimentacao registro) {
        return registroAlimentacaoService.salvar(registro);
    }

    @GetMapping("/{id}")
    public Optional<RegistroAlimentacao> buscarPorId(
            @PathVariable Long id) {
        return registroAlimentacaoService.buscarPorId(id);
    }

    @PutMapping("/{id}")
    public RegistroAlimentacao atualizar(
            @PathVariable Long id,
            @RequestBody RegistroAlimentacao registro) {
        return registroAlimentacaoService.atualizar(id, registro);
    }

    @DeleteMapping("/{id}")
    public void excluir(@PathVariable Long id) {
        registroAlimentacaoService.excluir(id);
    }
}

