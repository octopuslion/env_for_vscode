package java_tmpl.config;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.Writer;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

@ControllerAdvice
public class GlobalExceptionHandler {

    private final String globalExceptionType;
    private final String globalExceptionResponse;

    public GlobalExceptionHandler(
            @Value("${global-exception.type}") String globalExceptionType,
            @Value("${global-exception.response}") String globalExceptionResponse) {
        this.globalExceptionType = globalExceptionType;
        this.globalExceptionResponse = globalExceptionResponse;
    }

    @ExceptionHandler(value = Exception.class)
    public @ResponseBody String exceptionHandler(Exception exception) {
        Writer writter = new StringWriter();
        PrintWriter printWriter = new PrintWriter(writter);
        exception.printStackTrace(printWriter);
        String message = writter.toString();

        Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);
        logger.error(message);

        String response = globalExceptionType.equals("message") ? message : globalExceptionResponse;
        return response;
    }
}
