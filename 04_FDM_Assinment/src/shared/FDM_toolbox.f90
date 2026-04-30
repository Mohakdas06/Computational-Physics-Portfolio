module FDM_toolbox
    use constants_mod
    implicit none

contains
    subroutine tqli(n, d, e, z)
        integer, intent(in) :: n
        real(dp), intent(inout) :: d(n), e(n), z(n,n)

        integer :: m, l, iter, i, k
        real(dp) :: s, c, p, g, r, f, b, dd

        ! Renumbering the e(n)
        do i = 2, n
            e(i-1) = e(i)
        end do
        e(n) = 0.0_dp

        do l = 1, n
            iter = 0
            do
                ! checking if the diagonal element is the eigenvalue
                do m = l, n-1
                    dd = abs(d(m)) + abs(d(m+1))
                    if (abs(e(m)) + dd == dd) exit
                end do

                if (m == l) exit

                if (iter == 30) then
                    write(*, '(A)') "Too many iterations in tqli"
                    stop
                end if
                iter = iter + 1

                ! Wilkinson shift to accelerate convergence
                g = (d(l+1) - d(l))/(2.0_dp * e(l))
                r = sqrt(g**2 + 1.0_dp**2)

                ! g = d(m) - d(l) + e(l) / (g + sign(r))
                if (g >= 0) then
                    g = d(m) - d(l) + e(l) / (g + r)
                else
                    g = d(m) - d(l) + e(l) / (g - r)
                end if

                ! Givens Rotaion
                s = 1.0_dp
                c = 1.0_dp
                p = 0.0_dp

                do i = m-1, l, -1
                    f = s*e(i)
                    b = c*e(i)
                    r = sqrt(f**2 + g**2)
                    e(i+1) = r

                    if ( r == 0.0_dp ) then
                        d(i+1) = d(i+1) - p
                        e(m) = 0.0_dp
                        exit
                    end if

                    s = f/r
                    c = g/r
                    g = d(i+1) - p
                    r = (d(i) - g) * s + 2.0_dp * c * b
                    p = s*r
                    d(i+1) = g + p
                    g = c*r-b

                    ! Accumulate rotations into Eigenvectors Z
                    do k = 1, n
                        f = z(k, i+1)
                        z(k, i+1) = s*z(k, i) + c*f
                        z(k, i) = c*z(k, i) - s*f
                    end do
                end do
                d(l) = d(l) - p
                e(l) = g
                e(m) = 0.0_dp
            end do 
        end do
    end subroutine tqli

    subroutine sort_eigen(n, d, z)
        integer, intent(in) :: n
        real(dp), intent(inout) :: d(n), z(n, n)

        integer :: i, j, k
        real(dp) :: temp

        do i = 1, n-1
            k = i
            temp = d(i)
            do j = i+1, n
                if ( d(j) < temp ) then
                    k = j
                    temp = d(j)
                end if
            end do
            if ( k /= i ) then
                d(k) = d(i)
                d(i) = temp
                do j = 1, n
                    temp = z(j, i)
                    z(j, i) = z(j, k)
                    z(j, k) = temp
                end do
            end if
        end do
        do i = 1, n
            k = maxloc(abs(z(:, i)), 1)
            if ( z(k, i) < 0.0_dp ) then
                z(:, i) = -1.0_dp * z(:, i)
            end if
        end do
    end subroutine sort_eigen
end module FDM_toolbox