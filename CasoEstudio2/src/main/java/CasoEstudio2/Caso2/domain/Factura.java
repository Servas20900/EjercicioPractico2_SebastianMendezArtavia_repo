package CasoEstudio2.Caso2.domain;


import java.util.Date;
import jakarta.persistence.*;
import java.io.Serializable;
import lombok.Data;



@Data
@Entity
@Table(name="factura")
public class Factura implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id_factura")
    private Long id_factura;
    private Long id_usuariu;
    private Date fecha;
    private double total;
    private int estado; 

    @ManyToOne
    @JoinColumn(name = "id_usuario", nullable = false) 
    private Usuario usuario;

    public Factura() {
    }

    public Factura(Long id_factura, Long id_usuariu, Date fecha, double total, int estado, Usuario usuario) {
        this.id_factura = id_factura;
        this.id_usuariu = id_usuariu;
        this.fecha = fecha;
        this.total = total;
        this.estado = estado;
        this.usuario = usuario;
    }

}