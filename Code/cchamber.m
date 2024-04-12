%% Combustion chamber

%La función en este caso, calculará el FAR y la P4t, pero porque tenemos
%T4t, de normal, el parámetro que se busca es T4t porque conocemos el flujo
%de combustible y de ahí obtenemos el far

function [f, P4t] = cchamber(T31t, T4t, P31t, pi_34, rend_cb, L, cp, gas_type)

    if gas_type == 'ideal'

        f=(T31t-T4t)/(T4t-rend_cb*L/cp); %Cálculo Far
        P4t = P31t*pi_34; %Pérdida presión de parada en c. comb.

    elseif gas_type == 'matti'

        P4t = P31t*pi_34;

        vf = 0:0.01:0.4;
        prev_diff = 99999;
        cp_aire = @(T) cp_T(T, 0);

        part2 = integral(cp_aire, 288.15, T31t);

        for ii=1:length(vf)

            cp = @(T) cp_T(T, f);
            part1 = (1 + vf(ii)) * integral(cp, 288.15, T4t)...
                     - rend_cb * L * vf(ii);

            diff = part1 - part2;

            if abs(prev_diff) > abs(diff) 

                prev_diff = diff;
                f_min_diff = vf(ii);

            end

        end

        f = f_min_diff;


    end

end