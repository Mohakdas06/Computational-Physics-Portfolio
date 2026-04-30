module prob03_physics
    use constants_mod
    use monte_carlo_toolbox
    implicit none
contains
    function quadratic_f(x_vals) result(y_vals)
        real(dp), intent(in), dimension(:) :: x_vals
        real(dp), dimension(size(x_vals)) :: y_vals
 
        y_vals = x_vals**2.0_dp
    end function quadratic_f

    function linear_f(x_vals) result(y_vals)
        real(dp), intent(in), dimension(:) :: x_vals
        real(dp), dimension(size(x_vals)) :: y_vals

        y_vals = x_vals
    end function linear_f

    subroutine generate_scatter_data(N, a, b, filename)
        integer, intent(in) :: N
        character(len=*), intent(in) :: filename
        real(dp), intent(in) :: a, b
        real(dp), allocatable :: x(:), y(:), F1(:), F2(:)
        integer :: i, is_inside

        allocate(x(N), y(N), F1(N), F2(N))
        call uniform(a, b, x)
        call uniform(a, b, y)
        F1 = quadratic_f(x)
        F2 = linear_f(x)

        open(unit=10, file=filename, status='replace')
        write(10, *) "# X_coord   Y_coord   Inside_curve(1=Yes, 0=No)"
        
        do i = 1, N
            if (y(i) >= F1(i) .and. y(i) <= F2(i)) then
                is_inside = 1
            else
                is_inside = 0
            end if
            write(10, '(2F10.5, I5)') x(i), y(i), is_inside
        end do
        
        close(10)
        deallocate(x, y, F1, F2)
    end subroutine generate_scatter_data
end module prob03_physics

program prob03_driver
    use prob03_physics
    use constants_mod
    use monte_carlo_toolbox
    implicit none
    integer :: N
    real(dp) :: a, b, integral, exact

    a = 0
    b = 1
    N = 5000
    exact = 1.0_dp/6.0_dp

    call random_seed()
    integral = MC_area_dual(quadratic_f, linear_f, N, a, b, a, b)

    write(*, '(A)') "Function: f1(x) = x^2 and f2(x) = x"
    write(*, '(A)') "-----------------------------------------"
    write(*, '(A, G0.6)') "Monte-Carlo estimation: ", integral
    write(*, '(A, G0.6)') "Exact result: ", exact

    call generate_scatter_data(N, a, b, 'data/prob03_sampling.dat')

end program prob03_driver