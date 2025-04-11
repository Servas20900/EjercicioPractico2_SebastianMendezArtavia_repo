package CasoEstudio2.Caso2;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import CasoEstudio2.Caso2.Dao.RutaDao;
import CasoEstudio2.Caso2.Dao.RutaPermitDao;
import CasoEstudio2.Caso2.service.UsuarioDetailsService;


@Configuration
@EnableWebSecurity
public class ProjectConfig {

    @Autowired
    private UsuarioDetailsService userDetailsService;

    @Autowired
    private RutaDao rutaDao;

    @Autowired
    private RutaPermitDao rutaPermitDao;

    // Configuración de seguridad de la aplicación
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(authz -> {
                // Rutas públicas (sin autenticación requerida)
                rutaPermitDao.findAll().forEach(ruta ->
                    authz.requestMatchers(ruta.getPatron()).permitAll()
                );

                // Rutas protegidas (requiere rol específico)
                rutaDao.findAll().forEach(ruta ->
                    authz.requestMatchers(ruta.getPatron()).hasRole(ruta.getRolName())
                );

                // Resto de las rutas protegidas
                authz.anyRequest().authenticated();
            })
            .formLogin(form -> form
                .loginPage("/login")  // Página de login personalizada
                .defaultSuccessUrl("/", true)  // Redirige al home después del login exitoso
                .permitAll()
            )
            .logout(logout -> logout
                .permitAll()  // Permite logout sin restricciones
            );

        return http.build();
    }

    // Configuración global de autenticación (dao provider)
    @Autowired
    public void configurerGlobal(AuthenticationManagerBuilder builder) throws Exception {
        builder.userDetailsService(userDetailsService)
               .passwordEncoder(passwordEncoder());
    }

    // Configuración del encoder de contraseñas
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(); // Usamos BCrypt para codificar las contraseñas
    }

    // Configuración de AuthenticationManager (necesario para autenticar)
    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }
}
