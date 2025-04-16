package CasoEstudio2.Caso2.service;

import java.util.List;
import CasoEstudio2.Caso2.domain.Constante;

public interface ConstanteService {
    
    //Se obtiene un listado de registro de la tabla constante
    //en un array list de objetos Constante
    //Todos o sólo los activos...
    public List<Constante> getConstantes();
    
    public Constante getConstante(Constante constante);
    
    public Constante getConstantePorAtributo(String atributo);
    
    public void save(Constante constante);
    
    public void delete(Constante constante);
}
