!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110033
!!
!! REJECTS VALID CODE
!!
!! The following example has an ASSOCIATE construct with coarray selector.
!! According to 11.1.3.3 par 2 (f2018), the corresponding associate name Y
!! should be recognized as being a coarray, however gfortran 13.1 rejects
!! this valid code:
!!
!! $ gfortran -fcoarray=lib gfortran-20230529.f90 
!! gfortran-20230529.f90:18:4:
!!
!!    14 |   y[1] = 1.0
!!       |    1
!! Error: Coarray designator at (1) but 'y' is not a coarray
!!

real :: x[*]
associate (y => x)
  y[1] = 1.0
end associate
end
