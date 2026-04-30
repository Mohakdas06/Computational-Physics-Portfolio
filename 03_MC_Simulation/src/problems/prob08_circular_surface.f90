module prob08_physics
    use constants_mod
    use monte_carlo_toolbox
    implicit none
    
contains
    function unit_circle(x_val, y_val) result(z_val)
        use constants_mod
        real(dp), intent(in), dimension(:) :: x_val, y_val
        real(dp), dimension(size(x_val)) :: z_val

        z_val = x_val**2 + y_val**2
    end function unit_circle

    subroutine generate_scatter_data(N, a, b, bound, filename)
        integer, intent(in) :: N
        character(len=*), intent(in) :: filename
        real(dp), intent(in) :: a, b, bound
        real(dp), allocatable :: x(:), y(:), F1(:)
        integer :: i, is_inside

        allocate(x(N), y(N), F1(N))
        call uniform(a, b, x)
        call uniform(a, b, y)
        F1 = unit_circle(x, y)

        open(unit=10, file=filename, status='replace')
        write(10, *) "# X_coord   Y_coord   Inside_curve(1=Yes, 0=No)"
        
        do i = 1, N
            if (F1(i) <= bound) then
                is_inside = 1
            else
                is_inside = 0
            end if
            write(10, '(2F10.5, I5, F10.5)') x(i), y(i), is_inside, F1(i)
        end do
        
        close(10)
        deallocate(x, y, F1)
    end subroutine generate_scatter_data
end module prob08_physics

program prob08_driver
    use constants_mod
    use monte_carlo_toolbox
    use prob08_physics
    implicit none
    real(dp) :: exact, bound, a, b, integral
    integer :: N

    N = 10000
    a = -1.0_dp
    b = 1.0_dp
    bound = 1.0_dp
    exact = pi

    call random_seed()
    integral = MC_volume_2D(unit_circle, N, a, b, a, b, bound)
    
    write(*, '(A, G0.6)') "Monte-Carlo estimation: ", integral
    write(*, '(A, G0.6)') "Exact result: ", exact

    call generate_scatter_data(2000, a, b, bound, 'data/prob08_sampling.dat')
end program prob08_driver