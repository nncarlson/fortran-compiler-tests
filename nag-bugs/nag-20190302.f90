!! SR103029: fixed in 6.2 build 6228
!!
!! TYPE BOUND CONTIGUOUS POINTER FUNCTION NOT RECOGNIZED AS CONTIGUOUS
!!
!! In this example the type bound function contig_res returns a simply
!! contiguous array pointer. However when the function result is an actual
!! argument for a contiguous dummy argument, the 6.2 compiler does not
!! recognize it as simply contiguous. The example compiles fine with 6.1.
!!
!! For the error to occur: 1) the function needs to be type bound. No error
!! if the function is not type bound; and 2) the dummy argument needs to be
!! a pointer. No error if the dummy is not a pointer. 
!!
!! $ nagfor -w nag-20190302.f90 
!! NAG Fortran Compiler Release 6.2(Chiyoda) Build 6227
!! Error: nag-20190302.f90, line 33: Argument B (no. 1) of CONTIG_ARG is a CONTIGUOUS pointer, but the actual argument BAR%CONTIG_RES() is not simply contiguous
!!

module mod
  type :: foo
  contains
    procedure :: contig_res
  end type
contains
  function contig_res(this) result(a)
    class(foo), intent(in) :: this
    real, pointer, contiguous :: a(:)
    allocate(a(10))
  end function
end module

program main
  use mod
  type(foo) :: bar
  call contig_arg(bar%contig_res())
contains
  subroutine contig_arg(b)
    real, pointer, contiguous, intent(in) :: b(:)
  end subroutine
end program
