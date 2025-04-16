package CasoEstudio2.Caso2.Dao;


import org.springframework.data.jpa.repository.JpaRepository;
import CasoEstudio2.Caso2.domain.Categoria;

public interface CategoriaDao extends JpaRepository <Categoria,Long> {
    
}

