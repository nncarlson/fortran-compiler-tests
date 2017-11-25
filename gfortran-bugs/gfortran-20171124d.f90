!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=79929
!!
!! According to the comments on the PR, these are bogus warning messages.
!! They occur with 8.0 (20171123) at -O1 and higher optimization levels,
!! and with 7.2.1 at -O2 and higher.  They do not occur with 6.4.1.
!!
!! $ gfortran -O1 -c bug.f90 
!! bug.f90:3:0:
!! 
!!      errmsg = 'unable to initialize region: ' // trim(errmsg)
!!  
!! Warning: '__builtin_memset' specified size 18446744073709551587 exceeds maximum object size 9223372036854775807 [-Wstringop-overflow=]

subroutine sub2(errmsg)
  character(*) :: errmsg
  errmsg = 'foo: ' // trim(errmsg)
end subroutine
