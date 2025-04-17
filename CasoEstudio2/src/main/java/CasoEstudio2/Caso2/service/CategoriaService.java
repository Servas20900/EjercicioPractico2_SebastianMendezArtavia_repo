package CasoEstudio2.Caso2.service;

import java.util.List;
import CasoEstudio2.Caso2.domain.Categoria;

public interface CategoriaService { 
    List<Categoria> listarCategorias();
    
    void guardar(Categoria categoria);
    
    void eliminar(Categoria categoria);
    
    Categoria encontrarCategoria(Categoria categoria);
}
