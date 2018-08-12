!! https://github.com/flang-compiler/flang/issues/308
!! Fixed as of 8/12/2018.
!!
!! This ICE is most likely due to the same problem in flang-20171122b.f90
!! Both ICE's occur at the SELECT TYPE statement where the selector is a
!! CLASS(*) pointer whose dynamic type is CHARACTER.
!!
!! $ flang -c flang-20171122d.f90 
!! F90-F-0000-Internal compiler error. insert_sym: bad hash     625  (flang-20171122d.f90: 5)
!! F90/x86-64 Linux Flang - 1.5 2017-05-01: compilation aborted

function foo()
  class(*), pointer :: foo
  character(3), target :: string = 'foo'
  foo => string
  select type (foo)
  type is (character(*))
    !print *, foo
  end select
end function
