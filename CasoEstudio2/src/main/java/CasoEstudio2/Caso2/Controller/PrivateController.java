package CasoEstudio2.Caso2.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PrivateController {

    @GetMapping("/private/home") 
    public String mostrarHome() {
        return "private/home";
    }
}