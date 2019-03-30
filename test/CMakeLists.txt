include_directories(${CMAKE_CURRENT_LIST_DIR}/include ${CMAKE_CURRENT_BINARY_DIR}/include)

#This is done in jemalloc_test_defs.h.in, but that's a PITA with configure
add_definitions(-DHAVE_SSE2=1)

add_library(testlib STATIC "")
add_library(util_integration STATIC "")
add_library(util_cpp STATIC "")

SET(enable_prof 1)
SET(exe ".exe")
SET(abi "none")
SET(srcroot "${CMAKE_CURRENT_LIST_DIR}/")
SET(abs_srcroot "${CMAKE_CURRENT_LIST_DIR}/")
SET(abs_objroot "${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>")

configure_file(${CMAKE_CURRENT_LIST_DIR}/test.sh.in ${CMAKE_CURRENT_BINARY_DIR}/test.sh.temp @ONLY)
file(GENERATE 
	OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>/test.sh 
	INPUT ${CMAKE_CURRENT_BINARY_DIR}/test.sh.temp)

target_sources(testlib PRIVATE
 ${CMAKE_CURRENT_LIST_DIR}/src/btalloc.c 
 ${CMAKE_CURRENT_LIST_DIR}/src/btalloc_0.c 
	${CMAKE_CURRENT_LIST_DIR}/src/btalloc_1.c 
	${CMAKE_CURRENT_LIST_DIR}/src/math.c 
	${CMAKE_CURRENT_LIST_DIR}/src/mtx.c 
	${CMAKE_CURRENT_LIST_DIR}/src/mq.c 
	${CMAKE_CURRENT_LIST_DIR}/src/SFMT.c 
	${CMAKE_CURRENT_LIST_DIR}/src/test.c 
	${CMAKE_CURRENT_LIST_DIR}/src/thd.c 
	${CMAKE_CURRENT_LIST_DIR}/src/timer.c)

target_compile_definitions(testlib PRIVATE "-DJEMALLOC_UNIT_TEST")
#target_compile_options(testlib PRIVATE "-wd4047")

target_sources(util_integration PRIVATE
			  ${PROJECT_SOURCE_DIR}/src/nstime.c
			  ${PROJECT_SOURCE_DIR}/src/malloc_io.c
			)
target_sources(util_cpp PRIVATE
			  ${PROJECT_SOURCE_DIR}/src/nstime.c
			  ${PROJECT_SOURCE_DIR}/src/malloc_io.c)

SET(unit_test_list 
	${CMAKE_CURRENT_LIST_DIR}/unit/a0.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/arena_reset.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/atomic.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/background_thread.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/background_thread_enable.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/base.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/bitmap.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/bit_util.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/binshard.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/ckh.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/decay.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/div.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/emitter.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/extent_quantize.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/fork.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/hash.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/hook.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/huge.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/junk.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/junk_alloc.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/junk_free.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/log.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/mallctl.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/malloc_io.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/math.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/mq.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/mtx.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/pack.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/pages.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/ph.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/prng.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/prof_accum.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/prof_active.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/prof_gdump.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/prof_idump.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/prof_log.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/prof_reset.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/prof_tctx.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/prof_thread_name.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/ql.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/qr.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/rb.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/retained.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/rtree.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/seq.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/SFMT.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/sc.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/size_classes.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/slab.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/smoothstep.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/spin.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/stats.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/stats_print.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/test_hooks.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/ticker.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/nstime.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/tsd.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/witness.c 
	${CMAKE_CURRENT_LIST_DIR}/unit/zero.c
	)
if(${enable_prof})
SET(unit_test_list ${unit_test_list} ${CMAKE_CURRENT_LIST_DIR}/unit/arena_reset_prof.c)
endif()

#https://stackoverflow.com/questions/52666330/cmake-for-each-source-file-one-executable
foreach(file_path ${unit_test_list})
  string(REPLACE ".c" "" new_name ${file_path})
  get_filename_component(filename ${new_name} NAME)
  add_executable(${filename} ${file_path})

  target_compile_definitions(${filename} PRIVATE "-DJEMALLOC_UNIT_TEST")
  set_target_properties(${filename} PROPERTIES FOLDER "tests/unit_tests")
  set_target_properties(${filename} PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/test/$<CONFIG>/unit")
  target_link_libraries(${filename}  ${LIBRARY_DIR}/libjemalloc_jet.lib testlib)
  add_dependencies(${filename} testlib libjemalloc_jet)
endforeach()

SET(integration_test_list
  ${CMAKE_CURRENT_LIST_DIR}/integration/aligned_alloc.c 
	${CMAKE_CURRENT_LIST_DIR}/integration/allocated.c 
	${CMAKE_CURRENT_LIST_DIR}/integration/extent.c 
	${CMAKE_CURRENT_LIST_DIR}/integration/malloc.c 
	${CMAKE_CURRENT_LIST_DIR}/integration/mallocx.c 
	${CMAKE_CURRENT_LIST_DIR}/integration/MALLOCX_ARENA.c 
	${CMAKE_CURRENT_LIST_DIR}/integration/overflow.c 
	${CMAKE_CURRENT_LIST_DIR}/integration/posix_memalign.c 
	${CMAKE_CURRENT_LIST_DIR}/integration/rallocx.c 
	${CMAKE_CURRENT_LIST_DIR}/integration/sdallocx.c 
	${CMAKE_CURRENT_LIST_DIR}/integration/slab_sizes.c 
	${CMAKE_CURRENT_LIST_DIR}/integration/thread_arena.c 
	${CMAKE_CURRENT_LIST_DIR}/integration/thread_tcache_enabled.c 
	${CMAKE_CURRENT_LIST_DIR}/integration/xallocx.c
	${CMAKE_CURRENT_LIST_DIR}/integration/cpp/basic.cpp
	)
if(${enable_experimental_smallocx})
SET(integration_test_list ${integration_test_list } ${CMAKE_CURRENT_LIST_DIR}/integration/smallocx.c)
endif()
#https://stackoverflow.com/questions/52666330/cmake-for-each-source-file-one-executable
foreach(file_path ${integration_test_list})
  string(REPLACE ".c" "" new_name ${file_path})
  get_filename_component(filename ${new_name} NAME)
  add_executable(${filename} ${file_path})

 target_compile_definitions(${filename} PRIVATE "-DJEMALLOC_INTEGRATION_TEST")
  set_target_properties(${filename} PROPERTIES FOLDER "tests/integration_tests")
  set_target_properties(${filename} PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/test/$<CONFIG>/integration")
  target_link_libraries(${filename}  ${LIBRARY_DIR}/libjemalloc_jet.lib testlib util_integration)
endforeach()

if(${enable_cxx})
add_library(cpp_src STATIC "")
target_sources(cpp_src PRIVATE ${PROJECT_SOURCE_DIR}/src/jemalloc_cpp.cpp)
set_target_properties(cpp_src PROPERTIES FOLDER "testlibs")
target_compile_definitions(cpp_src PRIVATE "-DJEMALLOC_INTEGRATION_TEST")

add_executable(basic ${CMAKE_CURRENT_LIST_DIR}/integration/cpp/basic.cpp)
set_target_properties(basic PROPERTIES FOLDER "tests/integration_tests/basic")
set_target_properties(basic PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/test/$<CONFIG>/integration/cpp")
target_compile_definitions(basic PRIVATE "-DJEMALLOC_INTEGRATION_TEST")
target_link_libraries(basic  ${LIBRARY_DIR}/libjemalloc_jet.lib testlib util_integration cpp_src)
endif()

SET(stress_test_list
   ${CMAKE_CURRENT_LIST_DIR}/stress/microbench.c 
	${CMAKE_CURRENT_LIST_DIR}/stress/hookbench.c)
#https://stackoverflow.com/questions/52666330/cmake-for-each-source-file-one-executable
foreach(file_path ${stress_test_list})
  string(REPLACE ".c" "" new_name ${file_path})
  get_filename_component(filename ${new_name} NAME)
  add_executable(${filename} ${file_path})

target_compile_definitions(${filename} PRIVATE "-DJEMALLOC_STRESS_TEST")
  set_target_properties(${filename} PROPERTIES FOLDER "tests/stress_tests")
  set_target_properties(${filename} PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/test$<CONFIG>/stress")
  target_link_libraries(${filename}  ${LIBRARY_DIR}/libjemalloc_jet.lib testlib)
endforeach()


set_target_properties(testlib PROPERTIES FOLDER "testlibs")
set_target_properties(util_integration PROPERTIES FOLDER "testlibs")
set_target_properties(util_cpp PROPERTIES FOLDER "testlibs")

file(GENERATE 
	OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>/runtest_windows.cmd
	INPUT ${CMAKE_CURRENT_LIST_DIR}/runtests_windows.cmd)

STRING(REPLACE ";" "\n" tempu "${unit_test_list}")
STRING(REPLACE "/" "\\" output "${tempu}")
file(GENERATE OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>/unittests.txt CONTENT "${output}")

STRING(REPLACE ";" "\n" tempi "${integration_test_list}")
STRING(REPLACE "/" "\\" output "${tempi}")
file(GENERATE OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>/integrationtests.txt CONTENT "${output}")

STRING(REPLACE ";" "\n" temps "${stress_test_list}")
STRING(REPLACE "/" "\\" output "${temps}")
file(GENERATE OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>/stresstests.txt CONTENT "${output}")

STRING(REPLACE "/" "\\" tempsrc "${CMAKE_CURRENT_LIST_DIR}")
file(GENERATE OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>/sourcepath.txt CONTENT "${tempsrc}")
