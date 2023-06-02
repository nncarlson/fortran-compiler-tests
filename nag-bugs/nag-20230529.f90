!! SR109818: Fixed in 7129
!!
!! INTERNAL COMPILER ERROR
!!
!! The following example involving coarray derived type components as
!! selectors in an associate construct triggers an ICE with NAG 7.1.7127
!!
!! $ nagfor -c -coarray nag-20230529.f90 
!! NAG Fortran Compiler Release 7.1(Hanzomon) Build 7127
!! Panic: nag-20230529.f90: Uindex type 7 is not Symptr
!! Internal Error -- please report this bug
!! 

module example
  type :: foo
    real, allocatable :: co_tmp1[:], co_tmp2[:]
  end type
contains
  subroutine bar(this)
    type(foo) :: this
    real :: x
    associate (a => this%co_tmp1, b => this%co_tmp2)
      if (this_image() < num_images()) then
        x = a[this_image()+1]
        b = x
      end if
    end associate
  end subroutine
end module
