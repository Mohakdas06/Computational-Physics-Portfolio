!===========================================================
! File    : prob13_morse_potential.f90 (Additional Exercise)
! Author  : Mohak Das
! Course  : Computational Lab: Quantum Mechanics
! Topic   : FDM approximation for Morse potential
! Units   : m = h_bar = 1
! Method  : Finite Difference Method
!===========================================================


module prob13_physics
    use constants_mod
    implicit none
    integer, parameter :: N = 2001
    real(dp), parameter :: lamba = 2
    real(dp), parameter :: a = 0.18
    real(dp) :: L_box_r = 40.0_dp
    real(dp) :: L_box_l = -6.0_dp
    real(dp) :: x, dx
    real(dp) :: d(N), e(N), z(N, N)
    integer :: i

contains
    subroutine initialize()
        dx = (L_box_r - L_box_l) / real(N - 1, dp)
        z = 0.0_dp

        do i = 1, N
            z(i, i) = 1.0_dp
        end do

        do i = 1, N
            x = L_box_l + real(i - 1, dp) * dx
            d(i) = ((h_bar**2) / (mass * dx**2)) + potential(x)
            if ( i < N ) then
                e(i) = - (h_bar**2) / (2 * mass * dx**2)
            else
                e(N) = 0.0_dp
            end if
        end do
    end subroutine initialize

    function potential(x_vals) result(y)
        real(dp), intent(in) :: x_vals
        real(dp) :: y
    
        y = lamba * (1 - exp(-a*x_vals))**2
    end function potential
end module prob13_physics

program prob13_driver
    use FDM_toolbox
    use prob13_physics
    implicit none

    call initialize()
    call tqli(N, d, e, z)
    call sort_eigen(N, d, z)

    write(*, '(A)') "--------------------------------------------"
    write(*, '(A)') "Problem 13: Morse potential"
    write(*, '(A)') "--------------------------------------------"
    write(*, '(A, G0.2, A, G0.2)') "Unit used: m = ", mass, ",  h_bar = ", h_bar
    write(*, '(A)') "Method: Finite Difference Method"
    write(*, '(A)') "--------------------------------------------"
    write(*, '(A)') "The first five eigen energies: "; write(*, '(A)') " "

    open(unit=10, file='data/prob13_energies.dat', status='replace')
    do i = 1, 5
        write(*, '(A, I2, A, G0.10)') "n = ", i-1, "    E = ", d(i)
        write(10, *) d(i)
    end do
    close(10)

    open(unit=10, file='data/prob13.dat', status='replace')
    do i = 1, N
        x = L_box_l + real(i-1, dp) * dx
        write(10, *) x, potential(x), z(i,1), z(i,2), z(i,3), z(i, 4), z(i, 5)
    end do
    close(10)
    print *, "Wavefunctions written to prob13.dat"
end program prob13_driver