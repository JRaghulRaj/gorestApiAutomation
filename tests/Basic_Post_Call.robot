*** Settings ***
# ----------------------------------------------------------------------------------------------------------------
Documentation       Main Test suite file where the Test cases are maintained
Default Tags        PostCall    All
Library             Collections
Library             RequestsLibrary
Library             CryptoLibrary
Suite Setup         Create Session With Bearer Token
Suite Teardown      Delete All Sessions
Resource            ../resources/Resources.resource
Resource            ../resources/Properties.resource
# ----------------------------------------------------------------------------------------------------------------


*** Test Cases ***
Basic POST call
    [Documentation]                     Test case to perform basic POST call
    ${UpdatedJson}=	                    Create User Payload
    ${Response}=                        POST On Session         ActiveSession       ${USERS_RESOURCE_PATH}    expected_status=any     data=${UpdatedJson}
    Verify Response Code And Reason     ${Response}             201
    ${UserId}=                          Fetch Response Value    ${Response}         id
    Log                                 ${UserId}
