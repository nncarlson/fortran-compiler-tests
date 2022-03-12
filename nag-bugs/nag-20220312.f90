!!
!! INTERNAL COMPILER ERROR
!!
!! $ nagfor -c -f2018 nag-20220312.f90 
!! NAG Fortran Compiler Release 7.1(Hanzomon) Build 7105
!! Panic: nag-20220312.f90: Not a Uindex
!! Internal Error -- please report this bug
!! Abort

module mpi_f08 ! Essential bit copied from MPICH 4.0 and stripped down
  interface MPI_Bcast
    subroutine mpi_bcast_f08ts(buffer)
      type(*), dimension(..), intent(inout) :: buffer
    end subroutine
  end interface
end module

use mpi_f08
contains
  subroutine bcast_char_0(scalar)
    character(*), intent(inout) :: scalar
    call MPI_Bcast(scalar)
  end subroutine
end
