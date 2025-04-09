package CasoEstudio2.Caso2.Dao;


import CasoEstudio2.Caso2.domain.Venta;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VentaDao extends JpaRepository <Venta,Long> {
     
}