module prob02_physics
    use constants_mod
    use monte_carlo_toolbox
    implicit none
    
contains
    function trig_f(x_vals) result(y_vals)
        real(dp), intent(in), dimension(:) :: x_vals
        real(dp), dimension(size(x_vals)) :: y_vals
    
        y_vals = sin(x_vals)
    end function trig_f

    subroutine generate_scatter_data(N, a, b, c, d, filename)
        integer, intent(in) :: N
        character(len=*), intent(in) :: filename
        real(dp), intent(in) :: a, b, c, d
        real(dp), allocatable :: x(:), y(:), F1(:)
        integer :: i, is_inside

        allocate(x(N), y(N), F1(N))
        call uniform(a, b, x)
        call uniform(c, d, y)
        F1 = trig_f(x)

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

    subroutine generate_error_data(th_val, a, b, c, d, filename)
        real(dp), intent(in) :: th_val
        character(len=*), intent(in) :: filename
        real(dp), intent(in) :: a, b, c, d
        integer :: i, N
        real(dp) :: current_val

        open(unit=20, file=filename, status='replace')
        write(20, *) "# N_iterations   Estimated_values"
        
        do i = 1, 7
            N = 10**i
            current_val = MC_area_single(trig_f, N, a, b, c, d)
            write(20, '(I10, F15.9)') N, abs(current_val - th_val)
        end do
        close(20)
    end subroutine generate_error_data
end module prob02_physics

program prob02_driver
    use prob02_physics
    use constants_mod
    implicit none
    integer :: N
    real(dp) :: a, b, c, d, integral, exact

    a = 0
    b = pi
    c = 0
    d = 1
    N = 5000
    exact = 2.0_dp

    call random_seed()
    integral = MC_area_single(trig_f, N, a, b, c, d)

    write(*, '(A)') "Function: f(x) = sin(x)"
    write(*, '(A)') "-----------------------------------------"
    write(*, '(A, G0.6)') "Monte-Carlo estimation: ", integral
    write(*, '(A, G0.6)') "Exact result: ", exact

    call generate_scatter_data(N, a, b, c, d, 'data/prob02_sampling.dat')
    call generate_error_data(exact, a, b, c, d, 'data/prob02_error.dat')

end program prob02_driver