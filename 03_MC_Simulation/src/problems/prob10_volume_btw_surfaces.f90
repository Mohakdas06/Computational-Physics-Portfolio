module prob10_physics
    use constants_mod
    use monte_carlo_toolbox
    implicit none
contains
    function integrand(x_val, y_val) result(z_val)
        real(dp), intent(in), dimension(:) :: x_val, y_val
        real(dp), dimension(size(x_val)) :: z_val

        z_val = (x_val + y_val) - (x_val**2 + y_val**2)
    end function integrand

    subroutine generate_sampling_data(f, x1, x2, y1, y2, N, filename)
        procedure(math_func_2D) :: f
        integer, intent(in) :: N
        character(len=*), intent(in) :: filename
        real(dp), intent(in) :: x1, x2, y1, y2
        real(dp), allocatable :: x(:), y(:), z(:)
        integer :: i

        allocate(x(N), y(N), z(N))
        call uniform(x1, x2, x)
        call uniform(y1, y2, y)
        z = f(x, y)
        open(unit=10, file=filename, status='replace')
        write(10, *) "# x       y       f(x, y)"
        
        do i = 1, N
            write(10, '(3F10.5)') x(i), y(i), z(i)
        end do
        
        close(10)
        deallocate(x, y, z)
    end subroutine generate_sampling_data
end module prob10_physics


program prob10_driver
    use constants_mod
    use monte_carlo_toolbox
    use prob10_physics
    implicit none
    real(dp) :: x1, x2, y1, y2, exact, integral
    integer :: N

    N = 1000000

    x1 = 0.0_dp
    x2 = 1.0_dp
    y1 = 0.0_dp
    y2 = 1.0_dp
    exact = 1.0_dp/3.0_dp

    call random_seed()
    integral = MCI_2D(integrand, x1, x2, y1, y2, N)

    write(*, '(A)') "Function: f(x) = (x+y)-(x^2+y^2)"
    write(*, '(A)') "-----------------------------------------"
    write(*, '(A, G0.10)') "Estimated value: ", integral
    write(*, '(A, G0.10)') "Actual value: ", exact

    call generate_sampling_data(integrand, x1, x2, y1, y2, 2000, 'data/prob10_sampling.dat')

end program prob10_driver