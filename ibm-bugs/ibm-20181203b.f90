!!
!! REJECTS VALID CODE
!!
!! Update: Bug persists in 16.1.1.2
!!
!! The XL Fortran 16.1.1-rc3 compiler rejects the following code with the
!! error
!!
!! $ xlf2008 ibm-20181203b.f90 
!! "ibm-20181203b.f90", line 37.30: 1513-209 (S) The result of an elemental function must be a nonpointer, nonallocatable scalar, and its type parameters must be constant expressions.
!! ** foo   === End of Compilation 1 ===
!! 1501-511  Compilation failed for file ibm-20181203b.f90.
!!
!! The error message suggests the code is running afoul of C1290 (F2008).
!! That constraint was modified in Technical Corrigenda 1 to read
!!
!! C1290 The result of an elemental function shall be scalar, shall not have
!! the POINTER or ALLOCATABLE attribute.
!!
!! striking out the final clause, "..., and shall not have a type parameter
!! that is defined by an expression that is not a constant expression."
!!
!! And added:
!!
!! C1290b In the specification-expr that specifies a type parameter value of
!! the result of an elemental function, an object designator with a dummy
!! argument of the function as the base object shall appear only as the subject
!! of a specification inquiry, and that specification inquiry shall not depend
!! on a property that is deferred.
!!
!! Under the clarified standard, LEN(INPUT) is a valid specification expression
!! for an elemental function result type parameter.
!!

module foo
contains
  elemental function raise_case(input) result(output)
    character(*), intent(in) :: input
    character(len(input)) :: output
    output = input
  end function
end module
