package java_tmpl.config;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import java_tmpl.dao.TestRepository;
import java_tmpl.model.TestEntity;

@Component
@Order(value = 1)
public class GlobalIntializer implements ApplicationRunner {

    private final String springSqlInitMode;
    private final TestRepository testRepo;

    public GlobalIntializer(
            @Value("${spring.sql.init.mode}") String springSqlInitMode,
            @Autowired TestRepository testRepo) {
        this.springSqlInitMode = springSqlInitMode;
        this.testRepo = testRepo;
    }

    @Override
    public void run(ApplicationArguments args) throws Exception {
        // run when launching spring boot.
        if (springSqlInitMode.equals("always")) {
            if (args.getOptionNames().stream().anyMatch(
                    name -> name.equals("spring.profiles.active") &&
                            args.getOptionValues(name).stream().anyMatch(value -> value.equals("dev")))) {
                initDataFor(1L, "development");
            } else {
                initDataFor(1L, "production");
            }
        }
    }

    private void initDataFor(Long id, String env) throws Exception {
        Optional<TestEntity> optionalEntity = testRepo.findById(id);
        if (optionalEntity.isPresent()) {
            TestEntity entity = optionalEntity.get();
            entity.setText(entity.getText() + " From: " + env + ".");
            testRepo.save(entity);
        }
    }
}