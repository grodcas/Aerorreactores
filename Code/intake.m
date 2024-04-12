%% Intake

function [T1t, P1t] = intake(T0t, P0t, gas_type)

    if gas_type == 'ideal' 

        T1t = T0t;
        P1t = P0t;

    elseif gas_type == 'matti'

        P1t = 1 * P0t;

        f = 0; % No kerosene at this stage

        [cp, cv, gamma, R, h] = gas_model_Mattingly(T0t, f);

        % In this option due to the gas model which has Cp = f(T), the isentro- 
        % -pic evolution has to be calculated in other way.

        % Vector to calculate T3ts, the vT(ii) which has the smallest difference    
        % between the part1 and the part2 is the chosen T3ts.
        vT = T0t+5:1:T0t+100;
        diff = 9999999;

        part2 = R * log(1);

        for ii=1:length(vT)

            sum = 0;
            vX = T0t:1:vT(ii);
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

        T1t = T_min_diff;

    end

end