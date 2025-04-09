package CasoEstudio2.Caso2.Dao;

import CasoEstudio2.Caso2.domain.Factura;
import org.springframework.data.jpa.repository.JpaRepository;


public interface FacturaDao extends JpaRepository <Factura,Long> {
     
}