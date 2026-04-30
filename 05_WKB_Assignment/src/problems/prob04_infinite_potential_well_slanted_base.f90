!===========================================================
! File    : prob04_infinite_potential_well_slanted_base.f90
! Author  : Mohak Das
! Course  : Computational Lab: Quantum Mechanics
! Topic   : WKB approximation for Infinite Square Well With Slanted Base
! Units   : m = h_bar = 1
! Method  : WKB quantization + trapezoidal integration
!===========================================================



module prob04_physics
    use constants_mod
    implicit none
    real(dp), parameter :: width = 1.0_dp
    real(dp), parameter :: V0 = 20000_dp
    real(dp), parameter :: E_max = V0
    real(dp), parameter :: alpha = -0.25_dp
    
contains
    
    function potential(x) result(res)
        real(dp), intent(in) :: x
        real(dp) :: res
        res = (V0/width) * x
    end function potential
    
    subroutine turning_points(E, x_L, x_R)
        real(dp), intent(in)  :: E
        real(dp), intent(out) :: x_L, x_R
        
        x_L = 0.0_dp
        x_R = (width/V0) * E
    end subroutine turning_points
    
end module prob04_physics


program prob04_driver
    use wkb_toolbox
    use prob04_physics
    implicit none

    integer :: n
    real(dp) :: energy
    
    write(*, '(A)') "------------------------------------------------------"
    write(*, '(A)') "Problem 4: Infinite Potential Well With Slanted Base"
    write(*, '(A)') "------------------------------------------------------"
    write(*, '(A, G0.2, A, G0.2)') "Unit used: m = ", mass, ",  h_bar = ", h_bar
    write(*, '(A)') "Method: WKB + Trapezoidal rule"
    write(*, '(A)') "------------------------------------------------------"
    write(*, '(A)') "The five lowest eigen energies: "; write(*, '(A)') " "

    
    do n = 1, 5
        energy = find_eigenenergy(n, potential, alpha, turning_points, E_max)
        write(*, '(A, I2, A, G0.10)') "n = ", n, "    E = ", energy
    end do

end program prob04_driver