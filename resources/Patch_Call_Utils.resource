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
