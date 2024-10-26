Feature: User edits the lead details
  
  Background:
    * url BASE_URL2
    * print 'print 1'
    * def result = call read('classpath:loanxpress/apis_1/login.feature')
    * def token = result.response.dt.token
    * print 'print 1 token', token
    * def result1 = call read('classpath:loanxpress/apis_1/pending_listing.feature')
    * def id1 = result1.response.dt[0]._id
    * print 'Extracted ID1:', id1
    * configure headers = { Authorization: '#(token)', Content-Type: 'application/json' }

  @Sanity1 @tc0005
  Scenario Outline: Editing lead detail
    * def expectedRoi = <expected_roi>
    * def requestBody = read(TEST_DATA1 + 'requests/edit_lead_req.json')
    * requestBody.primary.inquiry_details.expected_roi = expectedRoi
    Given path '/assignee/lead/' + id1
    And request requestBody
    When method PATCH
    Then status <statuscode>
    And print 'Response:', response



  Examples:
    | expected_roi | statuscode |
    | "16.00"      | 200        |
