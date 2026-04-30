!===========================================================
! File    : prob09_quadratic_quartic.f90
! Author  : Mohak Das
! Course  : Computational Lab: Quantum Mechanics
! Topic   : WKB approximation for Quadratic-quartic potential
! Units   : m = h_bar = 1
! Method  : WKB quantization + trapezoidal integration
!===========================================================


module prob09_physics
    use constants_mod
    implicit none
    real(dp), parameter :: alpha = 0.5_dp

contains

    function potential(x) result(res)
        real(dp), intent(in) :: x
        real(dp) :: res
        res = x**2 + x**4
    end function potential

    subroutine turning_points(E, x_L, x_R)
        real(dp), intent(in)  :: E
        real(dp), intent(out) :: x_L, x_R
        
        x_L = -sqrt((-0.5_dp + 0.5_dp * sqrt(1.0_dp + 4*E)))
        x_R = sqrt((-0.5_dp + 0.5_dp * sqrt(1.0_dp + 4*E)))
    end subroutine turning_points
    
end module prob09_physics


program prob09_driver
    use wkb_toolbox
    use prob09_physics
    implicit none

    integer :: n
    real(dp) :: energy

    write(*, '(A)') "------------------------------------------------"
    write(*, '(A)') "Problem 9: Quadratic-quartic potential"
    write(*, '(A)') "------------------------------------------------"
    write(*, '(A, G0.2, A, G0.2)') "Unit used: m = ", mass, ",  h_bar = ", h_bar
    write(*, '(A)') "Method: WKB + Trapezoidal rule"
    write(*, '(A)') "------------------------------------------------"
    write(*, '(A)') "The five lowest eigen energies: "; write(*, '(A)') " "
    
    do n = 0, 4
        energy = find_eigenenergy(n, potential, alpha, turning_points)
        write(*, '(A, I2, A, G0.10)') "n = ", n, "    E = ", energy
    end do

end program prob09_driver