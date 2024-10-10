!! INTERNAL COMPILER ERROR
!!
!! ifx intel-20241010.f90
!! intel-20241010.f90(3): error #5623: **Internal compiler error: internal abort**
!!

complex :: x(5)
x = 1.0
x%im = -x%re
end
