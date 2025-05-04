!! https://github.com/flang-compiler/flang/issues/721
!!
!! WRONG RESULT FROM MOVE_ALLOC WITH CHARACTER VARIABLES
!!
!! The MOVE_ALLOC call in this example does not define the value of the result
!! variable B correctly. The example exits on the STOP 2 statement. If you
!! print out LEN(B), it is some random integer value that changes from one
!! execution to the next. This is with the March 2019 binary release.
!!

character(:), allocatable :: a, b
a = 'foo'
call move_alloc(a, b)
if (.not.allocated(b)) stop 1
if (len(b) /= 3) stop 2
if (b /= 'foo') stop 3
end
