*** Settings ***
# ----------------------------------------------------------------------------------------------------------------
Documentation       Main Test suite file where the Test cases are maintained
Library             Collections
Library             RequestsLibrary
Library             JSONLibrary
Resource            ../resources/Resources.resource
Resource            ../resources/Properties.resource
# ----------------------------------------------------------------------------------------------------------------


*** Test Cases ***
Basic POST call
    [Documentation]                     Test case to perform basic POST call
    [Tags]                              PostCall
    &{Headers}=                         Create Dictionary       Authorization=${BEARER_TOKEN}
    Create Session                      ActiveSession           ${BASE_URL}          headers=${Headers}
    ${JsonData}=	                    Load Json From File     ${CURDIR}/../test_data/Create_User.json
    ${UpdatedJson}=	                    Update Value To Json	${JsonData}	        $.email	                jraghulraje677456@gmail.com
    ${Response}=                        POST On Session         ActiveSession       ${USERS_RESOURCE_PATH}    expected_status=any     data=${UpdatedJson}
    Verify Response Code And Reason     ${Response}             201
    ${UserId}=                          Fetch Response Value    ${Response}         name
    Log                                 ${UserId}
