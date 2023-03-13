/*
 * MATLAB Compiler: 3.0
 * Date: Mon May 28 10:15:42 2007
 * Arguments: "-B" "macro_default" "-O" "all" "-O" "fold_scalar_mxarrays:on"
 * "-O" "fold_non_scalar_mxarrays:on" "-O" "optimize_integer_for_loops:on" "-O"
 * "array_indexing:on" "-O" "optimize_conditionals:on" "-x" "-W" "mex" "-L" "C"
 * "-t" "-T" "link:mexlibrary" "libmatlbmx.mlib" "shiftfft2" 
 */

#ifndef MLF_V2
#define MLF_V2 1
#endif

#ifndef __shiftfft2_h
#define __shiftfft2_h 1

#ifdef __cplusplus
extern "C" {
#endif

#include "libmatlb.h"

extern void InitializeModule_shiftfft2(void);
extern void TerminateModule_shiftfft2(void);
extern _mexLocalFunctionTable _local_function_table_shiftfft2;

extern mxArray * mlfShiftfft2(mxArray * f);
extern void mlxShiftfft2(int nlhs,
                         mxArray * plhs[],
                         int nrhs,
                         mxArray * prhs[]);

#ifdef __cplusplus
}
#endif

#endif
