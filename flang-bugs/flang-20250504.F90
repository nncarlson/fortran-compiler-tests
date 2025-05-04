!!
!! INCORRECT RESULTS
!!
!! When passing a non-contiguous array to an MPI procedure, a contiguous
!! temporary copy of the array should be passed instead (copy-in/copy-out).
!! This appears to not happening with flang 20.1.0. This example mimics the
!! interface provided by MPICH for MPI_Bcast, but doesn't require MPI at all.
!!
!! $ clang -c mpi_bcast.c
!! $ flang flang-20240504.F90 mpi_bcast.o
!! $ ./a.out
!!  x= 1. 2. 3. 4. 5.
!!    in bcast: buffer= 1. 3. 5.
!!      in mpi_bcast: buffer= 1.000000 2.000000 3.000000
!!
!! The expected results are
!!
!!  x= 1. 2. 3. 4. 5.
!!    in bcast: buffer= 1. 3. 5.
!!      in mpi_bcast: buffer= 1.000000 3.000000 5.000000
!!

module mpi_dummy

  !! Actual form of the interface from the MPICH 4.3.0 mpi module
  interface MPI_Bcast
    subroutine MPI_Bcast(buffer, count)!, datatype, root, comm, ierror)
      implicit none
#ifdef __flang__
      !DIR$ IGNORE_TKR buffer
#endif
#ifdef __INTEL_COMPILER
      !DEC$ ATTRIBUTES NO_ARG_CHECK :: buffer
#endif
#ifdef __GFORTRAN__
      !GCC$ ATTRIBUTES NO_ARG_CHECK :: buffer
#endif
      real :: buffer
      integer :: count
      !integer :: datatype
      !integer :: root
      !integer :: comm
      !integer :: ierror
    end subroutine
  end interface

end module

program main

  use mpi_dummy

  real :: x(5)
  x = [1,2,3,4,5]
  print *, 'x=', x
  call bcast(x(1::2))

contains

  subroutine bcast(buffer)
    real, intent(inout) :: buffer(:)
    print *, '  in bcast: buffer=', buffer
    ! A CONTIGUOUS COPY OF BUFFER MUST BE PASSED HERE
    call MPI_Bcast(buffer, size(buffer))
  end subroutine

end program
