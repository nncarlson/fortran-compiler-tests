!! Will supposedly be fixed in 2024.1
!!
!! REJECTS VALID CODE
!!
!! $ ifx --version
!! ifx (IFX) 2024.0.0 20231017
!!
!! $ ifx intel-20231210.f90 
!! intel-20231210.f90(20): error #6512: A scalar-valued expression is required in this context.   [X]
!!         if (x) print *, 'pass'  ! X IS A SCALAR IN THIS RANK-CASE BLOCK
!! ------------^
!! compilation aborted for intel-20231210.f90 (code 1)

call foo(.true.)
contains
  subroutine foo(x)
    class(*), intent(in) :: x(..)
    select rank (x)
    rank (0)
      select type (x)
      type is (logical)
        if (x) print *, 'pass'  ! X IS A SCALAR IN THIS RANK-CASE BLOCK
      end select
    end select
  end subroutine
end
