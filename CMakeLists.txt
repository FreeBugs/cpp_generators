cmake_minimum_required(VERSION 3.23)
set(CMAKE_VERBOSE_MAKEFILE yes)
project(cpp_generators)

set(CMAKE_CXX_STANDARD 17)

function(generator_command LIBNUM)
    set(FILES source_${LIBNUM}.cpp source_${LIBNUM}.hpp included_file.hpp)

    list(REMOVE_ITEM FILES ${ALL_GENERATED_FILES})
    list(APPEND ALL_GENERATED_FILES ${FILES})
    message(STATUS "Newly generated files by target ${LIBNUM}: ${FILES}")
    message(STATUS "ALL_GENERATED_FILES: ${ALL_GENERATED_FILES}")
    set(ALL_GENERATED_FILES ${ALL_GENERATED_FILES} PARENT_SCOPE)

    add_custom_command(
            OUTPUT ${FILES}
            COMMAND ${CMAKE_SOURCE_DIR}/fake_generator.sh ${LIBNUM}
    )
    set_source_files_properties(${FILES} GENERATED)

    set(generated_files_${LIBNUM} ${FILES} PARENT_SCOPE)
endfunction()

function(add_generated_lib LIBNUM)
    message(STATUS "Adding library ${LIBNUM}")
    generator_command(${LIBNUM})
    message(STATUS "Generated files: ${generated_files_${LIBNUM}}")
    add_library(generated_library_${LIBNUM} ${generated_files_${LIBNUM}})
    set(ALL_GENERATED_FILES ${ALL_GENERATED_FILES} PARENT_SCOPE)
endfunction()

add_generated_lib(1)
add_generated_lib(2)

add_executable(cpp_generators main.cpp)
target_include_directories(cpp_generators PUBLIC ${CMAKE_BINARY_DIR})
target_link_libraries(cpp_generators generated_library_1 generated_library_2)

