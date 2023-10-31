*** Settings ***
# ----------------------------------------------------------------------------------------------------------------
Documentation       Main Test suite file where the Test cases for Nested POST call are maintained
Default Tags        NestedPostCall    PostCall    All
Library             Collections
Library             String
Library             RequestsLibrary
Suite Setup         Create Session With Bearer Token
Suite Teardown      Close Session And Upload Results
Resource            ../resources/General_Utils.resource
Resource            ../resources/Post_Call_Utils.resource
Resource            ../resources/Get_Call_Utils.resource
Resource            ../resources/Properties.resource
# ----------------------------------------------------------------------------------------------------------------


*** Test Cases ***
Verify User Posts POST Call
    [Documentation]                     Test case to perform nested POST call for User Posts
    ${UserId}=                          Fetch Existing User Id
    ${UserId}=                          Convert To String               ${UserId}
    ${Path}=                            Replace String	                ${USER_POSTS_RESOURCE_PATH}            user_id     ${UserId}
    &{PostPayload}=	                    Create User Posts POST Payload  Create_User_Posts_POST_Payload.json
    ${Response}=                        POST On Session                 ActiveSession    ${Path}     expected_status=any     data=${PostPayload}
    Verify Response Code And Reason     ${Response}                     201
    ${UserId}=                          Fetch Response Value            ${Response}      user_id
    ${Id}=                              Fetch Response Value            ${Response}      id
    ${PostPayload}=                     Update Value To Json            ${PostPayload}   $.user_id       ${UserId}
    ${PostPayload}=                     Update Value To Json            ${PostPayload}   $.id            ${Id}
    Validate Update Response            ${Response}                     ${PostPayload}


Verify Post Comments POST Call
    [Documentation]                     Test case to perform nested POST call for Post Comments
    ${PostId}=                          Fetch Existing Post Id
    ${PostId}=                          Convert To String               ${PostId}
    ${Path}=                            Replace String	                ${POST_COMMENTS_RESOURCE_PATH}            post_id     ${PostId}
    &{PostPayload}=	                    Create Post Comments POST Payload   Create_Post_Comments_POST_Payload.json
    ${Response}=                        POST On Session                 ActiveSession    ${Path}     expected_status=any     data=${PostPayload}
    Verify Response Code And Reason     ${Response}                     201
    ${PostId}=                          Fetch Response Value            ${Response}      post_id
    ${Id}=                              Fetch Response Value            ${Response}      id
    ${PostPayload}=                     Delete Object From Json         ${PostPayload}   $.post
    ${PostPayload}=                     Update Value To Json            ${PostPayload}   $.post_id       ${PostId}
    ${PostPayload}=                     Update Value To Json            ${PostPayload}   $.id            ${Id}
    Validate Update Response            ${Response}                     ${PostPayload}


Verify User Todos POST Call
    [Documentation]                     Test case to perform nested POST call for User Todos
    ${UserId}=                          Fetch Existing User Id
    ${UserId}=                          Convert To String               ${UserId}
    ${Path}=                            Replace String	                ${USER_TODOS_RESOURCE_PATH}            user_id     ${UserId}
    &{PostPayload}=	                    Create User Todos POST Payload  Create_User_Todos_POST_Payload.json
    ${Response}=                        POST On Session                 ActiveSession    ${Path}     expected_status=any     data=${PostPayload}
    Verify Response Code And Reason     ${Response}                     201
    ${UserId}=                          Fetch Response Value            ${Response}      user_id
    ${Id}=                              Fetch Response Value            ${Response}      id
    ${PostPayload}=                     Update Value To Json            ${PostPayload}   $.user_id       ${UserId}
    ${PostPayload}=                     Update Value To Json            ${PostPayload}   $.id            ${Id}
    Validate Update Response            ${Response}                     ${PostPayload}
