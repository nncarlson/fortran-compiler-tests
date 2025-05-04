! https://github.com/flang-compiler/flang/issues/237
!
! This is an modified version of flang-20170923a.f90
!
! ICE on the 0-length binding name was fixed in 6d8ef8 but the fix
! resulted in using "foo" as the binding label (same as no NAME= specifier)
! when the 2008 standard says "no binding label". Other compilers create a
! greatly mangled name (as for module procedures) which is in keeping with the
! spirit of the standard (apparently it seems impossible not to create some
! object symbol for the procedure).  In response, I've added a main program
! that calls "foo".  This should fail to link if the compiler does the right
! thing.
!
! 1/26/2018: Fixed in a972bbd 

module example
contains
  integer function foo() bind(c,name='')
  end function
end module

call foo
end
