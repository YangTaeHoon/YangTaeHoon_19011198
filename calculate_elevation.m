function  el = calculate_elevation(ENU, el_mask)
r1 = ENU(1);
r2 = ENU(2);
r3 = ENU(3);
r_ENU = sqrt(r1^2+r2^2+r3^2);
el = asin(r3/r_ENU);
el = rad2deg(el);

    if el<=el_mask
        el= NaN;
    end
end