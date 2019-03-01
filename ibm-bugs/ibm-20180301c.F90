!!
!! SOURCE CORRUPTED BY PREPROCESSOR
!!
!! For some reason the XLF preprocessor is corrupting the valid Fortran
!! string constant '???' in the following example, leading to a spurious
!! compiler error.  Note the source file has the suffix '.F90'.  The
!! preprocessor should not be modifying the source at all.
!!
!! Update: This is apparently by design as a C preprocessor: the ??' is
!! a trigraph that stands for ^. Solution is to use -WF,-qnotrigraph to
!! avoid expanding trigraphs. While I'll accept it makes sense as a C
!! preprocess behavior, I think it is bad form for it to be behaving
!! this way by default in the context of Fortran.
!!
!! This is from https://github.com/nncarlson/petaca/blob/master/src/parameter_entry_class.F90
!!
!! $ xlf ibm-20180301c.F90
!! "ibm-20180301c.F90", line 14.0: 1515-010 (S) String is missing a closing delimiter.  Closing delimiter assumed at end of line.
!! ** _main   === End of Compilation 1 ===
!! 1501-511  Compilation failed for file ibm-20180301c.F90.

print *, '???'
end
