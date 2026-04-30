!===========================================================
! File    : prob08_quartic_potential.f90
! Author  : Mohak Das
! Course  : Computational Lab: Quantum Mechanics
! Topic   : WKB approximation for Quartic (x^4) potential
! Units   : m = h_bar = 1
! Method  : WKB quantization + trapezoidal integration
!===========================================================


module prob08_physics
    use constants_mod
    implicit none
    real(dp), parameter :: alpha = 0.5_dp
    
contains

    function potential(x) result(res)
        real(dp), intent(in) :: x
        real(dp) :: res
        res = x**4
    end function potential

    subroutine turning_points(E, x_L, x_R)
        real(dp), intent(in)  :: E
        real(dp), intent(out) :: x_L, x_R
        
        x_L = - sqrt(sqrt(E))
        x_R = sqrt(sqrt(E))
    end subroutine turning_points
    
end module prob08_physics


program prob08_driver
    use wkb_toolbox
    use prob08_physics
    implicit none

    integer :: n
    real(dp) :: energy

    write(*, '(A)') "------------------------------------------------"
    write(*, '(A)') "Problem 8: Quartic (x^4) Potential"
    write(*, '(A)') "------------------------------------------------"
    write(*, '(A, G0.2, A, G0.2)') "Unit used: m = ", mass, ",  h_bar = ", h_bar
    write(*, '(A)') "Method: WKB + Trapezoidal rule"
    write(*, '(A)') "------------------------------------------------"
    write(*, '(A)') "The five lowest eigen energies: "; write(*, '(A)') " "

    do n = 0, 4
        energy = find_eigenenergy(n, potential, alpha, turning_points)
        write(*, '(A, I2, A, G0.10)') "n = ", n, "    E = ", energy
    end do

end program prob08_driver