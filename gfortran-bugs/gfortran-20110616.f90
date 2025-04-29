!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=49213
!! Finally fixed in gfortran 14.1.0
!!
!! This reworking of gfortran-bug-20110528.f90 is standard F2003.
!!
!! GFortran (version ?) rejects this example with this error:
!!                   1
!!   call pass_it (T(Sobj))
!!                   1
!! Error: Can't convert TYPE(s) to CLASS(s) at (1)
!! 
!!   call pass_it (T(S2obj))
!!                   1
!! Error: Can't convert TYPE(s2) to CLASS(s) at (1)!! Internal Compiler Error
!!

program main

  type :: S
    integer :: n
  end type
  type(S) :: Sobj
  
  type, extends(S) :: S2
    integer :: m
  end type
  type(S2) :: S2obj
  
  type :: T
    class(S), allocatable :: x
  end type
  
  Sobj = S(1)
  call pass_it (T(Sobj))
  
  S2obj = S2(1,2)
  call pass_it (T(S2obj))
  
contains

  subroutine pass_it (foo)
    type(T), intent(in) :: foo
  end subroutine
  
end program
