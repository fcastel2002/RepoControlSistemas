add_executable(ex_01 ./archivos_catedra/ex_01.c)
add_executable(ex_02 ./archivos_catedra/ex_02.c)
add_executable(ex_04 ./archivos_catedra/ex_04.c)
add_executable(ejercicio_03 ./ej_3.c)
add_executable(ejercicio_05 ./ejercicio_5.c)
add_executable(ex_05 ./archivos_catedra/ex_05.c)
# Reproduce: gcc -Wall -std=c99 ex_02.c -o ex_02 -lm -frounding-math -fsignaling-nans
target_compile_features(ex_02 PRIVATE c_std_99)
target_compile_options(ex_02 PRIVATE -Wall -frounding-math -fsignaling-nans)
target_link_libraries(ex_02 PRIVATE m)

# Reproduce: -lm -march=corei7 -frounding-math -fsignaling-nans
target_compile_features(ex_04 PRIVATE c_std_99)
target_compile_options(ex_04 PRIVATE -Wall -march=corei7 -frounding-math -fsignaling-nans)
target_link_libraries(ex_04 PRIVATE m)
# Reproduce: -lm -march=corei7 -frounding-math -fsignaling-nans
target_compile_features(ejercicio_05 PRIVATE c_std_99)
target_compile_options(ejercicio_05 PRIVATE -Wall -march=corei7 -frounding-math -fsignaling-nans)
target_link_libraries(ejercicio_05 PRIVATE m)

#Reproduce: gcc -Wall -std=c99 ex_05.c -o ex_05 -lm -frounding-math -fsignaling-nans -DLINUX
target_compile_features(ex_05 PRIVATE c_std_99)
target_compile_options(ex_05 PRIVATE -Wall -frounding-math -fsignaling-nans -DLINUX)
target_link_libraries(ex_05 PRIVATE m)