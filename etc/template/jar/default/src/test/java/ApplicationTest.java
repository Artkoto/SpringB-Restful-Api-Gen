package ${{package}};

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;


import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;

import static org.hamcrest.CoreMatchers.is;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;


@SpringBootTest
@AutoConfigureMockMvc
public class ${{appName^}}Test {
    @Autowired
    public MockMvc mockMvc;

    @BeforeEach
    void init() {

        try {
            System.out.println("write your test");

        } catch (Exception e) {
            e.printStackTrace();
        }

    }


    @Test
    void contextLoads()  throws Exception {
        //TODO
        mockMvc.perform(get("/yoururl"))
                .andExpect(status().isOk()).andExpect(jsonPath("$[1].yourVar", is("value")));
    }
}
