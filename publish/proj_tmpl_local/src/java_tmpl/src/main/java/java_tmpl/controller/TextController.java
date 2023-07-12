package java_tmpl.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java_tmpl.service.TextService;

@RestController
public class TextController {

    private final TextService textService;

    public TextController(@Autowired TextService imageService) {
        this.textService = imageService;
    }

    @GetMapping(value = "/text/{id}")
    public @ResponseBody Map<String, String> getImage(@PathVariable Long id) {
        Map<String, String> response = textService.getTextBy(id);
        return response;
    }
}
