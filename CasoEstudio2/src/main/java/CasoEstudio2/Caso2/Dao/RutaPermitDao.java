package CasoEstudio2.Caso2.Dao;

import org.springframework.data.jpa.repository.JpaRepository;
import CasoEstudio2.Caso2.domain.RutaPermit;

public interface RutaPermitDao extends JpaRepository<RutaPermit, Long> {

    // No se necesitan métodos especiales por ahora, JpaRepository te da todo
}