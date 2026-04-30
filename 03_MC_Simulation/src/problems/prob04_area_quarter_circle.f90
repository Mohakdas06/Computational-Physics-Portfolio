module prob04_physics
    use constants_mod
    use monte_carlo_toolbox
    implicit none
contains
    function quarter_f(x_vals) result(y_vals)
        real(dp), intent(in), dimension(:) :: x_vals
        real(dp), dimension(size(x_vals)) :: y_vals
    
        y_vals = sqrt(1 - x_vals**2.0_dp)
    end function quarter_f

    subroutine generate_scatter_data(N, a, b, filename)
        integer, intent(in) :: N
        character(len=*), intent(in) :: filename
        real(dp), intent(in) :: a, b
        real(dp), allocatable :: x(:), y(:), F1(:)
        integer :: i, is_inside

        allocate(x(N), y(N), F1(N))
        call uniform(a, b, x)
        call uniform(a, b, y)
        F1 = quarter_f(x)

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
end module prob04_physics

program prob04_driver
    use prob04_physics
    use constants_mod
    use monte_carlo_toolbox
    implicit none
    integer :: N
    real(dp) :: a, b, integral

    a = 0.0_dp
    b = 1.0_dp
    N = 5000

    call random_seed()
    integral = MC_area_single(quarter_f, N, a, b, a, b)

    write(*, '(A)') "Function: f(x) = (1 - x^2)^0.5"
    write(*, '(A)') "-----------------------------------------"
    write(*, '(A, G0.6)') "Monte-Carlo estimation: ", integral
    write(*, '(A, G0.10)') "Estimated value of pi: ", 4.0_dp*integral

    call generate_scatter_data(N, a, b, 'data/prob04_sampling.dat')

end program prob04_driver