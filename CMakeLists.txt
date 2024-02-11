cmake_minimum_required(VERSION 3.15)

project(opengl_playground LANGUAGES CXX C)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find packages
find_package(glfw3 REQUIRED)

# Add source files. Can also add source files from extra libraries
# Reason for using glob: the easiet option for most projects
file(GLOB_RECURSE PROJECT_SOURCES
    CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp"
    # glad
    "${CMAKE_CURRENT_SOURCE_DIR}/external/glad/src/gl.c"
)

add_executable(${PROJECT_NAME} ${PROJECT_SOURCES})

# Set name of the output executable
set_target_properties(${PROJECT_NAME} PROPERTIES OUTPUT_NAME "opengl_playground")

# Include directories. Can also add headers from extra libraries
target_include_directories(${PROJECT_NAME} PRIVATE
    "${CMAKE_CURRENT_SOURCE_DIR}/src"
    #glad
    "${CMAKE_CURRENT_SOURCE_DIR}/external/glad/include"
    # all single file header libs
    "${CMAKE_CURRENT_SOURCE_DIR}/external/singles"
)

# Link libraries
target_link_libraries(${PROJECT_NAME}
    glfw
)

set(ASSETS_PATH "${CMAKE_SOURCE_DIR}/assets/") # absolute path for dev, change to relative path for release
#set(ASSETS_PATH "./assets/")
target_compile_definitions(${PROJECT_NAME} PUBLIC ASSETS_PATH="${ASSETS_PATH}")
