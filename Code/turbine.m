%% Turbine

function [T5t, P5t, pi_45] = turbine(T2t, T3t, T41t, P41t, g1, g2, eta_m,...
                                     eta_t, f, gamma,  gas_type)

    if gas_type == 'ideal'

    T5t = T41t-(T3t-T2t)/(eta_m*((1-g1-g2)*(1+f)+g1)); %Acople comp-turb.
    P5t = P41t*(1-(1-T5t/T41t)/(eta_t))^(gamma/(gamma-1)); %Efficiency
    pi_45 = P41t/P5t;

    end

end