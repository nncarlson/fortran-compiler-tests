!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84143
!!
!! INTRINSIC OUTPUT OF PDT INCORRECTLY INCLUDES TYPE PARAMETERS
!!
!! Type parameters are not components (see F08 1.3.33, R435, and cf R431)
!! and therefore should not be included in the intrinsic output of a PDT.
!! But gfortran 8.0 includes the type parameters and so exits on the STOP 1

type foo(k1,l1)
  integer,kind :: k1=1
  integer,len  :: l1=2
  integer :: n=3
end type

type(foo) :: x
character(8) :: string

write(string,'(*(i0))') x ! THIS SHOULD WRITE THE SINGLE DIGIT 3
if (len_trim(string) /= 1) stop 1
end
