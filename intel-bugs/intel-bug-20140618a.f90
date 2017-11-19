!Issue number DPD200357693
!!
!! In the following example, an allocatable component of a variable is
!! allocated and then deallocated, but the ALLOCATED intrinsic reports
!! that the component is still allocated.  It seems significant that
!! the component is a derived type with a CLASS(*) allocatable component.
!!
!! % ifort --version
!! ifort (IFORT) 14.0.2 20140120
!! 
!! % ifort intel-bug-20140618a.f90 
!! % ./a.out
!!  T  (expect F)
!!

program main

  type :: T1
    class(*), allocatable :: bar
  end type

  type :: T2
    type(T1), allocatable :: foo
  end type
  
  type(T2) :: x

  allocate(x%foo)
  deallocate(x%foo)
  print *, allocated(x%foo), ' (expect F)'  ! GIVES THE WRONG RESULT
  
end program
