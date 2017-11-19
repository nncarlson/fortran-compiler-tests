!!
!! Internal Compiler Error
!!
!! % ifort --version
!! ifort (IFORT) 12.0.3 20110309
!!
!! % ifort struct-construct-1.f90 
!! struct-construct-1.f90: catastrophic error: **Internal compiler error: segmentation violation signal raised** Please report this error along with the circumstances in which it occurred in a Software Problem Report.  Note: File and line given may not be explicit cause of this error.
!! compilation aborted for struct-construct-1.f90 (code 1)
!!

program main

  type :: S
    integer :: n
  end type
  type(S) :: Sobj
  
  type :: T
    class(S), allocatable :: x
  end type
  type(T) :: Tobj
  
  Sobj = S(1)
  Tobj = T(Sobj)
  
end program
