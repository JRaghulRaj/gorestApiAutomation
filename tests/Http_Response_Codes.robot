*** Settings ***
# ----------------------------------------------------------------------------------------------------------------
Documentation       Main Test suite file where the Test cases for all HTTP STATUS CODES are maintained
Default Tags        PostCall    All
Library             Collections
Library             String
Library             RequestsLibrary
Suite Setup         Create Session With Bearer Token
Suite Teardown      Close Session And Upload Results
Resource            ../resources/General_Utils.resource
Resource            ../resources/Post_Call_Utils.resource
Resource            ../resources/Properties.resource
# ----------------------------------------------------------------------------------------------------------------


*** Test Cases ***
Validate All HTTP Response Codes
    [Documentation]                     Test case to verify all HTTP status codes
    [Tags]                              AllHttpCodes
    ${Path}=                            Replace String	        ${USER_RESOURCE_PATH}       user_id                  DummyID
    ${Response}=                        GET On Session          ActiveSession               ${Path}                  expected_status=any
    Verify Response Code And Reason     ${Response}             404
    ${Response}=                        GET On Session          ActiveSession       ${USERS_RESOURCE_PATH}           expected_status=any
    ${UserId}=                          Fetch Response Value    ${Response}         id
    ${UserId}=                          Convert To String       ${UserId}
    Verify Response Code And Reason     ${Response}             200
    ${Path}=                            Replace String	        ${USER_RESOURCE_PATH}       user_id                  ${UserId}
    ${Response}=                        DELETE On Session       ActiveSession       ${Path}      expected_status=any
    Verify Response Code And Reason     ${Response}             204
    ${PostPayload}=	                    Create User POST Payload
    ${Response}=                        POST On Session         ActiveSession       ${USERS_RESOURCE_PATH}    expected_status=any     data=${PostPayload}
    Verify Response Code And Reason     ${Response}             201
    ${UserId}=                          Fetch Response Value    ${Response}         id
    ${PostPayload}=                     Update Value To Json    ${PostPayload}      $.id                      ${UserId}
    ${Response}=                        POST On Session         ActiveSession       ${USERS_RESOURCE_PATH}    expected_status=any     data=${PostPayload}
    Verify Response Code And Reason     ${Response}             422
    ${InvalidToken}=                    Set Variable            InvalidToken
    &{Headers}=                         Create Dictionary       Authorization=Bearer ${InvalidToken}
    Create Session                      InvalidSession          ${BASE_URL}          headers=${Headers}
    ${Response}=                        POST On Session         InvalidSession       ${USERS_RESOURCE_PATH}    expected_status=any     data=${PostPayload}
    Verify Response Code And Reason     ${Response}             401

Validate All HTTP Response Codes
    [Documentation]                     Test case to verify all HTTP status codes
    [Tags]                              NoAuth
    ${PostPayload}=	                    Create User POST Payload
    Create Session                      InvalidSession          ${BASE_URL}
    ${Response}=                        POST On Session         InvalidSession       ${USERS_RESOURCE_PATH}    expected_status=any     data=${PostPayload}
    Verify Response Code And Reason     ${Response}             401