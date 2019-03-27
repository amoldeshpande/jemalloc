param(
	[string] $JEMALLOC_PREFIX,
	[string] $jemalloc_version_gid,
	[string] $outpath)

new-item -path $outpath\internal -type directory -Force >$null

"`r`n" | out-file -encoding ASCII $outpath\internal\private_namespace.h
"`r`n" | out-file -encoding ASCII $outpath\internal\public_namespace.h
"`r`n" | out-file -encoding ASCII $outpath\internal\private_namespace_jet.h

"`r`n" | out-file -encoding ASCII $outpath\jemalloc_protos_jet.h
$protos_lines = get-content -path $outpath\jemalloc_protos.h
$protos_lines | %{ $_ -replace "$JEMALLOC_PREFIX","jet_"} | out-file -encoding ASCII -append $outpath\jemalloc_protos_jet.h

"`r`n" | out-file -encoding ASCII $outpath\jemalloc_mangle_jet.h
$protos_lines = get-content -path $outpath\jemalloc_mangle.h
$protos_lines | %{ $_ -replace "$JEMALLOC_PREFIX","jet_"} | out-file -encoding ASCII -append $outpath\jemalloc_mangle_jet.h


"#ifndef JEMALLOC_NORENAME`r`n
#endif`r`n" | out-file -encoding ASCII $outpath\jemalloc_rename.h

$hdr = @("jemalloc_defs.h","jemalloc_rename.h", "jemalloc_macros.h",
           "jemalloc_protos.h", "jemalloc_typedefs.h", "jemalloc_mangle.h")

$final = "#ifndef JEMALLOC_H
#define JEMALLOC_H`r`n
#ifdef __cplusplus
extern `"C`" { 
#endif`r`n"

foreach($file in $hdr) {
	 gc -path "$outpath/$file" | %{
      if  ($_ -notmatch "Generated from .* by configure\." ) {
	   $final += ($_ -replace " $","") + "`r`n"
	   }
	  } 
	  $final += "`r`n"
} 
##define posix_memalign(p, a, s) (((*(p)) = _aligned_malloc((s), (a))), *(p) ?0 :errno)

$final += "#ifdef __cplusplus
}
#endif`r`n
#endif /*JEMALLOC_H*/"
$final |  out-file -encoding ASCII $outpath\jemalloc.h
