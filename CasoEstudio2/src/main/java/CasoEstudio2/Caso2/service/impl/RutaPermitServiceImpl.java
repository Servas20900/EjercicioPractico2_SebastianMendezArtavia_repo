package CasoEstudio2.Caso2.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import CasoEstudio2.Caso2.Dao.RutaPermitDao;
import CasoEstudio2.Caso2.domain.RutaPermit;
import CasoEstudio2.Caso2.service.RutaPermitService;

import java.util.List;

@Service
public class RutaPermitServiceImpl implements RutaPermitService {

    @Autowired
    private RutaPermitDao rutaPermitDao;

    @Override
    @Transactional(readOnly = true)
    public List<RutaPermit> getRutasPermitidas() {
        return rutaPermitDao.findAll();
    }

    @Override
    @Transactional
    public void save(RutaPermit rutaPermit) {
        rutaPermitDao.save(rutaPermit);
    }

    @Override
    @Transactional
    public void delete(RutaPermit rutaPermit) {
        rutaPermitDao.delete(rutaPermit);
    }
}
