*** Settings ***
# ----------------------------------------------------------------------------------------------------------------
Documentation       Main Test suite file where the Test cases for basic DELETE call are maintained
Default Tags        DeleteCall    All
Library             Collections
Library             String
Library             RequestsLibrary
Suite Setup         Create Session With Bearer Token
Suite Teardown      Close Session And Upload Results
Resource            ../resources/General_Utils.resource
Resource            ../resources/Get_Call_Utils.resource
Resource            ../resources/Properties.resource
# ----------------------------------------------------------------------------------------------------------------


*** Test Cases ***
Basic DELETE call
    [Documentation]                     Test case to perform basic DELETE call
    ${UserId}=	                        Fetch Existing User Id    
    ${UserId}=                          Convert To String       ${UserId}
    ${Path}=                            Replace String	        ${USER_RESOURCE_PATH}     user_id     ${UserId}
    ${Response}=                        DELETE On Session       ActiveSession       ${Path}      expected_status=any
    Verify Response Code And Reason     ${Response}             204
