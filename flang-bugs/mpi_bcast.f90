! Dummy version of MPI_Bcast to dump the received buffer
subroutine mpi_bcast(buffer, count)
  integer :: count
  real :: buffer(count)
  print *, "     in mpi_bcast: buffer=", buffer
end subroutine
