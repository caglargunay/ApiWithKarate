Feature: Single user Functionality

  Background: Url
    Given url "https://reqres.in/"
    * def allUsers = read("classpath:examples/regres/data/users.json")


  Scenario:Verify id, email, first_name, last_name
    Given path "api/users/2"
    When method get
    Then status 200
    * assert response.data.id == 2
    * assert response.data.first_name == "Janet"
    * match response.data.last_name == "Weaver"
    * match response.data.email == "janet.weaver@reqres.in"


  Scenario Outline: Check user list includes specific users with below ids
    Given path "api/users"
    And path "<id>"
    When method get
    Then status 200
    * def oneUser = response.data
    * match allUsers contains oneUser

    Examples:
      | id |
      | 1  |
      | 2  |
      | 3  |
      | 4  |
      | 5  |
      | 6  |
      | 7  |
      | 8  |
      | 9  |
      | 10 |
      | 11 |
      | 12 |


  Scenario Outline: Check is avatar is accessible
    Given path "api/users"
    And path "<id>"
    When method get
    Then status 200
    * def avatarUrl = response.data.avatar
    Given url avatarUrl
    When method get
    Then status 200

    Examples:
      | id |
      | 1  |
      | 2  |
      | 3  |
      | 4  |
      | 5  |
      | 6  |
      | 7  |
      | 8  |
      | 9  |
      | 10 |
      | 11 |
      | 12 |


  @wip
  Scenario Outline: Check is avatar is accessible
    Given path "api/users"
    And path "<id>"
    When method get
    Then status 404
    * match response == {}

    Examples:
      | id |
      | 24 |
      | 25 |
      | 36 |
      | 47 |


  Scenario Outline: Check with invalid user id
    Given path "api/users"
    And path "<id>"
    When method get
    Then status 404
    * match response == {}

    Examples:

      | id  |
      | 100 |
      | 150 |
      | 200 |
      | 300 |
      | 400 |








