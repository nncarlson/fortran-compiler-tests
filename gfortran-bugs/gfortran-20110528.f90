!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=49213
!! Finally fixed in gfortran 14.1.0
!!
!! Note that the intrinsic assignment to a polymorphic variable
!! is a F2008 feature (not what this problem report is about).
!! See the F2003 compliant version gfortran-bug-20110528.f90
!!
!! GFortran (version ?) rejects this example with this error:
!!
!!   Tobj = T(Sobj)
!!            1
!! Error: Can't convert TYPE(s) to CLASS(s) at (1)
!! 
!!   Tobj = T(S2obj)
!!            1
!! Error: Can't convert TYPE(s2) to CLASS(s) at (1)

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
  type(T) :: Tobj
  
  Sobj = S(1)
  Tobj = T(Sobj)
  
  S2obj = S2(1,2)
  Tobj = T(S2obj)
  
end program
