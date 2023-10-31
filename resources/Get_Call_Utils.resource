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
Resource            ../resources/General_Utils.resource
# ----------------------------------------------------------------------------------------------------------------


*** Keywords ***
Fetch Existing User Id
    [Documentation]                     Keyword to return existing User ID
    ${Response}=                        GET On Session          ActiveSession       ${USERS_RESOURCE_PATH}    expected_status=any
    Verify Response Code And Reason     ${Response}             200
    ${UserId}=                          Fetch Response Value    ${Response}         id
    RETURN                              ${UserId}

Fetch Existing Post Id
    [Documentation]                     Keyword to return existing Post ID
    ${Response}=                        GET On Session          ActiveSession       ${POSTS_RESOURCE_PATH}    expected_status=any
    Verify Response Code And Reason     ${Response}             200
    ${PostId}=                          Fetch Response Value    ${Response}         id
    RETURN                              ${PostId}
