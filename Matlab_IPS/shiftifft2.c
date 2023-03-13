/*
 * MATLAB Compiler: 3.0
 * Date: Mon May 28 10:15:52 2007
 * Arguments: "-B" "macro_default" "-O" "all" "-O" "fold_scalar_mxarrays:on"
 * "-O" "fold_non_scalar_mxarrays:on" "-O" "optimize_integer_for_loops:on" "-O"
 * "array_indexing:on" "-O" "optimize_conditionals:on" "-x" "-W" "mex" "-L" "C"
 * "-t" "-T" "link:mexlibrary" "libmatlbmx.mlib" "shiftifft2" 
 */
#include "shiftifft2.h"
#include "fftshift.h"
#include "ifft2.h"
#include "libmatlbm.h"

void InitializeModule_shiftifft2(void) {
}

void TerminateModule_shiftifft2(void) {
}

static mxArray * Mshiftifft2(int nargout_, mxArray * f);

_mexLocalFunctionTable _local_function_table_shiftifft2
  = { 0, (mexFunctionTableEntry *)NULL };

/*
 * The function "mlfShiftifft2" contains the normal interface for the
 * "shiftifft2" M-function from file "e:\matlab_users\shiftifft2.m" (lines
 * 1-14). This function processes any input arguments and passes them to the
 * implementation version of the function, appearing above.
 */
mxArray * mlfShiftifft2(mxArray * f) {
    int nargout = 1;
    mxArray * x = NULL;
    mlfEnterNewContext(0, 1, f);
    x = Mshiftifft2(nargout, f);
    mlfRestorePreviousContext(0, 1, f);
    return mlfReturnValue(x);
}

/*
 * The function "mlxShiftifft2" contains the feval interface for the
 * "shiftifft2" M-function from file "e:\matlab_users\shiftifft2.m" (lines
 * 1-14). The feval function calls the implementation version of shiftifft2
 * through this function. This function processes any input arguments and
 * passes them to the implementation version of the function, appearing above.
 */
void mlxShiftifft2(int nlhs, mxArray * plhs[], int nrhs, mxArray * prhs[]) {
    mxArray * mprhs[1];
    mxArray * mplhs[1];
    int i;
    if (nlhs > 1) {
        mlfError(
          mxCreateString(
            "Run-time Error: File: shiftifft2 Line: 1 Column:"
            " 1 The function \"shiftifft2\" was called with m"
            "ore than the declared number of outputs (1)."),
          NULL);
    }
    if (nrhs > 1) {
        mlfError(
          mxCreateString(
            "Run-time Error: File: shiftifft2 Line: 1 Column"
            ": 1 The function \"shiftifft2\" was called with"
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
    mplhs[0] = Mshiftifft2(nlhs, mprhs[0]);
    mlfRestorePreviousContext(0, 1, mprhs[0]);
    plhs[0] = mplhs[0];
}

/*
 * The function "Mshiftifft2" is the implementation version of the "shiftifft2"
 * M-function from file "e:\matlab_users\shiftifft2.m" (lines 1-14). It
 * contains the actual compiled code for that M-function. It is a static
 * function and must only be called from one of the interface functions,
 * appearing below.
 */
/*
 * function x = shiftifft2(f)
 */
static mxArray * Mshiftifft2(int nargout_, mxArray * f) {
    mexLocalFunctionTable save_local_function_table_
      = mclSetCurrentLocalFunctionTable(&_local_function_table_shiftifft2);
    mxArray * x = NULL;
    mclCopyArray(&f);
    /*
     * %SHIFTIFFT2	Two-dimensional inverse discrete Fourier transform.
     * %	SHIFTIFFT2(F) returns the two-dimensional inverse Fourier transform
     * %	of matrix F.  If F is a vector, the result will have the same
     * %	orientation.
     * %
     * %	See also IFFT2, FFTSHIFT.
     * 
     * % Transform.
     * 
     * %[m,n] = size(f);
     * 
     * x = fftshift( ifft2( fftshift( f ) ) );
     */
    mlfAssign(
      &x,
      mlfFftshift(
        mlfIfft2(mlfFftshift(mclVa(f, "f"), NULL), NULL, NULL), NULL));
    mclValidateOutput(x, 1, nargout_, "x", "shiftifft2");
    mxDestroyArray(f);
    mclSetCurrentLocalFunctionTable(save_local_function_table_);
    return x;
}
