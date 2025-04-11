package CasoEstudio2.Caso2.domain;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
@Table(name = "ruta")
public class Ruta {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idRuta;
    private String patron;
    private String rolName;

}
