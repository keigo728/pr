/*
 * MATLAB Compiler: 3.0
 * Date: Mon May 28 10:15:52 2007
 * Arguments: "-B" "macro_default" "-O" "all" "-O" "fold_scalar_mxarrays:on"
 * "-O" "fold_non_scalar_mxarrays:on" "-O" "optimize_integer_for_loops:on" "-O"
 * "array_indexing:on" "-O" "optimize_conditionals:on" "-x" "-W" "mex" "-L" "C"
 * "-t" "-T" "link:mexlibrary" "libmatlbmx.mlib" "shiftifft2" 
 */

#ifndef MLF_V2
#define MLF_V2 1
#endif

#include "libmatlb.h"
#include "shiftifft2.h"
#include "fftshift.h"
#include "ifft2.h"

extern _mex_information _mex_info;

static mexFunctionTableEntry function_table[1]
  = { { "shiftifft2", mlxShiftifft2, 1, 1,
        &_local_function_table_shiftifft2 } };

static _mexInitTermTableEntry init_term_table[1]
  = { { InitializeModule_shiftifft2, TerminateModule_shiftifft2 } };

/*
 * The function "Mifft2" is the MATLAB callback version of the "ifft2" function
 * from file "c:\matlab6p5p1\toolbox\matlab\datafun\ifft2.m". It performs a
 * callback to MATLAB to run the "ifft2" function, and passes any resulting
 * output arguments back to its calling function.
 */
static mxArray * Mifft2(int nargout_,
                        mxArray * f,
                        mxArray * mrows,
                        mxArray * ncols) {
    mxArray * x = NULL;
    mclFevalCallMATLAB(
      mclNVarargout(nargout_, 0, &x, NULL), "ifft2", f, mrows, ncols, NULL);
    return x;
}

/*
 * The function "Mfftshift" is the MATLAB callback version of the "fftshift"
 * function from file "c:\matlab6p5p1\toolbox\matlab\datafun\fftshift.m". It
 * performs a callback to MATLAB to run the "fftshift" function, and passes any
 * resulting output arguments back to its calling function.
 */
static mxArray * Mfftshift(int nargout_, mxArray * x, mxArray * dim) {
    mxArray * y = NULL;
    mclFevalCallMATLAB(
      mclNVarargout(nargout_, 0, &y, NULL), "fftshift", x, dim, NULL);
    return y;
}

/*
 * The function "mexLibrary" is a Compiler-generated mex wrapper, suitable for
 * building a MEX-function. It initializes any persistent variables as well as
 * a function table for use by the feval function. It then calls the function
 * "mlxShiftifft2". Finally, it clears the feval table and exits.
 */
mex_information mexLibrary(void) {
    mclMexLibraryInit();
    return &_mex_info;
}

_mex_information _mex_info
  = { 1, 1, function_table, 0, NULL, 0, NULL, 1, init_term_table };

/*
 * The function "mlfIfft2" contains the normal interface for the "ifft2"
 * M-function from file "c:\matlab6p5p1\toolbox\matlab\datafun\ifft2.m" (lines
 * 0-0). This function processes any input arguments and passes them to the
 * implementation version of the function, appearing above.
 */
mxArray * mlfIfft2(mxArray * f, mxArray * mrows, mxArray * ncols) {
    int nargout = 1;
    mxArray * x = NULL;
    mlfEnterNewContext(0, 3, f, mrows, ncols);
    x = Mifft2(nargout, f, mrows, ncols);
    mlfRestorePreviousContext(0, 3, f, mrows, ncols);
    return mlfReturnValue(x);
}

/*
 * The function "mlxIfft2" contains the feval interface for the "ifft2"
 * M-function from file "c:\matlab6p5p1\toolbox\matlab\datafun\ifft2.m" (lines
 * 0-0). The feval function calls the implementation version of ifft2 through
 * this function. This function processes any input arguments and passes them
 * to the implementation version of the function, appearing above.
 */
void mlxIfft2(int nlhs, mxArray * plhs[], int nrhs, mxArray * prhs[]) {
    mxArray * mprhs[3];
    mxArray * mplhs[1];
    int i;
    if (nlhs > 1) {
        mlfError(
          mxCreateString(
            "Run-time Error: File: ifft2 Line: 1 Column: 1 The function \"ifft2"
            "\" was called with more than the declared number of outputs (1)."),
          NULL);
    }
    if (nrhs > 3) {
        mlfError(
          mxCreateString(
            "Run-time Error: File: ifft2 Line: 1 Column: 1 The function \"ifft2"
            "\" was called with more than the declared number of inputs (3)."),
          NULL);
    }
    for (i = 0; i < 1; ++i) {
        mplhs[i] = NULL;
    }
    for (i = 0; i < 3 && i < nrhs; ++i) {
        mprhs[i] = prhs[i];
    }
    for (; i < 3; ++i) {
        mprhs[i] = NULL;
    }
    mlfEnterNewContext(0, 3, mprhs[0], mprhs[1], mprhs[2]);
    mplhs[0] = Mifft2(nlhs, mprhs[0], mprhs[1], mprhs[2]);
    mlfRestorePreviousContext(0, 3, mprhs[0], mprhs[1], mprhs[2]);
    plhs[0] = mplhs[0];
}

/*
 * The function "mlfFftshift" contains the normal interface for the "fftshift"
 * M-function from file "c:\matlab6p5p1\toolbox\matlab\datafun\fftshift.m"
 * (lines 0-0). This function processes any input arguments and passes them to
 * the implementation version of the function, appearing above.
 */
mxArray * mlfFftshift(mxArray * x, mxArray * dim) {
    int nargout = 1;
    mxArray * y = NULL;
    mlfEnterNewContext(0, 2, x, dim);
    y = Mfftshift(nargout, x, dim);
    mlfRestorePreviousContext(0, 2, x, dim);
    return mlfReturnValue(y);
}

/*
 * The function "mlxFftshift" contains the feval interface for the "fftshift"
 * M-function from file "c:\matlab6p5p1\toolbox\matlab\datafun\fftshift.m"
 * (lines 0-0). The feval function calls the implementation version of fftshift
 * through this function. This function processes any input arguments and
 * passes them to the implementation version of the function, appearing above.
 */
void mlxFftshift(int nlhs, mxArray * plhs[], int nrhs, mxArray * prhs[]) {
    mxArray * mprhs[2];
    mxArray * mplhs[1];
    int i;
    if (nlhs > 1) {
        mlfError(
          mxCreateString(
            "Run-time Error: File: fftshift Line: 1 Column:"
            " 1 The function \"fftshift\" was called with m"
            "ore than the declared number of outputs (1)."),
          NULL);
    }
    if (nrhs > 2) {
        mlfError(
          mxCreateString(
            "Run-time Error: File: fftshift Line: 1 Column:"
            " 1 The function \"fftshift\" was called with m"
            "ore than the declared number of inputs (2)."),
          NULL);
    }
    for (i = 0; i < 1; ++i) {
        mplhs[i] = NULL;
    }
    for (i = 0; i < 2 && i < nrhs; ++i) {
        mprhs[i] = prhs[i];
    }
    for (; i < 2; ++i) {
        mprhs[i] = NULL;
    }
    mlfEnterNewContext(0, 2, mprhs[0], mprhs[1]);
    mplhs[0] = Mfftshift(nlhs, mprhs[0], mprhs[1]);
    mlfRestorePreviousContext(0, 2, mprhs[0], mprhs[1]);
    plhs[0] = mplhs[0];
}
