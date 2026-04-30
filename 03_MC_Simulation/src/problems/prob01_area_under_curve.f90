module prob01_physics
    use constants_mod
    use monte_carlo_toolbox
    implicit none
    
contains
    function quadratic_f(x_vals) result(y_vals)
        real(dp), intent(in), dimension(:) :: x_vals
        real(dp), dimension(size(x_vals)) :: y_vals
    
        y_vals = x_vals**2.0_dp
    end function quadratic_f

    subroutine generate_scatter_data(N, a, b, filename)
        integer, intent(in) :: N
        character(len=*), intent(in) :: filename
        real(dp), intent(in) :: a, b
        real(dp), allocatable :: x(:), y(:), F1(:)
        integer :: i, is_inside

        allocate(x(N), y(N), F1(N))
        call uniform(a, b, x)
        call uniform(a, b, y)
        F1 = quadratic_f(x)

        open(unit=10, file=filename, status='replace')
        write(10, *) "# X_coord   Y_coord   Inside_curve(1=Yes, 0=No)"
        
        do i = 1, N
            if (y(i) <= F1(i)) then
                is_inside = 1
            else
                is_inside = 0
            end if
            write(10, '(2F10.5, I5)') x(i), y(i), is_inside
        end do
        
        close(10)
        deallocate(x, y, F1)
    end subroutine generate_scatter_data

    subroutine generate_error_data(th_val, a, b, filename)
        real(dp), intent(in) :: th_val
        character(len=*), intent(in) :: filename
        real(dp), intent(in) :: a, b
        integer :: i, N
        real(dp) :: current_val

        open(unit=20, file=filename, status='replace')
        write(20, *) "# N_iterations   Estimated_values"
        
        do i = 2, 5
            N = 10**i
            current_val = MC_area_single(quadratic_f, N, a, b, a, b)
            write(20, '(I10, F15.9)') N, abs(current_val - th_val)
        end do
        close(20)
    end subroutine generate_error_data
end module prob01_physics

program prob01_driver
    use prob01_physics
    use constants_mod
    implicit none
    integer :: N
    real(dp) :: a, b, integral, exact

    a = 0
    b = 1
    N = 5000
    exact = 1.0_dp/3.0_dp

    call random_seed()
    integral = MC_area_single(quadratic_f, N, a, b, a, b)

    write(*, '(A)') "Function: f(x) = x^2"
    write(*, '(A)') "-----------------------------------------"
    write(*, '(A, G0.6)') "Monte-Carlo estimation: ", integral
    write(*, '(A, G0.6)') "Exact result: ", exact

    call generate_scatter_data(N, a, b, 'data/prob01_sampling.dat')
    call generate_error_data(exact, a, b, 'data/prob01_error.dat')

end program prob01_driver