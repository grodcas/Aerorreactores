%% Turbine refrigeration

% Ecuación de la energía

function [T51t, P51t] = turb_ref(T3t, T5t, P5t, g1, g2, f, Cp, gas_type)

    if gas_type == 'ideal'

    P51t = P5t;
    T51t=(g2*Cp*T3t+((1-g1-g2)*(1+f)+g1)*Cp*T5t)/(((1-g1-g2)*...
         (1+f)+g1+g2)*Cp);
    
    end

end