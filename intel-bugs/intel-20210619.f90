!! Fixed in 2021.11.0
!!
!! VALID CODE REJECTED
!!
!! In the following example DUMMY%STATE%X and BUFFER are both valid arguments
!! to the STORAGE_SIZE intrinsic function. Neither the allocatable DUMMY
!! variable nor its allocatable component STATE need to be allocated;
!! the result depends only on the type of STATE%X which is known.
!! This slight alteration of intel-20200721.f90 adds some similar instances
!! of this usage.
!!
!! $ ifort --version
!! ifort (IFORT) 2021.2.0 20210228
!!
!! $ ifort -c intel-20210619.f90
!! intel-20210619.f90(30): error #8484: The argument to STORAGE_SIZE is invalid.   [X]
!!   integer, parameter :: n = storage_size(dummy%state%x)
!! -----------------------------------------------------^
!! intel-20210619.f90(34): error #8484: The argument to STORAGE_SIZE is invalid.   [BUFFER]
!!     integer, parameter :: n = storage_size(buffer)
!! -------------------------------------------^
!! compilation aborted for intel-20210619.f90 (code 1)
!!

module mod
  type :: bar
    integer :: x
  end type
  type :: foo
    type(bar), allocatable :: state(:)
  end type
  type(foo), allocatable :: dummy
  integer, parameter :: n = storage_size(dummy%state%x) ! VALID
contains
  subroutine sub(buffer)
    integer :: buffer(:)
    integer, parameter :: n = storage_size(buffer) ! VALID
  end subroutine
end module
