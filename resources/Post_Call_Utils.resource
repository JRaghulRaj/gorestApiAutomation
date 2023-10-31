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
Create User POST Payload
    [Documentation]                     Keyword to create a User POST, JSON payload with faker data
    [Arguments]                         ${PayloadFile}
    ${JsonData}=	                    Load Json From File     ${TEST_DATA_FILE_PATH}${PayloadFile}
    ${Id}=                              Random Number            digits=7
    ${Name}=                            First Name
    ${EmailId}=                         Ascii Free Email
    ${PostPayload}=	                    Update Value To Json	${JsonData}	        $.email	                ${EmailId}
    ${PostPayload}=	                    Update Value To Json	${PostPayload}	    $.id	                ${Id}
    ${PostPayload}=	                    Update Value To Json	${PostPayload}	    $.name	                ${Name}
    RETURN                              ${PostPayload}

Create User Posts POST Payload
    [Documentation]                     Keyword to create User Posts POST, JSON payload with faker data
    [Arguments]                         ${PayloadFile}
    ${JsonData}=	                    Load Json From File      ${TEST_DATA_FILE_PATH}${PayloadFile}
    ${Id}=                              Random Number            digits=7
    ${Name}=                            First Name
    ${PostPayload}=	                    Update Value To Json	${JsonData}	    $.id	                ${Id}
    ${PostPayload}=	                    Update Value To Json	${PostPayload}	$.name	                ${Name}
    RETURN                              ${PostPayload}

Create Post Comments POST Payload
    [Documentation]                     Keyword to create Post Comments, JSON payload with faker data
    [Arguments]                         ${PayloadFile}
    ${JsonData}=	                    Load Json From File      ${TEST_DATA_FILE_PATH}${PayloadFile}
    ${Id}=                              Random Number            digits=5
    ${Post_Id}=                         Random Number            digits=5
    ${Name}=                            First Name
    ${EmailId}=                         Ascii Free Email
    ${Body}=                            Sentence
    ${Post}=                            Sentence
    ${PostPayload}=	                    Update Value To Json	${JsonData}	     $.post	                ${Post}
    ${PostPayload}=	                    Update Value To Json	${PostPayload}	 $.id	                ${Id}
    ${PostPayload}=	                    Update Value To Json	${PostPayload}	 $.post_id              ${Post_Id}
    ${PostPayload}=	                    Update Value To Json	${PostPayload}	 $.name	                ${Name}
    ${PostPayload}=	                    Update Value To Json	${PostPayload}	 $.email	            ${EmailId}
    ${PostPayload}=	                    Update Value To Json	${PostPayload}	 $.body	                ${Body}
    RETURN                              ${PostPayload}

Create User Todos POST Payload
    [Documentation]                     Keyword to create User Todos, JSON payload with faker data
    [Arguments]                         ${PayloadFile}
    ${JsonData}=	                    Load Json From File      ${TEST_DATA_FILE_PATH}${PayloadFile}
    ${Id}=                              Random Number            digits=7
    ${User_Id}=                         Random Number            digits=7
    ${Title}=                           Sentence
    ${Body}=                            Paragraph
    ${PostPayload}=	                    Update Value To Json	${JsonData}	     $.id	                ${Id}
    ${PostPayload}=	                    Update Value To Json	${PostPayload}	 $.user_id              ${User_Id}
    ${PostPayload}=	                    Update Value To Json	${PostPayload}	 $.title                ${Title}
    ${PostPayload}=	                    Update Value To Json	${PostPayload}	 $.body	                ${Body}
    RETURN                              ${PostPayload}
