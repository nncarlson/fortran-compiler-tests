!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=49213

program main

  type :: S
    integer :: n
  end type
  type(S) :: Sobj
  
  type, extends(S) :: S2
    integer :: m
  end type
  type(S2) :: S2obj
  
  type :: T
    class(S), allocatable :: x
  end type
  
  Sobj = S(1)
  call pass_it (T(Sobj))
  
  S2obj = S2(1,2)
  call pass_it (T(S2obj))
  
contains

  subroutine pass_it (foo)
    type(T), intent(in) :: foo
  end subroutine
  
end program
