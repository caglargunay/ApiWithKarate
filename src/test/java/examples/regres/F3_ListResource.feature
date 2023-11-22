Feature:
  Background: Url
  Given url "https://reqres.in/"


  Scenario:Verify page, per_page , total , total_pages

    Given path "/api/unknown"
    When method get
    Then status 200
    * match response.page == 1
    * assert response.per_page == 6
    * match  response.total == 12
    * assert response.total_pages == 2


  Scenario: List all data with 2000 and 2001 years
    Given path "/api/unknown"
    When method get
    Then status 200
    * def dataList = response.data.filter(i=>i.year==2000 || i.year==2001)
    * print dataList



  Scenario: Verify that all color codes starts with "#" and have 6 characters
    Given path "/api/unknown"
    When method get
    Then status 200
    * def dat = response.data.filter(i=>i.color.startsWith("#") && i.color.length == 7)
    * match dat ==response.data



  @wip
  Scenario: Verify that all the value of pantone_values in following format "##-####"
    Given path "/api/unknown"
    When method get
    Then status 200
   #  * def panValue = response.data.filter(i => i.pantone_value.matches("\\w{2}-\\w{4}"))
   # * def panValue = response.data.filter(i => i.pantone_value.matches("[A-Za-z0-9]{2}-[A-Za-z0-9]{4}"))
    * def panValue = response.data.filter(i => i.pantone_value.matches("..-...."))
    * match panValue == response.data


# d --> sadece rakamları , w --> harf rakm ve alt cizgi , s --> bosluk , . --> herhangi bir karakter ,[1a2]  --> bunlardan herhangi biri ile eşleşmesi  ,
  # [1asad2]{3} --> köseli parantez içindekilerden herhanmgi 3 karekter tanesi , [A-Z]{8}-->8 harfli  bütün büyük harfler , [^A-Z] --> büyük harfler dışındaki herşey
