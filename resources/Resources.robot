*** Settings ***
#----------------------------------------------------------------------------------------------------------------
Documentation       A resource file with reusable keywords and variables.
...                 The keywords created here are called in the test suites.
Library             RequestsLibrary
Library             JSONLibrary
Library             Collections
#----------------------------------------------------------------------------------------------------------------

*** Variables ***
#----------------------------------------------------------------------------------------------------------------
&{StatusReasonCodes}        200=OK  210=Created  401=Unauthorized  404=Not Found
${ApplicationJson}          application/json
${EmailRegex}               \\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,7}\\b
#----------------------------------------------------------------------------------------------------------------

*** Keywords ***

#-------------------------------------------Keyword Header-------------------------------------------------------
#       Keyword to validate response has pagination. Response object is passed as parameter from the Test.
#----------------------------------------------------------------------------------------------------------------

Validate Response Has Pagination
    [Arguments]                     ${Response}
    Dictionary Should Contain Key   dictionary=${Response.headers}      key=x-pagination-total      msg="Pagination is not present in response"

Validate Response Code And Reason
    [Arguments]                     ${Response}                         ${ExpectedCode}
    Should Be Equal As Integers     ${response.status_code}             ${ExpectedCode}
    Should Be Equal As Strings      ${response.reason}                  ${StatusReasonCodes[str(${ExpectedCode})]}

Validate Response Is JSON
    [Arguments]                     ${Response}
    Should Contain                  ${Response.headers['Content-Type']}     ${ApplicationJson}
