!! fixed in 5.3.1 (917)
!!
!! BAD INTERMEDIATE C CODE WITH -C=ALL OPTION
!!
!! The 5.3.1 edit 913 compiler generates bad intermediate C code
!! for the following example when compiled with -C=all.
!!
!! % nagfor -C=all -c nag-bug-20121111.f90 
!! NAG Fortran Compiler Release 5.3.1(913)
!! [NAG Fortran Compiler normal termination]
!! nag-bug-20121111.f90: In function 'sub_':
!! nag-bug-20121111.f90:32:10: error: request for member 'compa_' in something not a structure or union
!! nag-bug-20121111.f90:32:194: error: request for member 'compa_' in something not a structure or union
!!

module mod
  type :: typeA
    integer, pointer :: array(:)
  end type
  type :: typeB
    type(typeA) :: compA
  end type
end module

subroutine sub (varB, vector)
  use mod
  type(typeB) :: varB
  integer :: vector(:)
  print *, count(vector(varB%compA%array) /= varB%compA%array)
end subroutine
