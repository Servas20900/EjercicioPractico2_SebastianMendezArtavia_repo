package CasoEstudio2.Caso2.Dao;

import CasoEstudio2.Caso2.domain.Producto;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;



public interface ProductoDao extends JpaRepository<Producto, Long> {
    
    
    public List<Producto> findByPrecioBetweenOrderByDescripcion(double precioInf, double precioSup);



}
