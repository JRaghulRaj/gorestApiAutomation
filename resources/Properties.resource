*** Settings ***
# ----------------------------------------------------------------------------------------------------------------

Documentation       A resource file with variables used accross the framework.
# ----------------------------------------------------------------------------------------------------------------


*** Variables ***
# ----------------------------------------------------------------------------------------------------------------
${BASE_URL}                     https://gorest.co.in/
${NON_SSL_BASE_URL}             http://gorest.co.in/
${USERS_RESOURCE_PATH}          /public/v2/users
${POSTS_RESOURCE_PATH}          /public/v2/posts
${COMMENTS_RESOURCE_PATH}       /public/v2/comments
${TODOS_RESOURCE_PATH}          /public/v2/todos
${USER_POSTS_RESOURCE_PATH}     /public/v2/users/user_id/posts
${POST_COMMENTS_RESOURCE_PATH}  /public/v2/posts/post_id/comments
${USER_TODOS_RESOURCE_PATH}     /public/v2/users/user_id/todos
${USER_RESOURCE_PATH}           /public/v2/users/user_id

${TEST_DATA_FILE_PATH}          ${CURDIR}/../test_data/
${JSON_SCHEMA_FILE_PATH}        ${CURDIR}/../json_schema/
${KEYS_PATH}                    ${CURDIR}/../keys

&{STATUS_REASON_CODES}          200=OK  201=Created  401=Unauthorized   404=Not Found   422=Unprocessable Entity        204=No Content
${APPLICATION_JSON}             application/json
${EMAIL_REGEX}                  \\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,7}\\b
@{USER_STATUS}                  active    inactive
@{USER_GENDER}                  male    female

${BEARER_TOKEN}                 crypt:mfStOh4iS7Hdimq45UezV7y/WUTJeQMmJCKfXHDBQhPbJ+mjLjXVb2HPnk6PDclgO9HAsARmLCXg8BCuY/82k/5jCbA3n4yb8EKI3sXOd03ydrFcQfiJKDQEUqN6Egw2yjOiN5BhOqR+vuCaALm1dw==
${MONGODB_PASSWORD}             crypt:vJo1Q/3q6nsfz+LDpo5AFGrM4WYjrbls0cMzY7VQXneRBENLZdjkZ+FdCOX5AL2ad/zXcNcs22wcKPnJ0zB3/Q==
# ----------------------------------------------------------------------------------------------------------------
