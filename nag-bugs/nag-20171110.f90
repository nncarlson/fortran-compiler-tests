!! Fixed in 6.1 build 6144 (report 99312)
!!
!! Bad intermediate C code is being generated for this example
!! resulting in errors from the C compiler.
!! 
!! $ nagfor -c nag-bug-20171110.f90 
!! NAG Fortran Compiler Release 6.1(Tozai) Build 6143
!! Warning: nag-bug-20171110.f90, line 42: Unused dummy variable THIS
!! Warning: nag-bug-20171110.f90, line 46: Unused dummy variable THIS
!! Warning: nag-bug-20171110.f90, line 46: INTENT(OUT) dummy argument THIS never set
!! [NAG Fortran Compiler normal termination, 3 warnings]
!! nag-bug-20171110.f90: In function 'fubar_MP_init':
!! nag-bug-20171110.f90:44:14: error: 'this_' is a pointer; did you mean to use '->'?
!!    subroutine init(this)
!!               ^
!!               ->
!! nag-bug-20171110.f90: In function 'fubar_MP__zfinal0':
!! nag-bug-20171110.f90:21:11: error: 'v_' is a pointer; did you mean to use '->'?
!!  module fubar
!!            ^
!!            ->

module fubar

  type x
  contains
    final :: x_final
  end type

  type y
    type(x) :: xval
  end type

  type z
    type(y) :: yval(2)
  contains
    procedure :: init
  end type

contains

  elemental subroutine x_final(this)
    type(x), intent(inout) :: this
  end subroutine

  subroutine init(this)
    class(z), intent(out) :: this
  end subroutine

end module
