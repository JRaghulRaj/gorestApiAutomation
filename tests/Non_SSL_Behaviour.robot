*** Settings ***
# ----------------------------------------------------------------------------------------------------------------
Documentation       Main Test suite file where the Test cases Non-SSL check are maintained
Default Tags        NonSSL    All
Library             Collections
Library             String
Library             RequestsLibrary
Suite Setup         Create Session With Bearer Token And Non-SSL URL
Suite Teardown      Close Session And Upload Results
Resource            ../resources/General_Utils.resource
Resource            ../resources/Properties.resource
# ----------------------------------------------------------------------------------------------------------------


*** Test Cases ***
Validate Non-SSL behaviour
    [Documentation]                     Test case to verify Non-SSL behaviour
    ${Response}=                        GET On Session              ActiveSessionNonSSL    ${USERS_RESOURCE_PATH}           expected_status=any
    Should Not Be Equal As Integers     ${Response.status_code}     200                    msg=API call is successful on HTTP[Non-SSL] endpoint.
