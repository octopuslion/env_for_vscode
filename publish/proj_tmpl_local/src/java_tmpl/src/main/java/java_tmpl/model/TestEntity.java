package java_tmpl.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

import lombok.AllArgsConstructor;
import lombok.Data;

@Table(name = "test_tbl")
@Data
@AllArgsConstructor
public class TestEntity {

    @Id
    private final Long id;
    private String text;
}
