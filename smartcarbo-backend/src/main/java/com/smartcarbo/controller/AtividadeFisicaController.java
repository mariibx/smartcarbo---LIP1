package com.smartcarbo.controller;

import com.smartcarbo.model.entity.AtividadeFisica;
import com.smartcarbo.model.service.AtividadeFisicaService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/v1/atividades-fisicas")
public class AtividadeFisicaController {

    @Autowired
    private AtividadeFisicaService atividadeFisicaService;

    @GetMapping
    public List<AtividadeFisica> listar() {
        return atividadeFisicaService.listar();
    }

    @PostMapping
    public AtividadeFisica salvar(
            @RequestBody AtividadeFisica atividadeFisica) {

        return atividadeFisicaService.salvar(atividadeFisica);
    }

    @GetMapping("/{id}")
    public Optional<AtividadeFisica> buscarPorId(
            @PathVariable Long id) {

        return atividadeFisicaService.buscarPorId(id);
    }

    @PutMapping("/{id}")
    public AtividadeFisica atualizar(
            @PathVariable Long id,
            @RequestBody AtividadeFisica atividadeFisica) {

        return atividadeFisicaService.atualizar(id, atividadeFisica);
    }

    @DeleteMapping("/{id}")
    public void excluir(@PathVariable Long id) {
        atividadeFisicaService.excluir(id);
    }
}