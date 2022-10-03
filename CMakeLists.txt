#1. postavimo ogranicenje minimalne verzije cmake
cmake_minimum_required(VERSION 3.20)

#2. dodamo projekat, dodamo ime i verzij
project(template VERSION 1.0.0)

#3. postavimo opciju da se generise COMPILATION DB, potrebno je za YCM
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

#4. postavimo da se po defaultu svi LIB prave kao SHARED .so libs
option(BUILD_SHARED_LIBS "build shared libraries" ON)

#5. podesimo configure file, koji ce biti procesiran i koji ce izgenerisati config.h.
#   Config.h ce sadrzati major i minor version projekta
configure_file(include/Config.h.in 
               ${CMAKE_CURRENT_SOURCE_DIR}/include/Config.h)

#6. dodamo binary programa
add_executable(template ${CMAKE_CURRENT_SOURCE_DIR}/src/main.cpp)

#7. definisemo include directories
target_include_directories(template PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)

#zaista nema Config.h fajla u ovom folderu ?! cccc :)
#hajde da izbildujemo projekat ipak, mozda uspe ;)
#izbildovacemo ga mojom kombinacijom tastera Ctrl-M bd za debug i Ctrl-M br za Release

#hajde da proverimo da li je ista uradio


#8. podesimo gde ce se cuvati izbildovani binaries
set_target_properties(template 
  PROPERTIES
  RUNTIME_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/bin/$<CONFIG>")
