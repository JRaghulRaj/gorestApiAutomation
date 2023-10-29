*** Settings ***
# ---------------------------------------------------------------------------------------------------------------
Documentation       Main Test suite file where the Test cases are maintained
Test Setup          Set Log Level    TRACE
Default Tags        NestedGetCall
Library             Collections
Library             String
Library             RequestsLibrary
Library             JSONLibrary
Resource            ../resources/Resources.resource
Resource            ../resources/Properties.resource
# ----------------------------------------------------------------------------------------------------------------


*** Test Cases ***
Verify GET User Posts
    [Documentation]                                 Test to perform GET call to fetch User Posts
    Create Session                                  ActiveSession       ${BASE_URL}
    ${UserId}=                                      Fetch Existing User Id
    ${Path}=                                        Replace String	    ${USER_POSTS_RESOURCE_PATH}        user_id     "${UserId}"
    ${Response}=                                    GET On Session      ActiveSession                   ${Path}     expected_status=any
    Verify Response Code And Reason                 ${Response}         200
    Verify Response Is JSON                         ${Response}
    Verify Response Has Pagination                  ${Response}
    Verify All List Data Have Similar Attributes    ${Response}         ${PostsJsonSchema}

Verify GET Post Comments
    [Documentation]                                 Test to perform GET call to fetch Post Comments
    Create Session                                  ActiveSession       ${BASE_URL}
    ${PostId}=                                      Fetch Existing Post Id
    ${Path}=                                        Replace String	    ${POST_COMMENTS_RESOURCE_PATH}     post_id     "${PostId}"
    ${Response}=                                    GET On Session      ActiveSession                   ${Path}     expected_status=any
    Verify Response Code And Reason                 ${Response}         200
    Verify Response Is JSON                         ${Response}
    Verify Response Has Pagination                  ${Response}
    Verify Response Has Valid Email ID              ${Response}
    Verify All List Data Have Similar Attributes    ${Response}         ${PostsJsonSchema}

Verify GET User Todos
    [Documentation]                                 Test to perform GET call to User Todos
    Create Session                                  ActiveSession       ${BASE_URL}
    ${UserId}=                                      Fetch Existing User Id
    ${Path}=                                        Replace String	    ${USER_POSTS_RESOURCE_PATH}        user_id	   "${UserId}"
    ${Response}=                                    GET On Session      ActiveSession                   ${Path}    expected_status=any
    Verify Response Code And Reason                 ${Response}         200
    Verify Response Is JSON                         ${Response}
    Verify Response Has Pagination                  ${Response}
    Verify Response Has Valid Email ID              ${Response}
    Verify All List Data Have Similar Attributes    ${Response}         ${CommentsJsonSchema}
