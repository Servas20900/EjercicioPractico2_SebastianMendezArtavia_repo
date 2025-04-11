package CasoEstudio2.Caso2.service;

import CasoEstudio2.Caso2.domain.RutaPermit;
import java.util.List;

public interface RutaPermitService {
    List<RutaPermit> getRutasPermitidas();
    void save(RutaPermit rutaPermit);
    void delete(RutaPermit rutaPermit);
}
