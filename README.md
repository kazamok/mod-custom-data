# mod-custom-data

## 개요

`mod-custom-data`는 AzerothCore 서버에 사용자 정의 SQL 데이터를 자동으로 임포트하기 위한 범용 모듈입니다. 이 모듈은 웹 애플리케이션 데이터, 커스텀 아이템, NPC, 퀘스트 등 다양한 종류의 SQL 스크립트를 서버 시작 시 자동으로 데이터베이스에 적용할 수 있도록 설계되었습니다.

## 작동 방식

이 모듈은 AzerothCore의 내장된 모듈 SQL 업데이트 시스템을 활용합니다. 모듈 내의 특정 디렉토리에 SQL 파일을 배치하고, `mod-custom-data.cmake` 파일에 해당 파일의 경로를 등록하면, 서버(주로 Worldserver)가 시작될 때 해당 SQL 스크립트가 자동으로 실행됩니다. 이미 적용된 스크립트는 다시 실행되지 않으므로 데이터베이스의 일관성을 유지할 수 있습니다.

## 파일 구조

`mod-custom-data` 모듈의 핵심 디렉토리 구조는 다음과 같습니다:

```
mod-custom-data/
├── data/
│   └── sql/
│       ├── db-auth/       # acore_auth 데이터베이스용 SQL 파일
│       ├── db-characters/ # acore_characters 데이터베이스용 SQL 파일
│       └── db-world/      # acore_world 데이터베이스용 SQL 파일
├── src/
│   └── mod_custom_data.cpp # 모듈 인식을 위한 더미 C++ 소스 파일
├── CMakeLists.txt          # 모듈 빌드 설정
└── mod-custom-data.cmake   # SQL 파일 등록 설정
```

## SQL 파일 추가 및 등록 방법

새로운 SQL 파일을 추가하고 서버에 자동으로 적용되도록 하려면 다음 단계를 따르세요:

1.  **SQL 파일 배치**: 웹페이지 SQL 파일 또는 기타 사용자 정의 SQL 파일을 해당 데이터베이스 유형에 맞는 `data/sql/` 하위 디렉토리(예: `db-auth`, `db-world`, `db-characters`)에 복사합니다.

    *   예시: `C:\azerothcore\modules\mod-custom-data\data\sql\db-world\my_web_data.sql`

2.  **`mod-custom-data.cmake` 파일 수정**: `mod-custom-data.cmake` 파일을 텍스트 편집기로 엽니다. 해당 SQL 파일이 적용될 데이터베이스에 맞는 `set` 블록을 찾습니다.

    *   **`acore_auth` 데이터베이스용**: `AUTH_SQL_FILES` 변수
    *   **`acore_world` 데이터베이스용**: `WORLD_SQL_FILES` 변수
    *   **`acore_characters` 데이터베이스용**: `CHARACTERS_SQL_FILES` 변수

    해당 `set` 블록 안에 새 줄로 SQL 파일의 경로를 추가합니다. 경로는 `${CMAKE_CURRENT_LIST_DIR}/data/sql/<db_name>/<your_file_name.sql>` 형식으로 작성해야 합니다.

    **예시 (`db-world`에 `my_web_data.sql` 추가):**

    ```cmake
    # SQL 파일을 추가하려면 아래에 새 줄로 경로를 추가하세요.
    # 예시: "${CMAKE_CURRENT_LIST_DIR}/data/sql/db-world/your_new_world_file.sql"
    set(WORLD_SQL_FILES
        "${CMAKE_CURRENT_LIST_DIR}/data/sql/db-world/custom_world_data.sql"
        "${CMAKE_CURRENT_LIST_DIR}/data/sql/db-world/my_web_data.sql" # 새로 추가된 파일
    )
    ```

    여러 파일을 추가할 경우, 각 파일 경로를 새 줄에 계속해서 추가하면 됩니다.

3.  **CMake 재실행 및 프로젝트 재빌드**: SQL 파일을 추가하거나 `mod-custom-data.cmake` 파일을 수정한 후에는 반드시 다음 단계를 수행해야 합니다.

    *   **빌드 디렉토리 정리** (권장): `C:\azerothcore\build` 폴더를 완전히 삭제합니다.
    *   **CMake 재실행**: CMake GUI를 열고 `Configure` 및 `Generate`를 다시 실행합니다.
    *   **프로젝트 재빌드**: Visual Studio에서 `ALL_BUILD` 프로젝트를 다시 빌드합니다.

## 참고

*   `src/mod_custom_data.cpp` 파일은 모듈이 CMake에 의해 올바르게 인식되도록 하기 위한 더미 파일입니다. 실제 기능은 포함하고 있지 않습니다.
*   이 모듈은 SQL 파일의 내용을 검증하지 않습니다. 유효하고 안전한 SQL 쿼리만 포함해야 합니다.

