module monte_carlo_toolbox
    use constants_mod
    implicit none
    abstract interface
        function math_func_1D(x_val) result(y_val)
                use constants_mod
                real(dp), intent(in), dimension(:) :: x_val
                real(dp), dimension(size(x_val)) :: y_val
        end function math_func_1D

        function math_func_2D(x_val, y_val) result(z_val)
                use constants_mod
                real(dp), intent(in), dimension(:) :: x_val
                real(dp), intent(in), dimension(:) :: y_val
                real(dp), dimension(size(x_val)) :: z_val
        end function math_func_2D
    end interface
contains
    subroutine uniform(a, b, arr)
        real(dp), intent(in) :: a, b
        real(dp), intent(out), dimension(:) :: arr
        
        call random_number(arr)
        arr = a + (b - a)*arr
    end subroutine uniform

    function MCI_1D(f, a, b, N) result(A_mc)
        procedure(math_func_1D) :: f
        real(dp), intent(in) :: a, b
        integer, intent(in) :: N
        real(dp) :: A_mc
        real(dp), allocatable :: x(:)

        allocate(x(N))
        
        call uniform(a, b, x)
        A_mc = (b - a)*sum(f(x))/real(N, dp)
        deallocate(x)
    end function MCI_1D

    function MCI_2D(f, x1, x2, y1, y2, N) result(A_mc)
        procedure(math_func_2D) :: f
        real(dp), intent(in) :: x1, x2, y1, y2
        integer, intent(in) :: N
        real(dp) :: A_mc
        real(dp), allocatable :: x(:), y(:)
        
        allocate(x(N), y(N))

        call uniform(x1, x2, x)
        call uniform(y1, y2, y)
        A_mc = (x2 - x1)*(y2 - y1)*sum(f(x, y))/real(N, dp)
        deallocate(x, y)
    end function MCI_2D

    function MC_area_single(f, N, a, b, c, d) result (A_mc)
        procedure(math_func_1D) :: f
        integer, intent(in) :: N
        real(dp), intent(in) :: a, b, c, d
        real(dp) :: A_mc
        
        real(dp), allocatable :: x(:), y(:)
        real(dp) :: area_box

        allocate(x(N), y(N))
        call uniform(a, b, x)
        call uniform(c, d, y)

        area_box = (b - a)*(d - c)
        A_mc = area_box*real(count(y <= f(x)), dp)/real(N, dp)
        deallocate(x, y)
    end function MC_area_single
    
    function MC_area_dual(f1, f2, N, a, b, c, d) result (A_mc)
        procedure(math_func_1D) :: f1, f2
        integer, intent(in) :: N
        real(dp), intent(in) :: a, b, c, d
        real(dp) :: A_mc
        
        real(dp), allocatable :: x(:), y(:)
        real(dp) :: area_box
        
        allocate(x(N), y(N))
        call uniform(a, b, x)
        call uniform(c, d, y)
        
        area_box = (b - a)*(d - c)
        A_mc = area_box*real(count(y >= f1(x) .and. y <= f2(x)), dp)/real(N, dp)
        deallocate(x, y)
    end function MC_area_dual
    
    function MC_volume_2D(f, N, a, b, c, d, bound) result (A_mc)
        procedure(math_func_2D) :: f
        integer, intent(in) :: N
        real(dp), intent(in) :: a, b, c, d, bound
        real(dp) :: A_mc
        
        real(dp), allocatable :: x(:), y(:)
        real(dp) :: area_box

        allocate(x(N), y(N))
        call uniform(a, b, x)
        call uniform(c, d, y)

        area_box = (b - a)*(d - c)
        A_mc = area_box*real(count( f(x,y) <= bound), dp)/real(N, dp)
        deallocate(x, y)
    end function MC_volume_2D
end module monte_carlo_toolbox