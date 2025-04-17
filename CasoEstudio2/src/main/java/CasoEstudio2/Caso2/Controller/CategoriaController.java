package CasoEstudio2.Caso2.Controller;

import CasoEstudio2.Caso2.domain.Categoria;
import CasoEstudio2.Caso2.service.CategoriaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/categoria")
public class CategoriaController {

    @Autowired
    private CategoriaService categoriaService;

    @GetMapping("/listado")
    public String listarCategorias(Model model) {
        var categorias = categoriaService.listarCategorias();
        model.addAttribute("categorias", categorias);
        return "private/categoria/listado"; 
    }

    @GetMapping("/nueva")
    public String nuevaCategoria(Model model) {
        model.addAttribute("categoria", new Categoria());
        return "private/categoria/formulario"; 
    }

    @PostMapping("/guardar")
    public String guardar(@ModelAttribute Categoria categoria, BindingResult result) {
        if (result.hasErrors()) {
            return "private/categoria/formulario";
        }
        categoriaService.guardar(categoria);
        return "redirect:/categoria/listado";
    }

    @GetMapping("/editar/{id}")
    public String editar(@PathVariable("id") Long id, Model model) {
        Categoria categoria = new Categoria();
        categoria.setIdCategoria(id);
        categoria = categoriaService.encontrarCategoria(categoria);
        model.addAttribute("categoria", categoria);
        return "private/categoria/formulario";
    }

    @GetMapping("/eliminar/{id}")
    public String eliminar(@PathVariable("id") Long id) {
        Categoria categoria = new Categoria();
        categoria.setIdCategoria(id);
        categoriaService.eliminar(categoria);
        return "redirect:/categoria/listado";
    }
}
