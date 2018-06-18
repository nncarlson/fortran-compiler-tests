## Fortran Compiler Tests

This repository starts as a collection of reproducers from many of the Fortran
compiler bug reports I have made over the years. It comprises the more recent
bug reproducers for contemporary compilers. My initial goal was simply to
gather them to a central canonical location, and make them accessible to a few
interested people. I also wanted to be able to easily run the tests and clearly
see which tests are passing and failing.

Note that the number of tests for a given compiler is a reflection of my level
of engagement with the compiler, and should not be construed as an indication
of its quality. Quality, from the perspective of my usage, is measured more by
the number of failing tests.

The development of comprehensive test suites for specific Fortran 2003 and
later features, such as deferred-length allocatable character variables or
parametrized derived data types, is a possible future goal. I'm fed up with
Fortran compilers that claim support for a feature, but have a half-assed
implementation that only works for simple usage and fails badly for more
complex usage. A test suite that could thoroughly probe an implementation
would help shed the light of reality on the claims.

Contributions of tests or suggestions for improving the usefulness of this
project are most welcome -- make a pull request.

### Running the tests

I am attempting to use cmake/ctest as the framework for running the tests.
It is unclear how well this will work out in the end.  What I have now is
half-baked and needs further refinement. Running the tests for a particular
compiler goes something like this
```
cd gfortran-bugs
mkdir build
cd build
cmake ..
make
ctest
```
This assumes that `gfortran` is in your path, or that your `FC` environment
variable is set to the path to gfortran, so that the `cmake` configuration
step finds and uses it.

Some current cmake issues:
* The tests really want to be compiled without any compiler flags. Not
  specifying a value for `CMAKE_BUILD_TYPE` seems to have that effect.
  Some tests require specific compiler flags, but these are added on a
  file-by-file basis by the CMake files.
* Many tests are compile tests (does the code compile without an error or
  not). Doing that compilation as part of the `make` step doesn't get
  get properly captured by ctest (that I know of).  To fix this I'm using
  an approach I found in the boost-cmake/bcm project, which has `ctest`
  invoke the compilation.
* Other tests are run tests (does the executable run without error or
  produce the correct result). These are compiled and linked by the `make`
  step. However in some cases that too may fail. When that happens the
  `make` step probably terminates prematurely and may leave other test
  executables unbuilt. Running `ctest` will report 'did not run' for tests
  whose executable is missing. This isn't a satisfactory state of affairs.

### License
Practically you may consider the test codes as "public domain". They have
no intrinsic value other than their sole purpose as bug reproducers for
specific compilers. However, I've gathered that "public domain" can actually
be a problem, so I've opted for the most liberal license I can find -- MIT.
