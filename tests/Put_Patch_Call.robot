*** Settings ***
# ----------------------------------------------------------------------------------------------------------------
Documentation       Main Test suite file where the Test cases for PUT/PATCH call are maintained
Default Tags        PutPatchCall    All
Library             Collections
Library             String
Library             RequestsLibrary
Suite Setup         Create Session With Bearer Token
Suite Teardown      Close Session And Upload Results
Resource            ../resources/General_Utils.resource
Resource            ../resources/Get_Call_Utils.resource
Resource            ../resources/Patch_Call_Utils.resource
Resource            ../resources/Properties.resource
# ----------------------------------------------------------------------------------------------------------------


*** Test Cases ***
Update Email ID using PATCH call
    [Documentation]                     Test case to update Email ID using PATCH call
    ${UserId}=	                        Fetch Existing User Id    
    ${UserId}=                          Convert To String       ${UserId}
    ${Path}=                            Replace String	        ${USER_RESOURCE_PATH}     user_id     ${UserId}
    &{PatchPayload}=	                Create PATCH Payload    email
    ${Response}=                        PATCH On Session        ActiveSession       ${Path}      expected_status=any    data=${PatchPayload}
    Verify Response Code And Reason     ${Response}             200
    Validate Update Response            ${Response}             ${PatchPayload}

Update Name using PATCH call
    [Documentation]                     Test case to update Name using PATCH call
    ${UserId}=	                        Fetch Existing User Id
    ${UserId}=                          Convert To String       ${UserId}
    ${Path}=                            Replace String	        ${USER_RESOURCE_PATH}     user_id     ${UserId}
    &{PatchPayload}=	                Create PATCH Payload    name
    ${Response}=                        PATCH On Session        ActiveSession       ${Path}      expected_status=any    data=${PatchPayload}
    Verify Response Code And Reason     ${Response}             200
    Validate Update Response            ${Response}             ${PatchPayload}

Update Status using PATCH call
    [Documentation]                     Test case to update Status using PATCH call
    ${UserId}=	                        Fetch Existing User Id
    ${UserId}=                          Convert To String       ${UserId}
    ${Path}=                            Replace String	        ${USER_RESOURCE_PATH}     user_id     ${UserId}
    &{PatchPayload}=	                Create PATCH Payload    status
    ${Response}=                        PATCH On Session        ActiveSession       ${Path}      expected_status=any    data=${PatchPayload}
    Verify Response Code And Reason     ${Response}             200
    Validate Update Response            ${Response}             ${PatchPayload}

Update Gender using PATCH call
    [Documentation]                     Test case to update Gender using PATCH call
    ${UserId}=	                        Fetch Existing User Id
    ${UserId}=                          Convert To String       ${UserId}
    ${Path}=                            Replace String	        ${USER_RESOURCE_PATH}     user_id     ${UserId}
    &{PatchPayload}=	                Create PATCH Payload    gender
    ${Response}=                        PATCH On Session        ActiveSession       ${Path}      expected_status=any    data=${PatchPayload}
    Verify Response Code And Reason     ${Response}             200
    Validate Update Response            ${Response}             ${PatchPayload}

Update All using PATCH call
    [Documentation]                     Test case to update All using PATCH call
    ${UserId}=	                        Fetch Existing User Id
    ${UserId}=                          Convert To String       ${UserId}
    ${Path}=                            Replace String	        ${USER_RESOURCE_PATH}     user_id     ${UserId}
    &{PatchPayload}=	                Create PATCH Payload    all
    ${Response}=                        PATCH On Session        ActiveSession       ${Path}      expected_status=any    data=${PatchPayload}
    Verify Response Code And Reason     ${Response}             200
    Validate Update Response            ${Response}             ${PatchPayload}

Update All using PUT call
    [Documentation]                     Test case to update All using PUT call
    ${UserId}=	                        Fetch Existing User Id
    ${UserId}=                          Convert To String       ${UserId}
    ${Path}=                            Replace String	        ${USER_RESOURCE_PATH}     user_id     ${UserId}
    &{PatchPayload}=	                Create PATCH Payload    all
    ${Response}=                        PUT On Session          ActiveSession       ${Path}      expected_status=any    data=${PatchPayload}
    Verify Response Code And Reason     ${Response}             200
    Validate Update Response            ${Response}             ${PatchPayload}
