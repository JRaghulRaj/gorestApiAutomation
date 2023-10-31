*** Settings ***
# ----------------------------------------------------------------------------------------------------------------
Documentation       A resource file with reusable keywords and variables.
...                 The keywords created here are called in the test suites.
Library             Collections
Library             Process
Library             RequestsLibrary
Library             JSONLibrary
Library             FakerLibrary
Library             CryptoLibrary    variable_decryption=False    key_path=${CURDIR}/../keys
Library             ../custom_libraries/MongoDB.py
Resource            ../resources/Properties.resource
# ----------------------------------------------------------------------------------------------------------------


*** Keywords ***
Create Session With Bearer Token
    [Documentation]                 Keyword to Create Session. To be used in Setup.
    ${Token}=                       Get Decrypted Text      ${BEARER_TOKEN}
    &{Headers}=                     Create Dictionary       Authorization=Bearer ${Token}
    Create Session                  ActiveSession           ${BASE_URL}          headers=${Headers}

Create Session With Bearer Token And Non-SSL URL
    [Documentation]                 Keyword to Non-SSL URL Session Creation. To be used in Setup.
    ${Token}=                       Get Decrypted Text      ${BEARER_TOKEN}
    &{Headers}=                     Create Dictionary       Authorization=Bearer ${Token}
    Create Session                  ActiveSessionNonSSL     ${NON_SSL_BASE_URL}  headers=${Headers}
    
Close Session And Upload Results
    [Documentation]                 Keyword to Close Session and Upload results to MongoDB
    Delete All Sessions
    ${Mongo_Password}=              Get Decrypted Text      ${MONGO_DB_PASSWORD}
    Create Conn Upload              ${Mongo_Password}

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
        Validate Json By Schema File    ${Data}                 ${JSON_SCHEMA_FILE_PATH}${JsonSchemaFile}
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

Validate Update Response
    [Documentation]                     Keyword to validate JSON response with Input Payload values
    [Arguments]                         ${Response}            ${Payload}
    @{Keys}=        Get Dictionary Keys        ${Payload}
    Log    ${Keys}
    FOR     ${Key}    IN    @{Keys}
        Log    ${Key}
        Should Be Equal As Strings          ${Response.json().get('${Key}')}    ${Payload.get('${Key}')}    ignore_case=False
    END
