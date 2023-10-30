*** Settings ***
# ----------------------------------------------------------------------------------------------------------------
Documentation       A resource file with reusable keywords and variables.
...                 The keywords created here are called in the test suites.
Library             Collections
Library             RequestsLibrary
Library             JSONLibrary
Library             FakerLibrary
Library             CryptoLibrary
Resource            ../resources/Properties.resource
# ----------------------------------------------------------------------------------------------------------------


*** Keywords ***
Create Session With Bearer Token
    [Documentation]                 Keyword to Create Session. To be used in Setup.
    ${Token}=                           Get Decrypted Text      ${BEARER_TOKEN}
    &{Headers}=                         Create Dictionary       Authorization=Bearer ${Token}
    Create Session                      ActiveSession           ${BASE_URL}          headers=${Headers}
    

Verify Response Has Pagination
    [Documentation]                 Keyword to verify Pagination
    [Arguments]                     ${Response}
    Dictionary Should Contain Key   dictionary=${Response.headers}      key=x-pagination-total      msg="Pagination is not present in response"

Verify Response Code And Reason
    [Documentation]                 Keyword to verify Response Code and Reason Message
    [Arguments]                     ${Response}                         ${ExpectedCode}
    Should Be Equal As Integers     ${Response.status_code}             ${ExpectedCode}
    Should Be Equal As Strings      ${Response.reason}                  ${STATUS_REASON_CODES[str(${ExpectedCode})]}

Verify Response Is JSON
    [Documentation]                 Keyword to verify Response is JSON
    [Arguments]                     ${Response}
    Should Contain                  ${Response.headers['Content-Type']}     ${APPLICATION_JSON}

Verify Response Has Valid Email ID
    [Documentation]                 Keyword to verify Response has a valid Email ID
    [Arguments]                         ${Response}
    IF  ${Response.headers.get('x-pagination-page')}==None
        &{ResponseData}=                Set Variable            ${Response.json()}
        Should Not Be Empty             ${ResponseData}
        ${Email}=                       Get From Dictionary     ${ResponseData}          email
        Verify Email ID Format          ${Email}
    ELSE
        @{JsonDataList}=                Set Variable            ${Response.json()}
        Should Not Be Empty             ${JsonDataList}
        FOR     ${Data}     IN          @{JsonDataList}
            ${Email}=                   Get From Dictionary     ${Data}          email
            Verify Email ID Format      ${Email}
        END
    END

Verify Email ID Format
    [Documentation]             Keyword to verify Email ID using REGEX
    [Arguments]                 ${EmailId}
    Should Match Regexp	        ${EmailId}    ${EMAIL_REGEX}        flags=IGNORECASE

Verify All List Data Have Similar Attributes
    [Documentation]                     Keyword to verify list has similar attributes using JSON Schema
    [Arguments]                         ${Response}             ${JsonSchemaFile}
    @{JsonDataList}=                    Set Variable            ${Response.json()}
    FOR     ${Data}     IN              @{JsonDataList}
        Validate Json By Schema File    ${Data}                 ${CURDIR}/../json_schema/${JsonSchemaFile}
    END

Fetch Response Value
    [Documentation]                     Keyword to fetch value from JSON Response
    [Arguments]                         ${Response}             ${Value}
    IF  ${Response.headers.get('x-pagination-page')}==None
        &{ResponseData}=                Set Variable            ${Response.json()}
        ${UserId}=                      Get From Dictionary     ${ResponseData}               ${Value}
    ELSE
        @{JsonDataList}=                Set Variable            ${Response.json()}
        ${UserId}=                      Set Variable            ${JsonDataList[0].get('${Value}')}
    END
    RETURN                              ${UserId}

Fetch Existing User Id
    [Documentation]                     Keyword to return existing User ID
#    Create Session                      ActiveSession           ${BaseURL}
    ${Response}=                        GET On Session          ActiveSession       ${USERS_RESOURCE_PATH}    expected_status=any
    Verify Response Code And Reason     ${Response}             200
    ${UserId}=                          Fetch Response Value    ${Response}         id
    RETURN                              ${UserId}

Fetch Existing Post Id
    [Documentation]                     Keyword to return existing Post ID
#    Create Session                      ActiveSession           ${BaseURL}
    ${Response}=                        GET On Session          ActiveSession       ${POSTS_RESOURCE_PATH}    expected_status=any
    Verify Response Code And Reason     ${Response}             200
    ${PostId}=                          Fetch Response Value    ${Response}         id
    RETURN                              ${PostId}

Create User Payload
    [Documentation]                     Keyword to create a JSON payload with faker data
    ${JsonData}=	                    Load Json From File     ${CURDIR}/../test_data/Create_User.json
    ${Id}=                              Random Number            digits=7
    ${Name}=                            First Name
    ${EmailId}=                         Ascii Free Email
    ${UpdatedJson}=	                    Update Value To Json	${JsonData}	        $.email	                ${EmailId}
    ${UpdatedJson}=	                    Update Value To Json	${UpdatedJson}	    $.id	                ${Id}
    ${UpdatedJson}=	                    Update Value To Json	${UpdatedJson}	        $.name	                ${Name}
    log             ${UpdatedJson}
    RETURN          ${UpdatedJson}

Create PATCH Payload
    [Documentation]                     Keyword to create a PATCH JSON payload. Based on the Argument passed, payload is created and returned
    [Arguments]                         ${UpdateField}
    IF    $UpdateField == 'email'
        ${FieldValue}=                      Ascii Free Email
        &{PatchPayload}=	                Create Dictionary	    email=${FieldValue}
    ELSE IF    $UpdateField == 'name'
        ${FieldValue}=                      First Name
        &{PatchPayload}=	                Create Dictionary	    name=${FieldValue}
    ELSE IF    $UpdateField == 'status'
        ${FieldValue}=                      Evaluate  random.choice(${USER_STATUS})  random
        &{PatchPayload}=	                Create Dictionary	    status=${FieldValue}
    ELSE IF    $UpdateField == 'gender'
        ${FieldValue}=                      Evaluate  random.choice(${USER_GENDER})  random
        &{PatchPayload}=	                Create Dictionary	    gender=${FieldValue}
    ELSE IF    $UpdateField == 'all'
        ${EmailId}=                         Ascii Free Email
        ${Name}=                            First Name
        ${Status}=                          Evaluate  random.choice(${USER_STATUS})  random
        ${Gender}=                          Evaluate  random.choice(${USER_GENDER})  random
        &{PatchPayload}=	                Create Dictionary	    email=${EmailId}    name=${Name}    status=${Status}    gender=${Gender}
    ELSE
        Fail                                msg=Invalid Field Value passed
    END
    RETURN          ${PatchPayload}
    
Validate Update Response
    [Documentation]                     Keyword to validate JSON response with Input Payload values
    [Arguments]                         ${Response}            ${Payload}
    @{Keys}=        Get Dictionary Keys        ${Payload}
    Log    ${Keys}
    FOR     ${Key}    IN    @{Keys}
        Log    ${Key}
        Should Be Equal As Strings          ${Response.json().get('${Key}')}    ${Payload.get('${Key}')}    ignore_case=False
    END
