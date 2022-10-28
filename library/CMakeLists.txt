cmake_minimum_required(VERSION 3.21)
project(64Plus C)

set(CMAKE_C_STANDARD 17)

add_library(64Plus SHARED library.c)

add_custom_command(TARGET 64Plus
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:64Plus> ../../datafiles/lib64Plus.dll)