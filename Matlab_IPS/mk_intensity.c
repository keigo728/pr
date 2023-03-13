/*
 * MATLAB Compiler: 3.0
 * Date: Mon May 28 10:14:58 2007
 * Arguments: "-B" "macro_default" "-O" "all" "-O" "fold_scalar_mxarrays:on"
 * "-O" "fold_non_scalar_mxarrays:on" "-O" "optimize_integer_for_loops:on" "-O"
 * "array_indexing:on" "-O" "optimize_conditionals:on" "-x" "-W" "mex" "-L" "C"
 * "-t" "-T" "link:mexlibrary" "libmatlbmx.mlib" "mk_intensity" 
 */
#include "mk_intensity.h"
#include "libmatlbm.h"
static mxArray * _mxarray0_;

void InitializeModule_mk_intensity(void) {
    _mxarray0_ = mclInitializeDouble(2.0);
}

void TerminateModule_mk_intensity(void) {
    mxDestroyArray(_mxarray0_);
}

static mxArray * Mmk_intensity(int nargout_, mxArray * f);

_mexLocalFunctionTable _local_function_table_mk_intensity
  = { 0, (mexFunctionTableEntry *)NULL };

/*
 * The function "mlfMk_intensity" contains the normal interface for the
 * "mk_intensity" M-function from file "e:\matlab_users\mk_intensity.m" (lines
 * 1-10). This function processes any input arguments and passes them to the
 * implementation version of the function, appearing above.
 */
mxArray * mlfMk_intensity(mxArray * f) {
    int nargout = 1;
    mxArray * x = NULL;
    mlfEnterNewContext(0, 1, f);
    x = Mmk_intensity(nargout, f);
    mlfRestorePreviousContext(0, 1, f);
    return mlfReturnValue(x);
}

/*
 * The function "mlxMk_intensity" contains the feval interface for the
 * "mk_intensity" M-function from file "e:\matlab_users\mk_intensity.m" (lines
 * 1-10). The feval function calls the implementation version of mk_intensity
 * through this function. This function processes any input arguments and
 * passes them to the implementation version of the function, appearing above.
 */
void mlxMk_intensity(int nlhs, mxArray * plhs[], int nrhs, mxArray * prhs[]) {
    mxArray * mprhs[1];
    mxArray * mplhs[1];
    int i;
    if (nlhs > 1) {
        mlfError(
          mxCreateString(
            "Run-time Error: File: mk_intensity Line: 1 Column"
            ": 1 The function \"mk_intensity\" was called with"
            " more than the declared number of outputs (1)."),
          NULL);
    }
    if (nrhs > 1) {
        mlfError(
          mxCreateString(
            "Run-time Error: File: mk_intensity Line: 1 Column"
            ": 1 The function \"mk_intensity\" was called with"
            " more than the declared number of inputs (1)."),
          NULL);
    }
    for (i = 0; i < 1; ++i) {
        mplhs[i] = NULL;
    }
    for (i = 0; i < 1 && i < nrhs; ++i) {
        mprhs[i] = prhs[i];
    }
    for (; i < 1; ++i) {
        mprhs[i] = NULL;
    }
    mlfEnterNewContext(0, 1, mprhs[0]);
    mplhs[0] = Mmk_intensity(nlhs, mprhs[0]);
    mlfRestorePreviousContext(0, 1, mprhs[0]);
    plhs[0] = mplhs[0];
}

/*
 * The function "Mmk_intensity" is the implementation version of the
 * "mk_intensity" M-function from file "e:\matlab_users\mk_intensity.m" (lines
 * 1-10). It contains the actual compiled code for that M-function. It is a
 * static function and must only be called from one of the interface functions,
 * appearing below.
 */
/*
 * function x = mk_intensity(f)
 */
static mxArray * Mmk_intensity(int nargout_, mxArray * f) {
    mexLocalFunctionTable save_local_function_table_
      = mclSetCurrentLocalFunctionTable(&_local_function_table_mk_intensity);
    mxArray * x = NULL;
    mclCopyArray(&f);
    /*
     * %MK_INTENSITY	make intensity from complex number.
     * %	MK_INTENSITY(F) returns the intensity from complex number.
     * %	If F is a vector, the result will have the same orientation.
     * %
     * 
     * % Make intensity.
     * 
     * x = real(f).^2 + imag(f).^2;
     */
    mlfAssign(
      &x,
      mclPlus(
        mlfPower(mlfReal(mclVa(f, "f")), _mxarray0_),
        mlfPower(mlfImag(mclVa(f, "f")), _mxarray0_)));
    mclValidateOutput(x, 1, nargout_, "x", "mk_intensity");
    mxDestroyArray(f);
    mclSetCurrentLocalFunctionTable(save_local_function_table_);
    return x;
}
