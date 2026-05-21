!! INTERNAL COMPILER ERROR
!!
!! Triggered by a WHERE assignment whose array object uses an associate
!! name as a vector subscript. If the ASSOCIATE construct is replaced
!! by the WHERE statement using the selector directly, the code compiles.
!!
!! This is a regression from earlier 7.2 builds (I think 7225 is good.)
!!
!! $ nagfor -c nag-20260521.f90 
!! NAG Fortran Compiler Release 7.2(Shin-Urayasu) Build 7245
!! Panic: nag-20260521.f90: partial_process_array_object: unrecognised array object
!! Internal Error -- please report this bug
!! Abort

integer :: cface(2) = [1, 2], fsize(2) = 0
associate (cell_faces => cface)
  where (fsize(cell_faces) == 0) fsize(cell_faces) = 1
end associate
end

