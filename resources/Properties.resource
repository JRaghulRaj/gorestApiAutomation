*** Settings ***
# ----------------------------------------------------------------------------------------------------------------

Documentation       A resource file with reusable keywords and variables.
...                 The keywords created here are called in the test suites.

# ----------------------------------------------------------------------------------------------------------------


*** Variables ***
# ----------------------------------------------------------------------------------------------------------------
${BASE_URL}                     https://gorest.co.in/
${USERS_RESOURCE_PATH}          /public/v2/users
${POSTS_RESOURCE_PATH}          /public/v2/posts
${COMMENTS_RESOURCE_PATH}       /public/v2/comments
${TODOS_RESOURCE_PATH}          /public/v2/todos
${USER_POSTS_RESOURCE_PATH}     /public/v2/users/user_id/posts
${POST_COMMENTS_RESOURCE_PATH}  /public/v2/posts/post_id/comments
${USER_TODOS_RESOURCE_PATH}     /public/v2/users/user_id/todos

${USERS_JSON_SCHEMA}            JSON_Schema_Users.json
${POSTS_JSON_SCHEMA}            JSON_Schema_Posts.json
${TODOS_JSON_SCHEMA}            JSON_Schema_Todos.json
${COMMENTS_JSON_SCHEMA}         JSON_Schema_Comments.json
${USER_POSTS_JSON_SCHEMA}       JSON_Schema_User_Posts.json
${USER_TODOS_JSON_SCHEMA}       JSON_Schema_User_Todos.json
${POST_COMMENTS_JSON_SCHEMA}    JSON_Schema_Post_Comments.json

&{STATUS_REASON_CODES}          200=OK  201=Created  401=Unauthorized   404=Not Found   422=Unprocessable Entity
${APPLICATION_JSON}             application/json
${EMAIL_REGEX}                  \\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,7}\\b

${BEARER_TOKEN}                 Bearer d8f5c3e02426312480716fb043ade99ce15049819982faaf07f957b902d8fe7b

# ----------------------------------------------------------------------------------------------------------------
