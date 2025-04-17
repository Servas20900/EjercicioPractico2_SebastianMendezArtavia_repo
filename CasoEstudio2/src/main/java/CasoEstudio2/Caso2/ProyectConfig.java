package CasoEstudio2.Caso2;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;

@Configuration
@EnableWebSecurity
public class ProyectConfig {

    private final UserDetailsService userDetailsService;

    public ProyectConfig(UserDetailsService userDetailsService) {
        this.userDetailsService = userDetailsService;
    }

    // Bean para codificar contraseñas usando BCrypt
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    // Bean para el AuthenticationManager que usa el userDetailsService y el passwordEncoder
    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authConfig) throws Exception {
        return authConfig.getAuthenticationManager();
    }

     @Bean
     public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
         http
              .authorizeHttpRequests((requests) -> requests
                  .requestMatchers("/", "/login", "/css/**", "/img/**", "/js/**, \"/private/**\" ").permitAll()
                  .requestMatchers("/categoria/**").authenticated()
                  .anyRequest().authenticated()
              )
             .formLogin((form) -> form
                 .loginPage("/login")
                 .defaultSuccessUrl("/private/home", true)
                 .permitAll()
             )
             .logout((logout) -> logout
                 .logoutSuccessUrl("/login?logout")
                 .permitAll()
             );

         return http.build();
     }
}
