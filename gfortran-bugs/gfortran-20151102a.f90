!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=54070
!! marked a duplicate of 
!! Fixed in 12.2.0 and probably much earlier.
!!
!! Compiled with 6.0 (20151025 snapshot).
!!
!! $ ./a.out
!!  len(string)=           5 , size(string)=           2
!! 
!! Program received signal SIGSEGV: Segmentation fault - invalid memory reference.
!! 
!! Backtrace for this error:
!! #0  0x7FFB05C4E517
!! #1  0x7FFB05C4EB5E
!! #2  0x7FFB0514F95F
!! #3  0x7FFB051B6EC8
!! #4  0x400D23 in fubar.3417 at fubar.f90:?
!! #5  0x400DC9 in MAIN__ at fubar.f90:?
!! Segmentation fault (core dumped)

program main
  character(:), allocatable :: string(:)
  call fubar (string)
contains
  subroutine fubar (string)
    character(:), allocatable, intent(out) :: string(:)
    allocate(character(5) :: string(2))
    print *, 'len(string)=', len(string), ', size(string)=', size(string)
    string = 'fubar' ! <== SEGMENTATION FAULT HERE
  end subroutine
end program
