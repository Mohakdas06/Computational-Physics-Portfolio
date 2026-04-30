!===========================================================
! File    : prob07_mod_x_cube.f90
! Author  : Mohak Das
! Course  : Computational Lab: Quantum Mechanics
! Topic   : FDM approximation for |x^3| potential
! Units   : m = h_bar = 1
! Method  : Finite Difference Method
!===========================================================


module prob07_physics
    use constants_mod
    implicit none
    integer, parameter :: N = 2001
    real(dp) :: L_box = 4.0_dp
    real(dp) :: x, dx
    real(dp) :: d(N), e(N), z(N, N)
    integer :: i

contains
    subroutine initialize()
        dx = (2 * L_box) / real(N - 1, dp)
        z = 0.0_dp

        do i = 1, N
            z(i, i) = 1.0_dp
        end do

        do i = 1, N
            x = - L_box + real(i - 1, dp) * dx
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
    
        y = abs(x_vals**3)
    end function potential
end module prob07_physics

program prob07_driver
    use FDM_toolbox
    use prob07_physics
    implicit none

    call initialize()
    call tqli(N, d, e, z)
    call sort_eigen(N, d, z)

    write(*, '(A)') "--------------------------------------------"
    write(*, '(A)') "Problem 7: |x^3| potential"
    write(*, '(A)') "--------------------------------------------"
    write(*, '(A, G0.2, A, G0.2)') "Unit used: m = ", mass, ",  h_bar = ", h_bar
    write(*, '(A)') "Method: Finite Difference Method"
    write(*, '(A)') "--------------------------------------------"
    write(*, '(A)') "The first five eigen energies: "; write(*, '(A)') " "

    open(unit=10, file='data/prob07_energies.dat', status='replace')
    do i = 1, 5
        write(*, '(A, I2, A, G0.10)') "n = ", i-1, "    E = ", d(i)
        write(10, *) d(i)
    end do
    close(10)

    open(unit=10, file='data/prob07.dat', status='replace')
    do i = 1, N
        x = - L_box + real(i-1, dp) * dx
        write(10, *) x, potential(x), z(i,1), z(i,2), z(i,3), z(i, 4), z(i, 5)
    end do
    close(10)
    print *, "Wavefunctions written to prob07.dat"
end program prob07_driver