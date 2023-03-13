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

#include "libmatlb.h"
#include "mk_intensity.h"

extern _mex_information _mex_info;

static mexFunctionTableEntry function_table[1]
  = { { "mk_intensity", mlxMk_intensity, 1, 1,
        &_local_function_table_mk_intensity } };

static _mexInitTermTableEntry init_term_table[1]
  = { { InitializeModule_mk_intensity, TerminateModule_mk_intensity } };

/*
 * The function "mexLibrary" is a Compiler-generated mex wrapper, suitable for
 * building a MEX-function. It initializes any persistent variables as well as
 * a function table for use by the feval function. It then calls the function
 * "mlxMk_intensity". Finally, it clears the feval table and exits.
 */
mex_information mexLibrary(void) {
    mclMexLibraryInit();
    return &_mex_info;
}

_mex_information _mex_info
  = { 1, 1, function_table, 0, NULL, 0, NULL, 1, init_term_table };