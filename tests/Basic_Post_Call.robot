*** Settings ***
# ----------------------------------------------------------------------------------------------------------------
Documentation       Main Test suite file where the Test cases for basic POST call are maintained
Default Tags        BasicPostCall    PostCall    All
Library             Collections
Library             RequestsLibrary
Suite Setup         Create Session With Bearer Token
Suite Teardown      Close Session And Upload Results
Resource            ../resources/General_Utils.resource
Resource            ../resources/Post_Call_Utils.resource
Resource            ../resources/Properties.resource
# ----------------------------------------------------------------------------------------------------------------


*** Test Cases ***
Verify User creation Using Basic Post Call
    [Documentation]                     Test case to perform basic POST call User Creation
    ${PostPayload}=	                    Create User POST Payload    Create_User_POST_Payload.json        
    ${Response}=                        POST On Session             ActiveSession       ${USERS_RESOURCE_PATH}    expected_status=any     data=${PostPayload}
    Verify Response Code And Reason     ${Response}                 201
    ${UserId}=                          Fetch Response Value        ${Response}         id
    ${PostPayload}=                     Update Value To Json        ${PostPayload}      $.id                      ${UserId}
    Validate Update Response            ${Response}                 ${PostPayload}
