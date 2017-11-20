!!
!! In the following example SUB3 has an explicit interface but the 1070 edit
!! of the 6.0 compiler incorrectly reports an error, claiming it has been
!! implicitly typed in the call to SUB1 where it is passed as a procedure
!! argument.  The error goes away if SUB3 is moved before SUB2, or if the
!! call to SUB3 is moved before the call to SUB1.  This is a regresson from
!! the 1067 edit and earlier compiler versions (e.g. 5.3.2).
!!
!! % nagfor -c nag-bug-20160321.f90 
!! NAG Fortran Compiler Release 6.0(Hibiya) Build 1070
!! Warning: nag-bug-20160321.f90, line 8: Unused dummy procedure FOO
!! Error: nag-bug-20160321.f90, line 11: Symbol SUB3 has already been implicitly typed
!! 	  detected at SUB3@<end-of-statement>
!!

module mod
contains
  subroutine sub1 (foo)
    interface
      subroutine foo
      end
    end interface
  end
  subroutine sub2
    call sub1 (sub3)
    call sub3
  end
  subroutine sub3
  end
end
