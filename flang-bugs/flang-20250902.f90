!! https://github.com/llvm/llvm-project/issues/156536
!!
!! RUNTIME SEGFAULT WITH VALID CODE
!!
!! In this example, a call-back subroutine is passed to subroutine which
!! invokes the call-back. The salient feature which results in the segfault
!! is that the call-back is an internal procedure that accesses a variable
!! from its parent by host association.
!!
!! $ flang --version
!! flang version 22.0.0git (git@github.com:llvm/llvm-project 51163c5dbdea72139ee4b93f5de7e652d30dea9f)
!! Target: x86_64-unknown-linux-gnu
!! Thread model: posix
!! InstalledDir: /opt/llvm/22.0.0-51163c5/bin
!! $ flang -g flang-20250902.f90 
!! $ ./a.out
!! Segmentation fault (core dumped)
!!

module factory

  abstract interface
    subroutine callback
    end subroutine
  end interface

contains

  subroutine alloc_flux_bc
    integer :: n
    n = 42
    call iterate_list(my_cb)
  contains
    subroutine my_cb
      print *, n ! N ACCESSED FROM PARENT BY HOST ASSOCIATION
    end subroutine
  end subroutine
  
  subroutine iterate_list(cb)
    procedure(callback) :: cb
    call cb ! SEGFAULTS HERE
  end subroutine

end module

program main
use factory
call alloc_flux_bc
end program
