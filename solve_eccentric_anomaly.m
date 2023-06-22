%M으로부터 E를 구하기위한 수치대입
function E = solve_eccentric_anomaly(M, e)
    E = M;  % 초기 조건
    while true
        E_next = E - (E - e * sin(E) - M) / (1 - e * cos(E));
        if abs(E_next - E) < 1e-8
            break;
        end
        E = E_next;
    end
end