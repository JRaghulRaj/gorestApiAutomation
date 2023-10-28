*** Settings ***
#----------------------------------------------------------------------------------------------------------------
Documentation       Main Test suite file where the Test cases are maintained
Library             RequestsLibrary
Library             JSONLibrary
Library             Collections
Resource            ../resources/Resources.robot
#----------------------------------------------------------------------------------------------------------------

*** Variables ***

#Test case specific variables which are passed as arguments
#----------------------------------------------------------------------------------------------------------------
${BaseURL}              https://gorest.co.in/
${UsersResourcePath}    /public/v2/users

#----------------------------------------------------------------------------------------------------------------
*** Test Cases ***

#-------------------------------------------Test case Header-----------------------------------------------------
#       Test case to validate GET call to fetch user details
#----------------------------------------------------------------------------------------------------------------

Basic GET call
    [Tags]                              GetCall
    Create Session                      ActiveSession       ${BaseURL}
    ${Response}=                        GET On Session      ActiveSession       ${UsersResourcePath}    expected_status=any
    Validate Response Code And Reason   ${Response}         200
    Validate Response Is JSON           ${Response}
    Validate Response Has Pagination    ${Response}




