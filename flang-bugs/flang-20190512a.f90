!! https://github.com/flang-compiler/flang/issues/713
!!
!! LENGTH PARAMETER NOT DEFINED IN CHARACTER-TYPE ALLOCATION OF CLASS(*)
!!
!! The March 2019 binary release does not correctly allocate a class(*)
!! array to character type -- the length parameter is not being defined.
!! The example exits early at the STOP 2 statement.
!!

class(*), allocatable :: x(:)
character(:), allocatable :: y(:)

y = ['biz','bat']
if (len(y) /= 3) stop 1

!allocate(x(lbound(y,1):ubound(y,1)), source=y) ! SHOULD WORK BUT DOES NOT

! ATTEMPT TO WORK AROUND THE ERROR ...
allocate(character(len(y)) :: x(lbound(y,1):ubound(y,1)))
select type (x)
type is (character(*))
  if (len(x) /= len(y)) stop 2  ! <== EXITS HERE -- WRONG LENGTH
class default
  stop 3
end select

end
