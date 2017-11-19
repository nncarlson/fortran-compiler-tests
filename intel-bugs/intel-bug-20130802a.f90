!!
!! The compiler is stumbling over the type-is statement in the example below.
!! For some reason it does not see int32 (an intrinsic module named constant)
!! as a compile time constant (it is).
!!
!! If the subroutine is made an external procedure rather than a module
!! procedure, there is no compilation error.
!!
!! If the intrinsic module is used by the module instead of the procedure,
!! the compilation error also goes away.
!!
!! % ifort --version
!! ifort (IFORT) 13.1.2 20130514
!! 
!! % ifort intel-bug-20130802a.f90 
!! intel-bug-20130802a.f90(34): error #6683: A kind type parameter must be a compile-time constant.   [INT32]
!!     type is (integer(int32))
!! ---------------------^
!! compilation aborted for intel-bug-20130802a.f90 (code 1)
!!

module fubar_module

  ! put it here and everything is okay
  !use,intrinsic :: iso_fortran_env, only: int32

contains

  subroutine fubar (cs)
    ! put it here and the compiler stumbles
    use,intrinsic :: iso_fortran_env, only: int32
    class(*) :: cs
    select type (cs)
    type is (integer(int32))
    end select
  end subroutine

end module
