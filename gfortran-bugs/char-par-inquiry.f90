!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=40196
!!
!! GFortran 8.0.0 and earlier don't recognize type parameter inquiry for
!! the intrinsic character type.  See 6.4.5 (F08)
!!
!! $ gfortran char_par_inquiry.f90
!! char_par_inquiry.f90:6:21:
!! 
!!  if (size(shape(array%len))  /= 0) stop 1
!!                      1
!! Error: Unexpected ‘%’ for nonderived-type variable ‘array’ at (1)
!! char_par_inquiry.f90:7:21:
!! 
!!  if (size(shape(array%kind)) /= 0) stop 2
!!                      1
!! Error: Unexpected ‘%’ for nonderived-type variable ‘array’ at (1)
!! char_par_inquiry.f90:8:10:
!! 
!!  if (array%kind /= kind(array)) stop 3
!!           1
!! Error: Unexpected ‘%’ for nonderived-type variable ‘array’ at (1)
!! char_par_inquiry.f90:9:10:
!! 
!!  if (array%len  /= len(array))  stop 4
!!           1
!! Error: Unexpected ‘%’ for nonderived-type variable ‘array’ at (1)

character(5) :: array(10)
if (size(shape(array%len))  /= 0) stop 1
if (size(shape(array%kind)) /= 0) stop 2
if (array%kind /= kind(array)) stop 3
if (array%len  /= len(array))  stop 4
end
