package com.smartcarbo.model.service;

import com.smartcarbo.model.entity.AtividadeFisica;
import com.smartcarbo.model.repository.AtividadeFisicaRepository;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.Optional;

@Service
public class AtividadeFisicaService {

    @Autowired
    private AtividadeFisicaRepository atividadeFisicaRepository;

    public AtividadeFisica salvar(AtividadeFisica atividadeFisica) {
        return atividadeFisicaRepository.save(atividadeFisica);
    }

    public List<AtividadeFisica> listar() {
        return atividadeFisicaRepository.findAll();
    }

    public Optional<AtividadeFisica> buscarPorId(Long id) {
        return atividadeFisicaRepository.findById(id);
    }

    public AtividadeFisica atualizar(Long id, AtividadeFisica atividadeFisica) {

        AtividadeFisica atividadeExistente = atividadeFisicaRepository
                .findById(id)
                .orElseThrow(() ->
                        new ResponseStatusException(
                                HttpStatus.NOT_FOUND,
                                "Atividade física não encontrada"
                        )
                );

        BeanUtils.copyProperties(atividadeFisica, atividadeExistente, "id");

        return atividadeFisicaRepository.save(atividadeExistente);
    }

    public void excluir(Long id) {
        atividadeFisicaRepository.deleteById(id);
    }
}