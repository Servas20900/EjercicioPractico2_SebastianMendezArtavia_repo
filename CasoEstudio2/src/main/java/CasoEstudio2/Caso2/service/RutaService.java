package CasoEstudio2.Caso2.service;

import CasoEstudio2.Caso2.domain.Ruta;
import java.util.List;

public interface RutaService {
    List<Ruta> getRutas();
    List<Ruta> getRutasPorRol(String rolName);
    void save(Ruta ruta);
    void delete(Ruta ruta);
}
