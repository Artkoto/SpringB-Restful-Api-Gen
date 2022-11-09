package ${{package}}.model${{modelSusPackage}};

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import javax.persistence.*;
/* import java.io.Serializable; */ //TODO

@Entity
@Data
@Table(name = "${{modelName,}}")
/*@Inheritance(strategy = InheritanceType.SINGLE_TABLE)*/ //TODO
/*@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)*/ //TODO
public /*abstract*/ class ${{modelName^}} /*implements Serializable*/ { //TODO

    @Id
    @GeneratedValue(strategy =  GenerationType.IDENTITY)
    private Long id;

    //list of attributes exemple (TODO Delete)
    // simple attribute
    /* @JsonProperty("jsonProperty")
    @Column(name = "columnName" ,length = (50) , unique = false, nullable = true)
    private String attributName; */

    // date
    /* @Temporal(TemporalType.TIMESTAMP)
    @JsonProperty("jsonProperty")
    @Column(name = "columnName" , , unique = false, nullable = true)
    private Date date; */

    // use of the current date
    /* @Temporal(TemporalType.TIMESTAMP)
    @JsonProperty("jsonProperty")
    @Column(name = "columnName" , , unique = false, nullable = true)
    private Date creationTime = Date.from(Instant.from(ZonedDateTime.now(ZoneId.of("Europe/Paris")))); */

    // association (*,1)
    /* @JsonProperty("modelName")
    @ManyToOne(cascade = CascadeType.DETACH)
    @JoinColumn(name = "xxx_id", nullable = false)
    @JsonIdentityInfo(generator= ObjectIdGenerators.PropertyGenerator.class, property="id")
    @JsonIdentityReference(alwaysAsId=true)
    private ModelName modelName; */

    // association (1,*)
    /* @JsonProperty("modelName")
    @OneToMany(mappedBy = "mappedAtributName")
    @JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
    @JsonIdentityReference(alwaysAsId=true)
    private List<ModelName> attriutName; */

    // association (1,*)
    /* @JsonProperty("modelName")
    @OneToMany(mappedBy = "mappedAtributName")
    @JsonBackReference
    private List<ModelName> attriutName; */ 

    // association (*,*)
    /* @JsonProperty("modelName")
    @ManyToMany
    @JoinTable(name = "joinTableName",
             joinColumns = @JoinColumn(name = "xxx_id"),
             inverseJoinColumns = @JoinColumn(name = "yyy_id"))
    @JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
    @JsonIdentityReference(alwaysAsId=true)
    private Set<ModelName> attriutName; */

    // association (*,*) bi-directional
    /* @JsonProperty("modelName")
    @ManyToMany(mappedBy = "mappedAtributeName")
    @JsonIgnore
    private Set<ModelName> attriutName; */

    // association (1,1)
    /* @OneToOne
    @JoinColumn(name = "mappedAtributeName")
    private ModelName modelName; */

    //Attributes
    @JsonProperty("${{modelName,}}AttributeExemple")
    @Column(name = "${{modelName,}}AttributeExemple" ,length = (50) , unique = false, nullable = true)
    private String ${{modelName,}}AttributeExemple;


    //Methods
    /**
     * @param item
     */
    public void copyFrom(${{modelName^}} item){
        if(item == null) {return;}
        this.set${{modelName^}}AttributeExemple(item.get${{modelName^}}AttributeExemple());
        //TODO complete
    }
}
