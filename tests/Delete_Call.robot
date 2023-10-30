*** Settings ***
# ----------------------------------------------------------------------------------------------------------------
Documentation       Main Test suite file where the Test cases are maintained
Default Tags        DeleteCall    All
Library             Collections
Library             String
Library             RequestsLibrary
Library             CryptoLibrary
Suite Setup         Create Session With Bearer Token
Suite Teardown      Delete All Sessions
Resource            ../resources/Resources.resource
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
