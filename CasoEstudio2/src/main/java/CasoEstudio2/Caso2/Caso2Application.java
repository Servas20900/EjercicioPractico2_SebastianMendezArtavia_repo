package CasoEstudio2.Caso2;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@SpringBootApplication
public class Caso2Application {

	public static void main(String[] args) {
		SpringApplication.run(Caso2Application.class, args);
    	PasswordEncoder encoder = new BCryptPasswordEncoder();
    	System.out.println(encoder.matches("123", "$2a$10$P1.w58XvnaYQUQgZUCk4aO/RTRl8EValluCqB3S2VMLTbRt.tlre."));


	}

}
