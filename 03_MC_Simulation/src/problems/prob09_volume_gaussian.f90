module prob09_physics
    use constants_mod
    use monte_carlo_toolbox
    implicit none
contains
    function gaussian_2D(x_val, y_val) result(z_val)
        real(dp), intent(in), dimension(:) :: x_val, y_val
        real(dp), dimension(size(x_val)) :: z_val

        z_val = exp(-(x_val**2 + y_val**2))
    end function gaussian_2D

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

    subroutine generate_convergence_data(x1, x2, y1, y2, filename)
        character(len=*), intent(in) :: filename
        real(dp), intent(in) :: x1, x2, y1, y2
        integer :: i, N
        real(dp) :: current_val

        open(unit=20, file=filename, status='replace')
        write(20, *) "# N_iterations   Estimated_values"
        
        do i = 1, 7
            N = 10**i
            current_val = MCI_2D(gaussian_2D, x1, x2, y1, y2, N)
            write(20, '(I10, F15.9)') N, current_val
        end do
        
        close(20)
    end subroutine generate_convergence_data
end module prob09_physics


program prob09_driver
    use constants_mod
    use monte_carlo_toolbox
    use prob09_physics
    implicit none
    real(dp) :: x1, x2, y1, y2, integral
    integer :: N

    N = 10000

    x1 = -2.0_dp
    x2 = 2.0_dp
    y1 = -2.0_dp
    y2 = 2.0_dp

    call random_seed()
    integral = MCI_2D(gaussian_2D, x1, x2, y1, y2, N)

    write(*, '(A)') "Function: f(x) = e^(-(x^2+y^2))"
    write(*, '(A)') "-----------------------------------------"
    write(*, '(A, G0.10)') "Estimated value: ", integral

    call generate_sampling_data(gaussian_2D, x1, x2, y1, y2, 1000, 'data/prob09_sampling.dat')
    call generate_convergence_data(x1, x2, y1, y2, 'data/prob09_value_conv.dat')

end program prob09_driver