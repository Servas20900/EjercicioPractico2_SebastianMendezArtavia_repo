package CasoEstudio2.Caso2.service.impl;

import CasoEstudio2.Caso2.Dao.RolDao;
import CasoEstudio2.Caso2.domain.Rol;
import CasoEstudio2.Caso2.service.RolService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class RolServiceImpl implements RolService {

    @Autowired
    private RolDao rolDao;

    @Override
    @Transactional(readOnly = true)
    public List<Rol> getRoles() {
        return rolDao.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public Rol getRol(Long idRol) {
        return rolDao.findById(idRol).orElse(null);
    }

    @Override
    @Transactional
    public void save(Rol rol) {
        rolDao.save(rol);
    }

    @Override
    @Transactional
    public void delete(Rol rol) {
        rolDao.delete(rol);
    }
}
