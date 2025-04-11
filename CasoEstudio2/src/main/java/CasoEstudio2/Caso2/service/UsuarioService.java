package CasoEstudio2.Caso2.service;

import CasoEstudio2.Caso2.domain.Usuario;
import java.util.List;

public interface UsuarioService {

    // Obtener todos los usuarios
    public List<Usuario> getUsuarios();

    // Obtener un usuario por su ID
    public Usuario getUsuario(Long idUsuario);

    // Obtener un usuario por su username
    public Usuario getUsuarioPorUsername(String username);

    // Verificar si un usuario existe por su username o correo
    public boolean existeUsuarioPorUsernameOCorreo(String username, String correo);

    // Guardar o actualizar un usuario
    public void save(Usuario usuario);

    // Eliminar un usuario por su ID
    public void delete(Long idUsuario);
}
