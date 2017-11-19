!!
!! INCORRECT ANALYSIS OF OPEN STATEMENT
!!
!! The Intel 13.0.0 compiler is a little too eager to decide that
!! the OPEN statement in the following program is not conforming.
!! The FILE= specifier is indeed there.
!!
!! % ifort --version
!! ifort (IFORT) 13.0.0 20120731
!! 
!! % ifort intel-bug-20121024.f90 
!! intel-bug-20121024.f90(19): error #8414: If NEWUNIT appears in OPEN statement either FILE or STATUS (with value SCRATCH) specifiers must appear.   [STATUS]
!! open(newunit=n,status='replace',file='foo')
!! ---------------!! 
!! compilation aborted for intel-bug-20121024.f90 (code 1)
!!

program main
open(newunit=n,status='replace',file='foo')
end program
