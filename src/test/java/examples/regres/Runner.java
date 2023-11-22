package examples.regres;

import com.intuit.karate.junit5.Karate;

class Runner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("register").tags("@wip").relativeTo(getClass());
    }    

}
