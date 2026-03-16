cmake_minimum_required(VERSION 3.10)
project(TP_PuntoFijo C)
add_subdirectory(tp_punto_fijo)
add_library(fixed_point STATIC 
    src/fixed_point_util.c
    )

target_include_directories(fixed_point PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/include
)