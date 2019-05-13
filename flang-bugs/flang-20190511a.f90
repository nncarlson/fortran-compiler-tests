!! https://github.com/flang-compiler/flang/issues/720
!!
!! SEGFAULT ON SOURCED ALLOCATION OF POLYMORPHIC VARIABLE
!!
!! This example seg faults on the sourced allocation statement using
!! the March 2019 binary distribution of flang.
!!
!! The allocation is executed correctly if A is of type JSON_VALUE and not
!! polymorphic. It is also executed correctly if the source is a variable
!! and not an expression.
!!

type, abstract :: json_value
end type

type, extends(json_value) :: json_string
  character(:), allocatable :: value
end type

class(json_value), allocatable :: a

!type(json_string) :: tmp
!tmp%value = 'foo'
!allocate(a, source=tmp)
allocate(a, source=json_string('foo'))  ! <== SEG FAULT HERE

select type(a)
type is (json_string)
  if (len(a%value) /= 3) stop 1
  if (a%value /= 'foo') stop 2
class default
  stop 3
end select

end
