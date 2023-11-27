!! Will supposedly be fixed in 2024.1
!!
!! INTERNAL COMPILER ERROR
!!
!! No ICE if fptr is declared in subroutine bar, or if fptr is default
!! initialized to null(). This is with 2024.0
!!
!! $ ifx -c intel-20231122.f90 
!!           #0 0x000000000232d5da
!!           #1 0x0000000002394df7
!!           [...]
!!          #28 0x00007fbe0056a609 __libc_start_main + 137
!!          #29 0x00000000020ab129
!! 
!! intel-20231122.f90: error #5633: **Internal compiler error: segmentation violation signal raised**

subroutine foo

  use,intrinsic :: iso_c_binding, only: c_funptr, c_f_procpointer

  abstract interface
    real function f(x) bind(c)
      real, value :: x
    end function
  end interface
  procedure(f), pointer :: fptr

contains

  subroutine bar
    type(c_funptr)  :: funptr
    ! code to initialize funptr
    call c_f_procpointer(funptr, fptr)
  end subroutine

end subroutine
