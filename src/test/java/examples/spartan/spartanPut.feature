Feature:

  Background: Url
    * def spartanUrl = "http://18.205.156.230:8000/"
    Given url spartanUrl

  @wip
  Scenario:
    Given path "api/spartans"
    Given path id = 122
    * def person = {"gender" :"Female", "name": "Veysel","phone": 9988776655 }
    And request person
    When method put
    Then status 204
    * print response
    Given path "api/spartans"
    Given path id = 122
    When method get
    * print response
    * match response.name == person.name
    * match response.gender ==person.gender
    * match response.phone == person.phone
