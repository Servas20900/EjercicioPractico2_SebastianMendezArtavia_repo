package CasoEstudio2.Caso2.service.impl;

import CasoEstudio2.Caso2.Dao.RutaDao;
import CasoEstudio2.Caso2.domain.Ruta;
import CasoEstudio2.Caso2.service.RutaService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class RutaServiceImpl implements RutaService {

    @Autowired
    private RutaDao rutaDao;

    @Override
    @Transactional(readOnly = true)
    public List<Ruta> getRutas() {
        return rutaDao.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Ruta> getRutasPorRol(String rolName) {
        return rutaDao.findAll();
    }

    @Override
    @Transactional
    public void save(Ruta ruta) {
        rutaDao.save(ruta);
    }

    @Override
    @Transactional
    public void delete(Ruta ruta) {
        rutaDao.delete(ruta);
    }
}
