!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=93762
!!
!! INVALID CODE FROM OPTIONAL DEFERRED-LENGTH ALLOCATABLE CHARACTER DUMMY ARG
!!
!! All versions of gfortran through 10.2 yield invalid code when the actual
!! argument for an optional deferred-length character dummy argument is itself
!! an optional dummy argument in the calling procedure. This situation is
!! captured in the call to SUB2 from SUB1 in the following example. MSG is
!! returned from SUB2 having an undefined or wrong length.
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 10.2.0
!! $ gfortran gfortran-20201204.f90 
!! $ ./a.out
!! STOP 1
!!
!! SUB1_WORKAROUND illustrates how to work around the bug. In a hierarchy
!! of calls where MSG is passed down, this workaround has to be applied
!! at each level, ugh!

program main

  character(:), allocatable :: msg

  msg = 'XYZ'
  call sub1(msg)  ! this works: call sub1_workaround(msg)
  if (len(msg) /= 5) stop 3
  if (msg /= 'fubar') stop 4

contains

  subroutine sub1(msg)
    character(:), allocatable, intent(out), optional :: msg
    call sub2(msg)
    if (len(msg) /= 5) stop 1
    if (msg /= 'fubar') stop 2
  end subroutine

  subroutine sub2(msg)
    character(:), allocatable, intent(out), optional :: msg
    if (present(msg)) msg = 'fubar'
  end subroutine

  subroutine sub1_workaround(msg)
    character(:), allocatable, intent(out), optional :: msg
    if (present(msg)) then
      block
        character(:), allocatable :: tmp
        call sub2(tmp)
        msg = tmp
      end block
    else
      call sub2()
    end if
  end subroutine

end
