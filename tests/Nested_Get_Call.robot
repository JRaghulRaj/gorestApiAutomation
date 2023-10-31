*** Settings ***
# ---------------------------------------------------------------------------------------------------------------
Documentation       Main Test suite file where the Test cases for Nested GET call are maintained
Default Tags        NestedGetCall    GetCall    All
Library             Collections
Library             String
Library             RequestsLibrary
Library             JSONLibrary
Suite Setup         Create Session With Bearer Token
Suite Teardown      Close Session And Upload Results
Resource            ../resources/General_Utils.resource
Resource            ../resources/Get_Call_Utils.resource
Resource            ../resources/Properties.resource
# ----------------------------------------------------------------------------------------------------------------


*** Test Cases ***
Verify GET User Posts
    [Documentation]                                 Test to perform GET call to fetch User Posts
    ${UserId}=                                      Fetch Existing User Id
    ${UserId}=                                      Convert To String   ${UserId}
    ${Path}=                                        Replace String	    ${USER_POSTS_RESOURCE_PATH}        user_id     ${UserId}
    ${Response}=                                    GET On Session      ActiveSession                   ${Path}     expected_status=any
    Verify Response Code And Reason                 ${Response}         200
    Verify Response Is JSON                         ${Response}
    Verify Response Has Pagination                  ${Response}
    Verify All List Data Have Similar Attributes    ${Response}         JSON_Schema_User_Posts.json

Verify GET Post Comments
    [Documentation]                                 Test to perform GET call to fetch Post Comments
    ${PostId}=                                      Fetch Existing Post Id
    ${PostId}=                                      Convert To String   ${PostId}
    ${Path}=                                        Replace String	    ${POST_COMMENTS_RESOURCE_PATH}     post_id     ${PostId}
    ${Response}=                                    GET On Session      ActiveSession                   ${Path}     expected_status=any
    Verify Response Code And Reason                 ${Response}         200
    Verify Response Is JSON                         ${Response}
    Verify Response Has Pagination                  ${Response}
    Verify Response Has Valid Email ID              ${Response}
    Verify All List Data Have Similar Attributes    ${Response}         JSON_Schema_Post_Comments.json

Verify GET User Todos
    [Documentation]                                 Test to perform GET call to User Todos
    ${UserId}=                                      Fetch Existing User Id
    ${UserId}=                                      Convert To String       ${UserId}
    ${Path}=                                        Replace String	    ${USER_TODOS_RESOURCE_PATH}        user_id	   ${UserId}
    ${Response}=                                    GET On Session      ActiveSession                   ${Path}    expected_status=any
    Verify Response Code And Reason                 ${Response}         200
    Verify Response Is JSON                         ${Response}
    Verify Response Has Pagination                  ${Response}
    Verify All List Data Have Similar Attributes    ${Response}         JSON_Schema_User_Todos.json
