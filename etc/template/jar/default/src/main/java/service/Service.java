package ${{package}}.service${{modelSusPackage}};


import ${{package}}.repository${{modelSusPackage}}.${{modelName^}}Repository;
import ${{package}}.model${{modelSusPackage}}.${{modelName^}}; //à revoir
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class ${{modelName^}}Service {

    @Autowired
    private ${{modelName^}}Repository ${{modelName,}}Repository;

    /**  
     * @return number of items
     */
    public long count(){
        return ${{modelName,}}Repository.count();
    }

    /**
     * @param id  
     * @return the item with the identifier <id>
     */
    public Optional<${{modelName^}}> getById(final Long id){
        return ${{modelName,}}Repository.findById(id);
    }

    /**
     * @return All items
     */
    public Iterable<${{modelName^}}> getAll()   {
        return ${{modelName,}}Repository.findAll();
    }

    /**
     * @param newItem  
     * @return saved item
     */
    public ${{modelName^}} create(${{modelName^}} newItem){
        return ${{modelName,}}Repository.save(newItem);
    }

    /**
     * @param newItems  
     * @return list of saved items
     */
    public Iterable<${{modelName^}}> multipleCreate(Iterable<${{modelName^}}> newItems){
        return ${{modelName,}}Repository.saveAll(newItems);
    }

    /**
     * @param id :  Item ID to be modify 
     * @param updatedItem 
     * {@return the modified item} {@code null} if unknown.
     */
    public ${{modelName^}} update(final Long id, ${{modelName^}} updatedItem){
        if (${{modelName,}}Repository.existsById(id)) {
            ${{modelName^}} item = getById(id).get();
            item.copyFrom(updatedItem);
            return create(item);
        }
        return null;
    }

    /**
     * @param id : Item ID to be deleted 
     * @return void
     */
    public void  deleteById(final Long id){
        ${{modelName,}}Repository.deleteById(id);
    }

    /**
     * @param ids : List containing the IDs of the items to be deleted 
     * @return void
     */
    public void deleteAllById(Iterable<Long> ids ){
        ${{modelName,}}Repository.deleteAllById(ids);
    }
    
    //TODO complete
    
}
