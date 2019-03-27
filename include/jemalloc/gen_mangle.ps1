param(
	[string] $JEMALLOC_PREFIX,
	[string] $jemalloc_version_gid,
	[string] $outpath)

$public_syms=@("aligned_alloc","calloc","dallocx","free","mallctl","mallctlbymib","mallctlnametomib","malloc","malloc_conf","malloc_message","malloc_stats_print","malloc_usable_size","mallocx","smallocx_${jemalloc_version_gid}","nallocx","posix_memalign","rallocx","realloc","sallocx","sdallocx","xallocx")

new-item -path $outpath\internal -type directory -Force >$null

# create public_symbols.txt and jemalloc_mangle.h
"" | out-file -encoding ASCII $outpath\internal\public_symbols.txt
foreach( $sym in $public_syms ) {
 $n="$sym"
 "$n`:$n`r`n" | out-file -append -encoding ASCII $outpath\internal\public_symbols.txt
}

$mangle_hdr = "
/*
 * By default application code must explicitly refer to mangled symbol names,
 * so that it is possible to use jemalloc in conjunction with another allocator
 * in the same application.  Define JEMALLOC_MANGLE in order to cause automatic
 * name mangling that matches the API prefixing that happened as a result of
 * --with-mangling and/or --with-jemalloc-prefix configuration settings.
 */
#ifdef JEMALLOC_MANGLE
#  ifndef JEMALLOC_NO_DEMANGLE
#    define JEMALLOC_NO_DEMANGLE
#  endif
"
$pubsym_lines = get-content -path $outpath\internal\public_symbols.txt |where-object  {$_.Trim() -ne ""}
foreach($line in $pubsym_lines) {
  $lin=$line.split(':')
  $mangle_hdr += "`r`n#  define " +  $lin[0] + " ${JEMALLOC_PREFIX}" + $lin[1] + "`r`n"
}

$mangle_hdr +="#endif

/*
 * The ${symbol_prefix}* macros can be used as stable alternative names for the
 * public jemalloc API if JEMALLOC_NO_DEMANGLE is defined.  This is primarily
 * meant for use in jemalloc itself, but it can be used by application code to
 * provide isolation from the name mangling specified via --with-mangling
 * and/or --with-jemalloc-prefix.
 */
#ifndef JEMALLOC_NO_DEMANGLE
"


foreach($line in $pubsym_lines) {
  $lin=$line.split(':')
  $x = "`r`n#  undef "+  " ${JEMALLOC_PREFIX}" + $lin[1] + "`r`n"
  $mangle_hdr += $x
  $unnamespace += $x
}
$mangle_hdr +="#endif"

$mangle_hdr | out-file -encoding ASCII $outpath\jemalloc_mangle.h

$unnamespace | out-file -encoding ASCII $outpath\internal\public_unnamespace.h
