!! fixed in 5.3.2 (978)
!!
!! INVALID INTERMEDIATE C CODE
!!
!! The NAG 5.3 compiler (edit 975) is generating invalid intermediate C
!! code for the following example when compiled with the -nan option.
!! It compiles without error without that option.
!!
!! $ nagfor -nan -c nag-bug-20140108.f90 
!! NAG Fortran Compiler Release 5.3.2(975)
!! [NAG Fortran Compiler normal termination]
!! nag-bug-20140108.f90:18:45: error: "mod_EQ" undeclared here (not in a function)
!!  module mod
!!                                              ^
!! nag-bug-20140108.f90:18:52: error: invalid suffix "mod_MP_x" on floating constant
!!  module mod
!!

module mod
  real :: x
contains
  subroutine sub
    namelist /nml/ x
  end subroutine
end module
