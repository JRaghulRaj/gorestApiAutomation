*** Settings ***
# ----------------------------------------------------------------------------------------------------------------
Documentation       Main Test suite file where the Test cases for No Auth validation are maintained
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
Validate No Auth behaviour
    [Documentation]                     Test case to verify REST service without Authentication
    ${PostPayload}=	                    Create User POST Payload    Create_User_POST_Payload.json 
    Create Session                      InvalidSession              ${BASE_URL}
    ${Response}=                        POST On Session             InvalidSession       ${USERS_RESOURCE_PATH}    expected_status=any     data=${PostPayload}
    Verify Response Code And Reason     ${Response}                 401