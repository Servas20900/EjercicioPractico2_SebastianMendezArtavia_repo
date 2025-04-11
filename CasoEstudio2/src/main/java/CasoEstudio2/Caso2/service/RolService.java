package CasoEstudio2.Caso2.service;

import CasoEstudio2.Caso2.domain.Rol;
import java.util.List;

public interface RolService {
    List<Rol> getRoles();
    Rol getRol(Long idRol);
    void save(Rol rol);
    void delete(Rol rol);
}
