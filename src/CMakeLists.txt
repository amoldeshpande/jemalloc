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



SET(libheaders 
	  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/arena_externs.h
	  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/arena_inlines_a.h
	  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/arena_inlines_b.h
	  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/arena_stats.h
	  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/arena_structs_a.h
	  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/arena_structs_b.h
	  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/arena_types.h
	  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/assert.h
	  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/atomic.h
	  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/atomic_c11.h
	  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/atomic_gcc_atomic.h
	  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/atomic_gcc_sync.h
	  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/atomic_msvc.h
	  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/background_thread_externs.h
	  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/background_thread_inlines.h
	  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/background_thread_structs.h
	  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/base_externs.h
	  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/base_inlines.h
	  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/base_structs.h
	  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/base_types.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/bin.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/bin_stats.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/bin_types.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/bit_util.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/bitmap.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/cache_bin.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/ckh.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/ctl.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/div.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/emitter.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/extent_dss.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/extent_externs.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/extent_inlines.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/extent_mmap.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/extent_structs.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/extent_types.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/hash.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/hook.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/jemalloc_internal_decls.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/jemalloc_internal_externs.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/jemalloc_internal_includes.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/jemalloc_internal_inlines_a.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/jemalloc_internal_inlines_b.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/jemalloc_internal_inlines_c.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/jemalloc_internal_macros.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/jemalloc_internal_types.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/large_externs.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/log.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/malloc_io.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/mutex.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/mutex_pool.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/mutex_prof.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/nstime.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/pages.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/ph.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/prng.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/prof_externs.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/prof_inlines_a.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/prof_inlines_b.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/prof_structs.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/prof_types.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/ql.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/qr.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/quantum.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/rb.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/rtree.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/rtree_tsd.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/sc.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/seq.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/smoothstep.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/spin.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/stats.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/sz.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/tcache_externs.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/tcache_inlines.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/tcache_structs.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/tcache_types.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/test_hooks.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/ticker.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/tsd.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/tsd_generic.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/tsd_malloc_thread_cleanup.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/tsd_tls.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/tsd_types.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/tsd_win.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/util.h
  ${CMAKE_SOURCE_DIR}/include/jemalloc/internal/witness.h
  ${CMAKE_SOURCE_DIR}/include/msvc_compat/warnings_disabled.h
  ${CMAKE_SOURCE_DIR}/include/msvc_compat/windows_extra.h
  ${CMAKE_SOURCE_DIR}/include/msvc_compat/strings.h
  ${CMAKE_SOURCE_DIR}/include/msvc_compat/C99/stdbool.h
  ${CMAKE_SOURCE_DIR}/include/msvc_compat/C99/stdint.h

  ${PROJECT_BINARY_DIR}/include/jemalloc/jemalloc.h
  ${PROJECT_BINARY_DIR}/include/jemalloc/jemalloc_defs.h
  ${PROJECT_BINARY_DIR}/include/jemalloc/jemalloc_macros.h
  ${PROJECT_BINARY_DIR}/include/jemalloc/jemalloc_mangle.h
  ${PROJECT_BINARY_DIR}/include/jemalloc/jemalloc_mangle_jet.h
  ${PROJECT_BINARY_DIR}/include/jemalloc/jemalloc_protos.h
  ${PROJECT_BINARY_DIR}/include/jemalloc/jemalloc_protos_jet.h
  ${PROJECT_BINARY_DIR}/include/jemalloc/jemalloc_rename.h
  ${PROJECT_BINARY_DIR}/include/jemalloc/jemalloc_typedefs.h
  ${PROJECT_BINARY_DIR}/include/jemalloc/internal/jemalloc_internal_defs.h
  ${PROJECT_BINARY_DIR}/include/jemalloc/internal/jemalloc_preamble.h
  ${PROJECT_BINARY_DIR}/include/jemalloc/internal/private_namespace.h
  ${PROJECT_BINARY_DIR}/include/jemalloc/internal/private_namespace_jet.h
  ${PROJECT_BINARY_DIR}/include/jemalloc/internal/public_namespace.h
  ${PROJECT_BINARY_DIR}/include/jemalloc/internal/public_symbols.txt
  ${PROJECT_BINARY_DIR}/include/jemalloc/internal/public_unnamespace.h
  )

target_sources(libjemalloc PRIVATE  ${libsources} ${libheaders})
target_sources(libjemalloc_jet PRIVATE  ${libsources})
target_compile_definitions(libjemalloc_jet PRIVATE "-DJEMALLOC_JET")


IF (enable_zone_allocator)
target_sources(libjemalloc PRIVATE ${PROJECT_LIST_SOURCE_DIR}/zone.c)
ENDIF()


