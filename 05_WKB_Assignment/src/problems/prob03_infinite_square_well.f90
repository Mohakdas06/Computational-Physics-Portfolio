!===========================================================
! File    : prob03_infinite_square_well.f90
! Author  : Mohak Das
! Course  : Computational Lab: Quantum Mechanics
! Topic   : WKB approximation for Infinite Square Well
! Units   : m = h_bar = 1
! Method  : WKB quantization + trapezoidal integration
!===========================================================


module prob03_physics
    use constants_mod
    implicit none
    real(dp), parameter :: width = 1.0_dp
    real(dp), parameter :: alpha = 0.0_dp

contains

    function potential(x) result(res)
        real(dp), intent(in) :: x
        real(dp) :: res
        res = 0.0_dp
    end function potential

    subroutine turning_points(E, x_L, x_R)
        real(dp), intent(in)  :: E
        real(dp), intent(out) :: x_L, x_R
        
        x_L = -width
        x_R = width
    end subroutine turning_points

end module prob03_physics


program prob03_driver
    use wkb_toolbox
    use prob03_physics
    implicit none

    integer :: n
    real(dp) :: energy

    write(*, '(A)') "----------------------------------------------------"
    write(*, '(A)') "Problem 3: Infinite Square Well"
    write(*, '(A)') "----------------------------------------------------"
    write(*, '(A, G0.2, A, G0.2)') "Unit used: m = ", mass, ",  h_bar = ", h_bar
    write(*, '(A)') "Method: WKB + Trapezoidal rule"
    write(*, '(A)') "----------------------------------------------------"
    write(*, '(A)') "The five lowest eigen energies: "; write(*, '(A)') " "
    
    do n = 1, 5
        energy = find_eigenenergy(n, potential, alpha, turning_points)
        write(*, '(A, I2, A, G0.10)') "n = ", n, "    E = ", energy
    end do

end program prob03_driver