package java_tmpl.service;

import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java_tmpl.dao.TestRepository;
import java_tmpl.model.TestEntity;

@Service
public class TextService {

    private final TestRepository testRepo;

    public TextService(@Autowired TestRepository testRepo) {
        this.testRepo = testRepo;
    }

    public Map<String, String> getTextBy(Long id) {
        Optional<TestEntity> optionalEntity = testRepo.findById(id);

        Map<String, String> data = optionalEntity.map(entity -> Map.ofEntries(
                Map.entry("text", entity.getText()))).orElse(null);
        return data;
    }
}
