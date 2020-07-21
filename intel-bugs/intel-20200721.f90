!! Support request 04744494
!!
!! VALID CODE REJECTED
!!
!! In the following example DUMMY%STATE is a valid argument to the
!! STORAGE_SIZE intrinsic function. Neither the allocatable DUMMY
!! variable nor its allocatable component STATE need to be allocated;
!! the result depends only on the type of STATE which is known.
!!
!! $ ifort --version
!! ifort (IFORT) 19.1.0.166 20191121
!!
!! $ ifort intel-20200721.f90 
!! intel-20200721.f90(16): error #8484: The argument to STORAGE_SIZE is invalid.   [STATE]
!!   integer, parameter :: n = storage_size(dummy%state)
!! -----------------------------------------------^
!! compilation aborted for intel-20200721.f90 (code 1)
!!

module mod
  type :: foo
    integer, allocatable :: state(:)
  end type
  type(foo), allocatable :: dummy
  integer, parameter :: n = storage_size(dummy%state)
end module
