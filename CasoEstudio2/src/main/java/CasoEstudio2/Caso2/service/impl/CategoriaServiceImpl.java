package CasoEstudio2.Caso2.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import CasoEstudio2.Caso2.Dao.CategoriaDao;
import CasoEstudio2.Caso2.domain.Categoria;
import CasoEstudio2.Caso2.service.CategoriaService;

@Service
public class CategoriaServiceImpl implements CategoriaService {

    @Autowired
    private CategoriaDao categoriaDao;

    @Override
    public List<Categoria> listarCategorias() {
        return categoriaDao.findAll();
    }

    @Override
    public void guardar(Categoria categoria) {
        categoriaDao.save(categoria);
    }

    @Override
    public void eliminar(Categoria categoria) {
        categoriaDao.delete(categoria);
    }

    @Override
    public Categoria encontrarCategoria(Categoria categoria) {
        return categoriaDao.findById(categoria.getIdCategoria()).orElse(null);
    }
}
