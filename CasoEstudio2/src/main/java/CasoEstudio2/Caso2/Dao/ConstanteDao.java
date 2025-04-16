package CasoEstudio2.Caso2.Dao;

import org.springframework.data.jpa.repository.JpaRepository;
import CasoEstudio2.Caso2.domain.Constante;

public interface ConstanteDao 
        extends JpaRepository<Constante,Long> {
    
    public Constante findByAtributo(String stributo);
}
