package java_tmpl.dao;

import java.util.Optional;

import org.springframework.data.relational.core.mapping.Table;
import org.springframework.data.repository.CrudRepository;

import java_tmpl.model.TestEntity;

@Table(name = "test_tbl")
public interface TestRepository extends CrudRepository<TestEntity, Long> {

    public Optional<TestEntity> findById(Long id);
}
