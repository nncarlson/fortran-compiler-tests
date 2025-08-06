!! Fixed in ifort 2021.11.0
!!
!! INTERNAL COMPILER ERROR
!!
!! $ ifort --version
!! ifort (IFORT) 2021.10.0 20230609
!! Copyright (C) 1985-2023 Intel Corporation.  All rights reserved.
!!
!! $ ifort test.F90
!! /tmp/ifortdFZvHy.i90: catastrophic error: **Internal compiler error: segmentation violation signal raised** Please report this error along with the circumstances in which it occurred in a Software Problem Report.  Note: File and line given may not be explicit cause of this error.
!! compilation aborted for intel-20250806.f90 (code 1)
!!

program test
  use, intrinsic :: iso_c_binding, only: c_ptr
  implicit none

  interface
    subroutine foo(args)
      import c_ptr
      type(c_ptr) :: args(:)
    end subroutine foo
  end interface

  call foo(args=[c_ptr::])
end program test
