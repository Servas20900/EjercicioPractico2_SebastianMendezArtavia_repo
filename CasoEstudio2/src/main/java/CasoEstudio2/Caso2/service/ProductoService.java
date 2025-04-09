package CasoEstudio2.Caso2.service;

import CasoEstudio2.Caso2.domain.Producto;
import java.util.List;


public interface ProductoService {

    // Devuelve todos los productos sin filtrar por "activo"
    public List<Producto> getProductos(); 

    // Se obtiene un Producto, a partir del id de un producto
    public Producto getProducto(Producto producto);

    // Se inserta un nuevo producto si el id del producto esta vacío
    // Se actualiza un producto si el id del producto NO esta vacío
    public void save(Producto producto);

    // Se elimina el producto que tiene el id pasado por parámetro
    public void delete(Producto producto);

    // Lista de productos con precio entre ordenados por descripción
    public List<Producto> findByPrecioBetweenOrderByDescripcion(double precioInf, double precioSup);

}

