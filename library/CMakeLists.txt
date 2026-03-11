cmake_minimum_required(VERSION 3.21)
project(64Plus C)

set(CMAKE_C_STANDARD 17)

# Find SDL2
find_package(SDL2 REQUIRED)

add_library(64Plus SHARED library.c controller_input.c)

target_include_directories(64Plus PRIVATE ${SDL2_INCLUDE_DIRS})
target_link_libraries(64Plus PRIVATE ${SDL2_LIBRARIES})

add_custom_command(TARGET 64Plus
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:64Plus> ../../datafiles/lib64Plus.dll)