package com.smartcarbo.model.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smartcarbo.model.entity.RegistroAlimentacao;
import com.smartcarbo.model.repository.RegistroAlimentacaoRepository;

@Service
public class RegistroAlimentacaoService {

    @Autowired
    private RegistroAlimentacaoRepository registroAlimentacaoRepository;

    public RegistroAlimentacao salvar(RegistroAlimentacao registro) {
        return registroAlimentacaoRepository.save(registro);
    }

    public List<RegistroAlimentacao> listar() {
        return registroAlimentacaoRepository.findAll();
    }

    public Optional<RegistroAlimentacao> buscarPorId(Long id) {
        return registroAlimentacaoRepository.findById(id);
    }

    public RegistroAlimentacao atualizar(Long id, RegistroAlimentacao registro) {
        registro.setId(id);
        return registroAlimentacaoRepository.save(registro);
    }

    public void excluir(Long id) {
        registroAlimentacaoRepository.deleteById(id);
    }
}