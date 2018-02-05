!!
!! INVALID INTERMEDIATE C CODE
!!
!! The NAG 6.2 compiler generates invalid intermediate C code
!! for the following example.
!!
!! $ nagfor nag-20180203f.f90 
!! NAG Fortran Compiler Release 6.2(Chiyoda) Build 6205
!! [NAG Fortran Compiler normal termination]
!! nag-20180203f.f90: In function 'MAINIP_foo':
!! nag-20180203f.f90:20:1: error: 'locals' undeclared (first use in this function)
!!      foo = 42
!!  ^   ~~
!! nag-20180203f.f90:20:1: note: each undeclared identifier is reported only once for each function it appears in


call test
contains
  integer function foo()
    foo = 42
  end function
  subroutine test
    procedure(integer), pointer :: x => null()
    x => foo
    print *, x()
  end subroutine
end
