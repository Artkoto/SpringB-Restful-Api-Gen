package ${{package}}.controller${{modelSusPackage}};

import ${{package}}.model${{modelSusPackage}}.${{modelName^}};
import ${{package}}.service${{modelSusPackage}}.${{modelName^}}Service;

import io.swagger.v3.oas.annotations.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/${{modelName,}}s") //TODO The path of your resource must correspond by convention to the plural of your model
public class ${{modelName^}}Controller {

    @Autowired
    private ${{modelName^}}Service ${{modelName,}}Service;

    /** 
     * @return number of ${{modelName,}}
     */
    @GetMapping("/total")
    @Operation(summary = "Gets total number of ${{modelName,}}", description = "Gets **total number** of ${{modelName,}}")
    public ResponseEntity<Long> count() {
        try {
        return ResponseEntity.ok(${{modelName,}}Service.count());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null) ;
        }
    }
    
    /** 
     * @param id
     * @return ${{modelName,}} with the identifier <id>
     */
    @GetMapping("/{id}")
    @Operation(summary = "Gets a ${{modelName,}} by ID", description = "${{modelName,}} with the identifier **ID**")
    public ResponseEntity<Optional<${{modelName^}}>> getById(@PathVariable("id") long id) {
        try {
            Optional<${{modelName^}}> item  = ${{modelName,}}Service.getById(id);
            return ResponseEntity.ok(item);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null) ;
        }
    }
       
    /** 
     * @return All ${{modelName,}}s
     */
    @GetMapping()
    @Operation(summary = "gets all ${{modelName,}}s", description = "Gets **all** the ${{modelName,}}s")
    public ResponseEntity<Iterable<${{modelName^}}>> getAll() {
        try {
            Iterable<${{modelName^}}> items  = ${{modelName,}}Service.getAll();
            return ResponseEntity.ok(items);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null) ;
        }
    }
      
    /** 
     * @param newItem
     * @return saved item
     */
    @PostMapping()
    @Operation(summary = "Create new ${{modelName,}}", description = "Create **new** ${{modelName,}}")
    public ResponseEntity<${{modelName^}}> create(@RequestBody ${{modelName^}} newItem) {
        try {
            ${{modelName^}} savedItem  = ${{modelName,}}Service.create(newItem);
            return ResponseEntity.ok(savedItem);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null) ;
        }
    }
       
    /** 
     * @param newItems
     * @return list of saved items
     */
    @PostMapping("/selected")
    @Operation(summary = "Create new ${{modelName,}}s", description = "Create **new** ${{modelName,}}s")
    public ResponseEntity<Iterable<${{modelName^}}>> multipleCreate(@RequestBody Iterable<${{modelName^}}> newItems) {
        try {
            Iterable<${{modelName^}}> savedItems  = ${{modelName,}}Service.multipleCreate(newItems);
            return ResponseEntity.ok(savedItems);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null) ;
        }
    }
    
    /** 
     * @param id
     * @param updatedItem
     * @return {@return the modified item} {@code null} if unknown.
     */
    @PutMapping("/{id}")
    @Operation(summary = "Modify ${{modelName,}}", description = "**Modify** ${{modelName,}}")
    public ResponseEntity<${{modelName^}}> update(@PathVariable("id") Long id, @RequestBody ${{modelName^}} updatedItem) {
        try {
            ${{modelName^}} savedItem  = ${{modelName,}}Service.update(id, updatedItem);
            if (savedItem == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
            }
            return ResponseEntity.ok(savedItem);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null) ;
        }
    }
 
    /** 
     * @param id : ${{modelName,}} ID to be deleted 
     * @return The status of the delete request
     */
    @DeleteMapping("/{id}")
    @Operation(summary = "Delete a ${{modelName,}} by ID", description = "**Delete** a ${{modelName,}} by **ID**")
	public ResponseEntity<HttpStatus> deleteById(@PathVariable("id") long id) {
		try {
			${{modelName,}}Service.deleteById(id);
			return ResponseEntity.ok(HttpStatus.NO_CONTENT);
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null) ;
		}
	}

     
    /** 
     * @param ids
     * @return The status of the delete request
     */
    @DeleteMapping("/selected")
    @Operation(summary = "Multiple deletion", description = "Delete any ${{modelName,}} whose **ID is in the list** ")
	public ResponseEntity<HttpStatus> multipleDeleteById(@RequestBody Iterable<Long> ids) {
		try {
			${{modelName,}}Service.deleteAllById(ids);
			return ResponseEntity.ok(HttpStatus.NO_CONTENT);
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null) ;
		}
	}

}
