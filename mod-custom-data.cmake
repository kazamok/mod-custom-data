set(AUTH_SQL_FILES
    "${CMAKE_CURRENT_LIST_DIR}/data/sql/db-auth/custom_auth_data.sql"
)

set(WORLD_SQL_FILES
    "${CMAKE_CURRENT_LIST_DIR}/data/sql/db-world/custom_world_data.sql"
)

# SQL 파일을 추가하려면 아래에 새 줄로 경로를 추가하세요。
# 예시: "${CMAKE_CURRENT_LIST_DIR}/data/sql/db-characters/your_new_characters_file.sql"
set(CHARACTERS_SQL_FILES
    "${CMAKE_CURRENT_LIST_DIR}/data/sql/db-characters/custom_characters_data.sql"
    # "${CMAKE_CURRENT_LIST_DIR}/data/sql/db-characters/your_additional_characters_file.sql"
)
