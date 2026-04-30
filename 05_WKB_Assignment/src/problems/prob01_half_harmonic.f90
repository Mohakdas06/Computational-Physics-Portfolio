!===========================================================
! File    : prob01_half_harmonic.f90
! Author  : Mohak Das
! Course  : Computational Lab: Quantum Mechanics
! Topic   : WKB approximation for Half Harmonic Oscillator
! Units   : m = h_bar = 1
! Method  : WKB quantization + trapezoidal integration
!===========================================================


module prob01_physics
    use constants_mod
    implicit none
    real(dp), parameter :: omega = 1.0_dp
    real(dp), parameter :: alpha = -0.25_dp
    
contains

    function potential(x) result(res)
        real(dp), intent(in) :: x
        real(dp) :: res
        res = 0.5_dp * mass * (omega**2) * x**2
    end function potential

    subroutine turning_points(E, x_L, x_R)
        real(dp), intent(in)  :: E
        real(dp), intent(out) :: x_L, x_R
    
        x_L = 0.0_dp
        x_R = sqrt(2.0_dp * E)
    end subroutine turning_points

end module prob01_physics


program prob01_driver
    use wkb_toolbox
    use prob01_physics
    implicit none

    integer :: n
    real(dp) :: energy

    write(*, '(A)') "------------------------------------------------"
    write(*, '(A)') "Problem 1: Half Harmonic Oscillator"
    write(*, '(A)') "------------------------------------------------"
    write(*, '(A, G0.2, A, G0.2)') "Unit used: m = ", mass, ",  h_bar = ", h_bar
    write(*, '(A)') "Method: WKB + Trapezoidal rule"
    write(*, '(A)') "------------------------------------------------"
    write(*, '(A)') "The five lowest eigen energies: "; write(*, '(A)') " "

    do n = 1, 5
        energy = find_eigenenergy(n, potential, alpha, turning_points)
        write(*, '(A, I2, A, G0.10)') "n = ", n, "    E = ", energy
    end do

end program prob01_driver