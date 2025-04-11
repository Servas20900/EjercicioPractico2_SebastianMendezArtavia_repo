package CasoEstudio2.Caso2.service.impl;

import CasoEstudio2.Caso2.Dao.RolDao;
import CasoEstudio2.Caso2.Dao.UsuarioDao;
import CasoEstudio2.Caso2.domain.Rol;
import CasoEstudio2.Caso2.domain.Usuario;
import CasoEstudio2.Caso2.service.UsuarioService;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UsuarioServiceImpl implements UsuarioService {

    @Autowired
    private UsuarioDao usuarioDao;
    
    @Autowired
    private RolDao rolDao;

    @Override
    @Transactional(readOnly = true)
    public List<Usuario> getUsuarios() {
        return usuarioDao.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public Usuario getUsuario(Long idUsuario) {
        return usuarioDao.findById(idUsuario).orElse(null);
    }

    @Override
    @Transactional(readOnly = true)
    public Usuario getUsuarioPorUsername(String username) {
        return usuarioDao.findByUsername(username);
    }

    @Override
    @Transactional(readOnly = true)
    public boolean existeUsuarioPorUsernameOCorreo(String username, String correo) {
        return usuarioDao.existsByUsernameOrCorreo(username, correo);
    }

    @Override
    @Transactional
    public void save(Usuario usuario) {
        // Verifica si el usuario ya existe
        if (existeUsuarioPorUsernameOCorreo(usuario.getUsername(), usuario.getCorreo())) {
            throw new IllegalArgumentException("El usuario o correo ya existe.");
        }
        
        // Guarda el usuario
        usuario = usuarioDao.save(usuario);
        
        // Si es un usuario nuevo, se crea el rol por defecto "USER"
        if (usuario.getIdUsuario() != null) {  // Verifica que el id no sea null (nuevo usuario)
            Rol rol = new Rol();
            rol.setNombre("ROLE_USER");
            rol.setIdUsuario(usuario.getIdUsuario());
            rolDao.save(rol);
        }
    }

    @Override
    @Transactional
    public void delete(Long idUsuario) {
        usuarioDao.deleteById(idUsuario);
    }
}
