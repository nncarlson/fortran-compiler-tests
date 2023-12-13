!! BAD CODE WITH ASSUMED RANK, CLASS(*) ARGUMENT
!!
!! The following example variously produces a runtime buffer overflow error,
!! segmentation error, or incorrect empty string "" from the write statement
!! in the WRITE_CSTAR procedure. Essential characteristics seem to be that
!! the argument is unlimited polymorphic, assumed rank, with character
!! dynamic type. Note that problem is not specific to the scalar (rank 0)
!! case -- the same thing happens with an array argument.
!!
!! $ nagfor -f2018 nag-20231213.f90 
!! NAG Fortran Compiler Release 7.1(Hanzomon) Build 7141
!!
!! $ ./a.out
!! expected:fubar
!! Runtime Error: nag-20231213.f90, line 37: Buffer overflow on output
!! Program terminated by I/O error on unit 6 (Output_Unit,Formatted,Sequential)
!! Aborted (core dumped)

program main

  class(*), allocatable :: a
  allocate(a, source='fubar')
  select type (a)
  type is (character(*))
    write(*,'(*(a))') 'expected:', a
  end select
  call write_cstar(a)

contains

  subroutine write_cstar(x)
    class(*), intent(in) :: x(..)
    select rank (x)
    rank (0)
      select type (x)
      type is (character(*))
        write(*,'(*(a))') 'write_cstar:', x ! ERROR HERE
      end select
    end select
  end subroutine

end program
