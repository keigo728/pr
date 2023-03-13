/*
 * MATLAB Compiler: 3.0
 * Date: Mon May 28 10:14:58 2007
 * Arguments: "-B" "macro_default" "-O" "all" "-O" "fold_scalar_mxarrays:on"
 * "-O" "fold_non_scalar_mxarrays:on" "-O" "optimize_integer_for_loops:on" "-O"
 * "array_indexing:on" "-O" "optimize_conditionals:on" "-x" "-W" "mex" "-L" "C"
 * "-t" "-T" "link:mexlibrary" "libmatlbmx.mlib" "mk_intensity" 
 */

#ifndef MLF_V2
#define MLF_V2 1
#endif

#ifndef __mk_intensity_h
#define __mk_intensity_h 1

#ifdef __cplusplus
extern "C" {
#endif

#include "libmatlb.h"

extern void InitializeModule_mk_intensity(void);
extern void TerminateModule_mk_intensity(void);
extern _mexLocalFunctionTable _local_function_table_mk_intensity;

extern mxArray * mlfMk_intensity(mxArray * f);
extern void mlxMk_intensity(int nlhs,
                            mxArray * plhs[],
                            int nrhs,
                            mxArray * prhs[]);

#ifdef __cplusplus
}
#endif

#endif
