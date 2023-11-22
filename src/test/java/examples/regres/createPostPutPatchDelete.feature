Feature:

  Background: Url
    Given url "https://reqres.in/"
  #  And request  {"name": "burak" ,"job":  "devop"}
  #  And request {"name" :  "ali" , "job" :  "java"}

  Scenario: Create a user  with certain name and job and verify if it is created

    Given path "api/users"
    And request {"name": "han", "job" :  "talebe"}
    When method post
    Then status 201
    * print response
    * print response.id
    * print response.name
   # Given path "api/users"
   # And path response.id
   # When method get
   # Then status 200



  Scenario: Create a user  with certain name and job and verify if it is created

    Given path "api/users"
   # * def person = { "name" : "ali" , "job" : "tehlike" }
    * def person = { "name": "denis", "job" :  "yaramazcocuk" }
    And request person
    When method post
    Then status 201
    * print response
    * print response.id
    * match response.createdAt !=null
    * print response.createAt
    * match response.name == person.name
    * match response.job == person.job

   # Given path "api/users"
   # And path response.id
   # When method get
   # Then status 200



  Scenario Outline: Create multiple users with given data and verify if all of them are created

    Given path "api/users"
    * def person = { "name": "<name>", "job" :  "<job>" }
    And request person
    When method post
    Then status 201
    * print response
    * print response.id
    * print response.name

    Examples:

      | name | job   |
      | ayse | scrum |
      | ali  | PO    |
      | veli | sdet  |


  @wip
  Scenario:Update one user with "put" keyword

    Given path "api/users"
    Given path id =1
    * def person = {"name": "han dan", "job" :  "talebe"}
    And request person
    When method put
    Then method 200
     # * match response.createdAt !=null
    * print response
    * match response.name == person.name
    * match response.job == person.job





