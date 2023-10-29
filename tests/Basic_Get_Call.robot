*** Settings ***
# ----------------------------------------------------------------------------------------------------------------
Documentation       Main Test suite file where the Test cases are maintained
Default Tags        GetCall
Library             Collections
Library             RequestsLibrary
Library             JSONLibrary
Resource            ../resources/Resources.resource
Resource            ../resources/Properties.resource
# ----------------------------------------------------------------------------------------------------------------


*** Test Cases ***
Verify GET Users
    [Documentation]                                 Test to perform GET call to fetch Users
    Create Session                                  ActiveSession       ${BASE_URL}
    ${Response}=                                    GET On Session      ActiveSession       ${USERS_RESOURCE_PATH}    expected_status=any
    Verify Response Code And Reason                 ${Response}         200
    Verify Response Is JSON                         ${Response}
    Verify Response Has Pagination                  ${Response}
    Verify Response Has Valid Email ID              ${Response}
    Verify All List Data Have Similar Attributes    ${Response}         ${USERS_JSON_SCHEMA}

Verify GET Posts
    [Documentation]                                 Test to perform GET call to fetch Posts
    Create Session                                  ActiveSession       ${BASE_URL}
    ${Response}=                                    GET On Session      ActiveSession       ${POSTS_RESOURCE_PATH}    expected_status=any
    Verify Response Code And Reason                 ${Response}         200
    Verify Response Is JSON                         ${Response}
    Verify Response Has Pagination                  ${Response}
    Verify All List Data Have Similar Attributes    ${Response}         ${POSTS_JSON_SCHEMA}

Verify GET Comments
    [Documentation]                                 Test to perform GET call to fetch Comments
    Create Session                                  ActiveSession       ${BASE_URL}
    ${Response}=                                    GET On Session      ActiveSession       ${COMMENTS_RESOURCE_PATH}    expected_status=any
    Verify Response Code And Reason                 ${Response}         200
    Verify Response Is JSON                         ${Response}
    Verify Response Has Pagination                  ${Response}
    Verify Response Has Valid Email ID              ${Response}
    Verify All List Data Have Similar Attributes    ${Response}         ${COMMENTS_JSON_SCHEMA}

Verify GET Todos
    [Documentation]                                 Test to perform GET call to fetch Todos
    Create Session                                  ActiveSession       ${BaseURL}
    ${Response}=                                    GET On Session      ActiveSession       ${TODOS_RESOURCE_PATH}    expected_status=any
    Verify Response Code And Reason                 ${Response}         200
    Verify Response Is JSON                         ${Response}
    Verify Response Has Pagination                  ${Response}
    Verify All List Data Have Similar Attributes    ${Response}         ${TODOS_JSON_SCHEMA}