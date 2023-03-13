/*
 * MATLAB Compiler: 3.0
 * Date: Mon May 28 10:15:42 2007
 * Arguments: "-B" "macro_default" "-O" "all" "-O" "fold_scalar_mxarrays:on"
 * "-O" "fold_non_scalar_mxarrays:on" "-O" "optimize_integer_for_loops:on" "-O"
 * "array_indexing:on" "-O" "optimize_conditionals:on" "-x" "-W" "mex" "-L" "C"
 * "-t" "-T" "link:mexlibrary" "libmatlbmx.mlib" "shiftfft2" 
 */
#include "shiftfft2.h"
#include "fft2.h"
#include "fftshift.h"
#include "libmatlbm.h"

void InitializeModule_shiftfft2(void) {
}

void TerminateModule_shiftfft2(void) {
}

static mxArray * Mshiftfft2(int nargout_, mxArray * f);

_mexLocalFunctionTable _local_function_table_shiftfft2
  = { 0, (mexFunctionTableEntry *)NULL };

/*
 * The function "mlfShiftfft2" contains the normal interface for the
 * "shiftfft2" M-function from file "e:\matlab_users\shiftfft2.m" (lines 1-16).
 * This function processes any input arguments and passes them to the
 * implementation version of the function, appearing above.
 */
mxArray * mlfShiftfft2(mxArray * f) {
    int nargout = 1;
    mxArray * x = NULL;
    mlfEnterNewContext(0, 1, f);
    x = Mshiftfft2(nargout, f);
    mlfRestorePreviousContext(0, 1, f);
    return mlfReturnValue(x);
}

/*
 * The function "mlxShiftfft2" contains the feval interface for the "shiftfft2"
 * M-function from file "e:\matlab_users\shiftfft2.m" (lines 1-16). The feval
 * function calls the implementation version of shiftfft2 through this
 * function. This function processes any input arguments and passes them to the
 * implementation version of the function, appearing above.
 */
void mlxShiftfft2(int nlhs, mxArray * plhs[], int nrhs, mxArray * prhs[]) {
    mxArray * mprhs[1];
    mxArray * mplhs[1];
    int i;
    if (nlhs > 1) {
        mlfError(
          mxCreateString(
            "Run-time Error: File: shiftfft2 Line: 1 Column:"
            " 1 The function \"shiftfft2\" was called with m"
            "ore than the declared number of outputs (1)."),
          NULL);
    }
    if (nrhs > 1) {
        mlfError(
          mxCreateString(
            "Run-time Error: File: shiftfft2 Line: 1 Column:"
            " 1 The function \"shiftfft2\" was called with m"
            "ore than the declared number of inputs (1)."),
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
    mplhs[0] = Mshiftfft2(nlhs, mprhs[0]);
    mlfRestorePreviousContext(0, 1, mprhs[0]);
    plhs[0] = mplhs[0];
}

/*
 * The function "Mshiftfft2" is the implementation version of the "shiftfft2"
 * M-function from file "e:\matlab_users\shiftfft2.m" (lines 1-16). It contains
 * the actual compiled code for that M-function. It is a static function and
 * must only be called from one of the interface functions, appearing below.
 */
/*
 * function x = shiftfft2(f)
 */
static mxArray * Mshiftfft2(int nargout_, mxArray * f) {
    mexLocalFunctionTable save_local_function_table_
      = mclSetCurrentLocalFunctionTable(&_local_function_table_shiftfft2);
    mxArray * x = NULL;
    mxArray * n = NULL;
    mxArray * m = NULL;
    mclCopyArray(&f);
    /*
     * %SHIFTFFT2	Two-dimensional inverse discrete Fourier transform.
     * %	SHIFTFFT2(F) returns the two-dimensional inverse Fourier transform
     * %	of matrix F.  If F is a vector, the result will have the same
     * %	orientation.
     * %
     * %	See also FFT2, FFTSHIFT.
     * 
     * % Transform.
     * 
     * [m,n] = size(f);
     */
    mlfSize(mlfVarargout(&m, &n, NULL), mclVa(f, "f"), NULL);
    /*
     * 
     * x = fftshift( fft2( fftshift(f) ) ) / ( m * n );
     */
    mlfAssign(
      &x,
      mclMrdivide(
        mlfFftshift(
          mlfFft2(mlfFftshift(mclVa(f, "f"), NULL), NULL, NULL), NULL),
        mclMtimes(mclVv(m, "m"), mclVv(n, "n"))));
    mclValidateOutput(x, 1, nargout_, "x", "shiftfft2");
    mxDestroyArray(m);
    mxDestroyArray(n);
    mxDestroyArray(f);
    mclSetCurrentLocalFunctionTable(save_local_function_table_);
    return x;
    /*
     * 
     * %x = fftshift( fft2( fftshift(f) ) );
     */
}
