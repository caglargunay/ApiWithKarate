Feature:List Users Functionality


  Background: Url
    Given url "https://reqres.in/"

  Scenario:List all users
    Given path "/api/users"
    Given param page = 2
    When method get
   # And print response
    Then status 200
    When print response.data


  Scenario: Verify Content-Type
    Given path "/api/users"
    And param page = 1
    When method get
    Then status 200
    * match karate.response.header("Content-Type") == "application/json; charset=utf-8"


  Scenario: Verify Host
    Given path "/api/users"
    And param page = 1
    When method get
    Then status 200
    * match karate.response.header("Transfer-Encoding") == "chunked"
    * match karate.request.header("Host") ==  "reqres.in"
    * match karate.request.headers.Host ==  "reqres.in"


  Scenario: Check response time
    Given path "api/user"
    And param page = 1
    When method get
    Then status 200
    And assert responseTime<250


  Scenario: Verify page , per-page , total ,total_pages
    Given path "api/user"
    And param page = 2
    When method get
    Then status 200
    * match response.page == 2
    * match response.per_page == 6
    * match response.total == 12
    * match response.total_pages == 2
    * assert response.page == 2
    * assert response.per_page == 6
    * assert response.total == 12
    * assert response.total_pages == 2


  Scenario Outline:  List all users
    Given path "api/users"
    And param page = "<pageNumber>"
    When method get
    Then status 200
    * print response.data
    * def firstName1 = response.data[0].first_name

    Examples:
      | pageNumber |
      | 1          |
      | 2          |


  Scenario: Check if Support url is working
    Given path "api/user"
    And param page = 2
    When method get
    Then status 200
    * def link = response.support.url
    * print link
    Given url link
    When method get
    Then status 200


  Scenario: List all user first names from first page
    Given path "api/users"
    And param page = 1
    When method get
    Then status 200
    * def firstNames = response.data.map(i=>i.first_name)
    * print firstNames


  Scenario: List all user first names from first page and second page
    Given path "api/users"
    And param page = 1
    When method get
    Then status 200
    * def firstNames = response.data.map(i=>i.first_name)
    * print firstNames
    Given path "api/users"
    And param page = 2
    When method get
    Then status 200
    * def firstNames = response.data.map(i=>i.first_name)
    * print firstNames


  Scenario Outline: List all users names whose ids are odd

    Given path "api/users"
    And param page = "<pagesNumber>"
    When method get
    Then status 200
    * def userList = response.data
    * def listOddIds =
    """
    function (list) {
     var  arr =[]
     for(var i = 0; i <list.length ; i++) {
      if(list[i].id % 2 == 1) {
      arr.push(list[i])
      }
    }
    return arr;
    }
    """
    * print  listOddIds(userList)
    Examples:
      | pagesNumber |
      | 1           |
      | 2           |


  Scenario Outline: :Check if each email address contains first name

    Given path "api/users"
    And param page = "<pagesNumber>"
    When method get
    Then status 200
    * def  userList = response.data
    * def check =
    """
    function (list){

        for(var i = 0; i <list.length ; i++) {

          var firstName = list[i].first_name.toLowerCase()
          var email=list[i].email.toLowerCase()
          if(!email.includes(firstName)){
            return  false
          }
        }
          return true
}
    """
    * match check(userList) == true
    Examples:
      | pagesNumber |
      | 1           |
      | 2           |

  @wip
  Scenario Outline:Verify if the ids and first_names match
    Given path "api/users"
    And param page = "<pagesNumber>"
    When method get
    Then status 200
    * def expectedPerson = "<id>" + " "+ "<firstName>"
    * def actualPerson = response.data.map(i=>i.id+ " "+i.first_name)

    * match  actualPerson contains expectedPerson

    Examples:
      | pagesNumber | id | firstName |
      | 1          | 1  | George    |
      | 1          | 2  | Janet     |
      | 1          | 3  | Emma      |
      | 1          | 4  | Eve       |
      | 2          | 7  | Michael   |
      | 2          | 8  | Lindsay   |
      | 2          | 9  | Tobias    |
      | 2          | 10 | Byron     |