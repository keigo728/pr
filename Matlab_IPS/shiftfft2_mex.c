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

#include "libmatlb.h"
#include "shiftfft2.h"
#include "fft2.h"
#include "fftshift.h"

extern _mex_information _mex_info;

static mexFunctionTableEntry function_table[1]
  = { { "shiftfft2", mlxShiftfft2, 1, 1, &_local_function_table_shiftfft2 } };

static _mexInitTermTableEntry init_term_table[1]
  = { { InitializeModule_shiftfft2, TerminateModule_shiftfft2 } };

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
 * The function "Mfft2" is the MATLAB callback version of the "fft2" function
 * from file "c:\matlab6p5p1\toolbox\matlab\datafun\fft2.m". It performs a
 * callback to MATLAB to run the "fft2" function, and passes any resulting
 * output arguments back to its calling function.
 */
static mxArray * Mfft2(int nargout_,
                       mxArray * x,
                       mxArray * mrows,
                       mxArray * ncols) {
    mxArray * f = NULL;
    mclFevalCallMATLAB(
      mclNVarargout(nargout_, 0, &f, NULL), "fft2", x, mrows, ncols, NULL);
    return f;
}

/*
 * The function "mexLibrary" is a Compiler-generated mex wrapper, suitable for
 * building a MEX-function. It initializes any persistent variables as well as
 * a function table for use by the feval function. It then calls the function
 * "mlxShiftfft2". Finally, it clears the feval table and exits.
 */
mex_information mexLibrary(void) {
    mclMexLibraryInit();
    return &_mex_info;
}

_mex_information _mex_info
  = { 1, 1, function_table, 0, NULL, 0, NULL, 1, init_term_table };

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

/*
 * The function "mlfFft2" contains the normal interface for the "fft2"
 * M-function from file "c:\matlab6p5p1\toolbox\matlab\datafun\fft2.m" (lines
 * 0-0). This function processes any input arguments and passes them to the
 * implementation version of the function, appearing above.
 */
mxArray * mlfFft2(mxArray * x, mxArray * mrows, mxArray * ncols) {
    int nargout = 1;
    mxArray * f = NULL;
    mlfEnterNewContext(0, 3, x, mrows, ncols);
    f = Mfft2(nargout, x, mrows, ncols);
    mlfRestorePreviousContext(0, 3, x, mrows, ncols);
    return mlfReturnValue(f);
}

/*
 * The function "mlxFft2" contains the feval interface for the "fft2"
 * M-function from file "c:\matlab6p5p1\toolbox\matlab\datafun\fft2.m" (lines
 * 0-0). The feval function calls the implementation version of fft2 through
 * this function. This function processes any input arguments and passes them
 * to the implementation version of the function, appearing above.
 */
void mlxFft2(int nlhs, mxArray * plhs[], int nrhs, mxArray * prhs[]) {
    mxArray * mprhs[3];
    mxArray * mplhs[1];
    int i;
    if (nlhs > 1) {
        mlfError(
          mxCreateString(
            "Run-time Error: File: fft2 Line: 1 Column: 1 The function \"fft2\""
            " was called with more than the declared number of outputs (1)."),
          NULL);
    }
    if (nrhs > 3) {
        mlfError(
          mxCreateString(
            "Run-time Error: File: fft2 Line: 1 Column: 1 The function \"fft2"
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
    mplhs[0] = Mfft2(nlhs, mprhs[0], mprhs[1], mprhs[2]);
    mlfRestorePreviousContext(0, 3, mprhs[0], mprhs[1], mprhs[2]);
    plhs[0] = mplhs[0];
}
