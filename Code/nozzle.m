%% Tobera

function [T9t, P9t, T9, P9, V9, M9, A9] = nozzle(T8t, P8t, P0, gamma,...
                                                 Cp, Rg, G, f, gas_type)

    if gas_type == 'ideal'

    T9t = T8t;
    P9t = P8t; %Isentrópico
    P9 = P0; %Tobera adaptada
    T9 = T9t/(P9t/P9)^((gamma-1)/gamma);
    V9 = sqrt((T9t-T9)*2*Cp);
    rho9 = P9/Rg/T9;
    a9 = sqrt(Rg*gamma*T9);
    M9 = V9/a9;
    A9 = G*(1+f)/(rho9*V9);
    

    end

end