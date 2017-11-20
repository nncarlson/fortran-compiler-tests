!! fixed in 5.3.2 (975)
!!
!! The NAG 5.3 compiler (edit 973) is generating invalid intermediate C
!! code for the following example when compiled with the -C=all option.
!! It compiles without error without that option.  It appears that the
!! abstract interface is improperly leaking outside of the module.
!!
!! $ nagfor -c -C=all nag-bug-20131204.f90 
!! NAG Fortran Compiler Release 5.3.2(973)
!! [NAG Fortran Compiler normal termination]
!! nag-bug-20131204.f90: In function 'example_':
!! nag-bug-20131204.f90:2:13: error: 'strain_rate_' redeclared as different kind of symbol
!! nag-bug-20131204.f90:31:28: note: previous definition of 'strain_rate_' was here
!! nag-bug-20131204.f90:35:33: error: invalid operands to binary + (have 'Real (*)()' and 'Real')
!!

module vp_model_class
  private
  type, abstract, public :: vp_model
  contains
    procedure(strain_rate), deferred :: strain_rate
  end type
  abstract interface
    function strain_rate (this)
      import :: vp_model
      class(vp_model), intent(in) :: this
    end function
  end interface
end module VP_model_class


subroutine example (model, strain_rate)
  use vp_model_class
  class(vp_model) :: model
  real :: strain_rate
  strain_rate = strain_rate + model%strain_rate()
end subroutine
