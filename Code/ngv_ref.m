%% NGV refrigeration

% Ecuación de la energía

function [T41t, P41t] = ngv_ref(T3t, T4t, P4t, g1, g2, f, Cp, gas_type)

    if gas_type == 'ideal'

        T41t=(g1*Cp*T3t+(1-g1-g2)*(1+f)*Cp*T4t)/(((1-g1-g2)*(1+f)+g1)*Cp);
        P41t = P4t;
    
    elseif gas_type == 'matti'
    
        P41t = P4t;
%         solve1 = @(x) 

    end

end