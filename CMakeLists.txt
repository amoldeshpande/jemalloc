cmake_minimum_required(VERSION 2.8)

set_property(GLOBAL PROPERTY USE_FOLDERS ON) 

project(jemalloc)

include(${CMAKE_CURRENT_SOURCE_DIR}/include/jemalloc/gen_headers_cmake.txt)


SET(CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING "" FORCE)

enable_language( CXX )
set( CMAKE_CXX_STANDARD 14 )
set( CMAKE_CXX_STANDARD_REQUIRED on )
set( CMAKE_CXX_STANDARD_REQUIRED on )

IF(MSVC)
IF(CMAKE_CXX_COMPILER_VERSION VERSION_LESS 19.16)
    MESSAGE(FATAL_ERROR "Visual Studio 2017 15.9.5 or later is required to build on Windows")
ELSE()
SET(MY_CMAKE_CXX_FLAGS "-W4 -WX -Zi  -DWIN32_LEAN_AND_MEAN -DNOMINMAX -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE -D_WINSOCK_DEPRECATED_NO_WARNINGS  -std:c++14 -MP")

SET(MY_CMAKE_CXX_FLAGS_DEBUG "${MY_CMAKE_CXX_FLAGS} -MTd -Od")
SET(MY_CMAKE_CXX_FLAGS_RELEASE "${MY_CMAKE_CXX_FLAGS} -MT -Ox -DNDEBUG")

ENDIF()
ELSE()
MESSAGE(FATAL_ERROR "Sorry, only Visual C++ is supported")
ENDIF()



SET(CMAKE_CXX_FLAGS_DEBUG ${MY_CMAKE_CXX_FLAGS_DEBUG} CACHE STRING "" FORCE)
SET(CMAKE_CXX_FLAGS_RELEASE ${MY_CMAKE_CXX_FLAGS_RELEASE} CACHE STRING "" FORCE)

SET(CMAKE_C_FLAGS_DEBUG ${MY_CMAKE_CXX_FLAGS_DEBUG} CACHE STRING "" FORCE)
SET(CMAKE_C_FLAGS_RELEASE ${MY_CMAKE_CXX_FLAGS_RELEASE} CACHE STRING "" FORCE)

SET(CMAKE_INCLUDE_CURRENT_DIR OFF)



include_directories( 
				${CMAKE_CURRENT_SOURCE_DIR}
				${CMAKE_CURRENT_SOURCE_DIR}/include
				${CMAKE_CURRENT_SOURCE_DIR}/include/msvc_compat
				${CMAKE_CURRENT_BINARY_DIR}/include
				)

add_library(libjemalloc STATIC "")
add_library(libjemalloc_jet STATIC "")

set_target_properties(libjemalloc PROPERTIES FOLDER "libjemalloc")
set_target_properties(libjemalloc_jet PROPERTIES FOLDER "libjemalloc_jet")



set(LIBRARY_DIR ${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>)

set(enable_cxx 1)

add_subdirectory(src)

add_subdirectory(test)

