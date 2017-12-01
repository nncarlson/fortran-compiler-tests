!!
!! Unlimited polymorphic function result is wrong with the 18.0.0
!! compiler when its dynamic type is character -- its length is 0.
!!
!! $ ifort --version
!! ifort (IFORT) 18.0.0 20170811
!! 
!! $ ifort intel-bug-20171019a.f90 
!! $ ./a.out
!! "" (expect "fubar")  <== WRONG
!!
!! This is a regression; versions 17 and earlier return the correct result

program main
  character(5), target :: string = 'fubar'
  class(*), pointer :: p
  p => func()
  select type (p)
  type is (character(*))
    write(*,'(3a)') '"', p, '" (expect "fubar")'
  end select
contains
  function func()
    class(*), pointer :: func
    func => string
  end
end
