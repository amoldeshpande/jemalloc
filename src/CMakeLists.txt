SET(libsources	${CMAKE_CURRENT_LIST_DIR}/jemalloc.c 
	${CMAKE_CURRENT_LIST_DIR}/arena.c 
	${CMAKE_CURRENT_LIST_DIR}/background_thread.c 
	${CMAKE_CURRENT_LIST_DIR}/base.c 
	${CMAKE_CURRENT_LIST_DIR}/bin.c 
	${CMAKE_CURRENT_LIST_DIR}/bitmap.c 
	${CMAKE_CURRENT_LIST_DIR}/ckh.c 
	${CMAKE_CURRENT_LIST_DIR}/ctl.c 
	${CMAKE_CURRENT_LIST_DIR}/div.c 
	${CMAKE_CURRENT_LIST_DIR}/extent.c 
	${CMAKE_CURRENT_LIST_DIR}/extent_dss.c 
	${CMAKE_CURRENT_LIST_DIR}/extent_mmap.c 
	${CMAKE_CURRENT_LIST_DIR}/hash.c 
	${CMAKE_CURRENT_LIST_DIR}/hook.c 
	${CMAKE_CURRENT_LIST_DIR}/large.c 
	${CMAKE_CURRENT_LIST_DIR}/log.c 
	${CMAKE_CURRENT_LIST_DIR}/malloc_io.c 
	${CMAKE_CURRENT_LIST_DIR}/mutex.c 
	${CMAKE_CURRENT_LIST_DIR}/mutex_pool.c 
	${CMAKE_CURRENT_LIST_DIR}/nstime.c 
	${CMAKE_CURRENT_LIST_DIR}/pages.c 
	${CMAKE_CURRENT_LIST_DIR}/prng.c 
	${CMAKE_CURRENT_LIST_DIR}/prof.c 
	${CMAKE_CURRENT_LIST_DIR}/rtree.c 
	${CMAKE_CURRENT_LIST_DIR}/stats.c 
	${CMAKE_CURRENT_LIST_DIR}/sz.c 
	${CMAKE_CURRENT_LIST_DIR}/sc.c 
	${CMAKE_CURRENT_LIST_DIR}/tcache.c 
	${CMAKE_CURRENT_LIST_DIR}/ticker.c
	${CMAKE_CURRENT_LIST_DIR}/test_hooks.c 
	${CMAKE_CURRENT_LIST_DIR}/tsd.c 
	${CMAKE_CURRENT_LIST_DIR}/witness.c)

target_sources(libjemalloc PRIVATE  ${libsources})
target_sources(libjemalloc_jet PRIVATE  ${libsources})
target_compile_definitions(libjemalloc_jet PRIVATE "-DJEMALLOC_JET")


IF (enable_zone_allocator)
target_sources(libjemalloc PRIVATE ${CMAKE_CURRENT_LIST_DIR}/zone.c)
ENDIF()
