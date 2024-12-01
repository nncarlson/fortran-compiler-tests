!! COMPILER HANGS
!!
!! nagfor 7.2.7220 hangs on the following code. If either of
!! the associations is removed the code compiles fine; only
!! when both are present does it hang.

subroutine hang(E, index)
  complex :: E(:)
  integer :: index(:)
  associate (E_re => E(index)%re, E_im => E(index)%im)
  end associate
end subroutine
