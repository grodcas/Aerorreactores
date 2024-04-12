%% Compressor

function [T3t, P3t] = compressor(T2t, P2t, pi_23, eta_c, gamma,  gas_type)

    if gas_type == 'ideal'

        P3t = pi_23 * P2t;

        T3t = T2t*((pi_23^((gamma-1)/gamma)-1)/eta_c+1); %Efficiency

    elseif gas_type == 'matti'

        P3t = pi_23 * P2t;
        f = 0; % No kerosene at this stage

        [cp, cv, gamma, R, h] = gas_model_Mattingly(T2t, f);

        % In this option due to the gas model which has Cp = f(T), the isentro- 
        % -pic evolution has to be calculated in other way.

        % Vector to calculate T3ts, the vT(ii) which has the smallest difference    
        % between the part1 and the part2 is the chosen T3ts.
        vT = T2t+10:2:1000;
        diff = 9999999;

        part2 = R * log(pi_23);

        for ii=1:length(vT)

            sum = 0;
            vX = T2t:1:vT(ii);
            delta_X = vX(2) - vX(1);

            % Numerical integration of the part1.

            for jj=1:length(vX)-1

                cp_jj = cp_T(vX(jj), f);

                sum = sum + cp_jj / vX(jj) * delta_X;

            end

            part1 = sum;

            delta_s = part1 - part2;

            if abs(diff) > abs(delta_s)

                diff = delta_s;
                T_min_diff = vT(ii);

            end

        end

        T3ts = T_min_diff;

        % Once T3ts is calculated:

        prev_diff = 999999;
        part1 = eta_c;

        for ii=1:length(vT)

            part2 = ( cp_T(T3ts, f) * T3ts - cp_T(T2t, f) * T2t ) / ...
                    ( cp_T(vT(ii), f) * vT(ii) - cp_T(T2t, f) * T2t );

            diff = part1 - part2;

            if abs(prev_diff) < abs(diff)

                prev_diff = diff;
                T_min_diff = vT(ii);

            end

        end

        T3t = T_min_diff;

    end

end