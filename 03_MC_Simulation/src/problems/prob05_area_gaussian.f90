module prob05_physics
    use monte_carlo_toolbox
    use constants_mod
    implicit none
contains
    function f_exp(x_val) result(y_val)
        real(dp), intent(in), dimension(:) :: x_val
        real(dp), dimension(size(x_val)) :: y_val

        y_val = exp(-x_val**2)
    end function f_exp

    subroutine generate_func_data(f, a, b, N, filename)
        procedure(math_func_1D) :: f
        real(dp), intent(in) :: a, b
        integer, intent(in) :: N
        character(len=*), intent(in) :: filename
        real(dp), allocatable :: x(:), y(:)
        integer :: i
        
        allocate(x(N), y(N))
        call uniform(a, b, x)
        y = f(x)
        open(unit=10, file=filename, status='replace')
        write(10, *) "# x   f(x)"
        
        do i = 1, N
            write(10, '(2F10.5)') x(i), y(i)
        end do
        
        close(10)
        deallocate(x, y)
    end subroutine generate_func_data
    
    subroutine generate_convergence_data(a, b, filename)
        real(dp), intent(in) :: a, b
        character(len=*), intent(in) :: filename
        integer :: i, N
        real(dp) :: current_val

        open(unit=20, file=filename, status='replace')
        write(20, *) "# N_iterations   Estimated_values"
        
        do i = 1, 7
            N = 10**i
            current_val = MCI_1D(f_exp, a, b, N)
            write(20, '(I10, F15.9)') N, current_val
        end do
        
        close(20)
    end subroutine generate_convergence_data
end module prob05_physics


program prob05_driver
    use constants_mod
    use monte_carlo_toolbox
    use prob05_physics
    implicit none
    real(dp) :: a, b, I1, I2, I3
    integer :: N

    a = 0.0_dp
    b = 2.0_dp
    N = 10000

    call random_seed()
    I1 = MCI_1D(f_exp, a, b, 1000)
    I2 = MCI_1D(f_exp, a, b, 10000)
    I3 = MCI_1D(f_exp, a, b, 100000)

    write(*, '(A)') "Function: f(x) = e^(-x^2)"
    write(*, '(A)') "------------------------------------------------"
    write(*, '(A)') "Estimated values: "
    write(*, '(A)') "-------------+---------------+------------------"
    write(*, '(A)') "N = 1000     | N = 10000     | N = 100000"
    write(*, '(A)') "-------------+---------------+------------------"
    write(*, '(G0.10, A, G0.10, A, G0.10)') I1, " | ", I2, "  | ", I3
    write(*, '(A)') "-------------+---------------+------------------"

    call generate_func_data(f_exp, a, b, 200, 'data/prob05_sampling.dat')
    call generate_convergence_data(a, b, 'data/prob05_value_conv.dat')

end program prob05_driver