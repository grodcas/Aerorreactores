%% Flight conditions

function [T0t, P0t, a0] = fcond(T0, P0, M0, gamma, Rg, gas_type)

 if gas_type == 'ideal'

    T0t = T0*(1+(gamma-1)/2*M0^2);
    P0t = P0*(T0t/T0)^(gamma/(gamma-1));
    a0 = sqrt(gamma*Rg*T0);

 elseif gas_type == 'matti'

    f = 0; % No kerosene at inlet

    [cp, cv, gamma, R, h] = gas_model_Mattingly(T0, f);

    T0t = T0*(1+(gamma-1)/2*M0^2);
    P0t = P0*(T0t/T0)^(gamma/(gamma-1));
    a0 = sqrt(gamma*Rg*T0);

 end
 
end