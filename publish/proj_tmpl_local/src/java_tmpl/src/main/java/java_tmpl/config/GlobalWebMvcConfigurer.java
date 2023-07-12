package java_tmpl.config;

import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpHeaders;
import org.springframework.web.servlet.config.annotation.CorsRegistration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class GlobalWebMvcConfigurer implements WebMvcConfigurer {

    private final String crossOriginAllowAll;
    private final List<String> crossOriginHosts;
    private final String webResourceWebPath;
    private final String webResourceResourcePath;

    public GlobalWebMvcConfigurer(
            @Value("${cross-origin.allow-all}") String crossOriginAllowAll,
            @Value("${cross-origin.hosts}") List<String> crossOriginHosts,
            @Value("${web-resrouce.web-path}") String webResourceWebPath,
            @Value("${web-resrouce.resource-path}") String webResourceResourcePath) {
        this.crossOriginAllowAll = crossOriginAllowAll;
        this.crossOriginHosts = crossOriginHosts;
        this.webResourceWebPath = webResourceWebPath;
        this.webResourceResourcePath = webResourceResourcePath;
    }

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        CorsRegistration registration = registry
                .addMapping("/**") // allow path, /** means no limit.
                .allowedMethods("*") // allow methods like GET, POST, * means no limit.
                .allowedHeaders("*")
                .allowCredentials(true). // allow cookie
                exposedHeaders(HttpHeaders.SET_COOKIE).maxAge(3600L); // means no pre request until 3600s.
        if (crossOriginAllowAll.equals("true")) {
            registration.allowedOriginPatterns("*");
        } else {
            registration.allowedOrigins(crossOriginHosts.stream().toArray(String[]::new));
        }
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler(webResourceWebPath + "/**")
                .addResourceLocations("file:" + webResourceResourcePath);
    }
}
