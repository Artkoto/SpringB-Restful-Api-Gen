package ${{package}}.repository${{modelSusPackage}};

import ${{package}}.model${{modelSusPackage}}.${{modelName^}};
import org.springframework.data.jpa.repository.JpaRepository;
/* import org.springframework.data.jpa.repository.Query; */
import org.springframework.stereotype.Repository;

@Repository
public interface ${{modelName^}}Repository extends JpaRepository<${{modelName^}},Long> {
    
    //exemples
    /* @Query("SELECT e FROM tableName AS e WHERE e.attribut1 =?1 or e.attribut2 =?1")
    List<ModelName> findByAttribut(type attribut) ; */
    
    /* @Query("SELECT e.attribut FROM tableName AS e WHERE e.id=?1")
    Optional<Drone> findByxxx(type attribut) ; */

    //Queries

}
