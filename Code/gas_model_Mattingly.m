function [cp, cv, gamma, R, h] = gas_model_Mattingly(T, f)

    % This function calculates the Cp of products of air-kerosene combustion
    % with the Mattingly semi-perfect gas model.

    % -- Inputs --
    % 
    %   T : Absolute Temperature in Kelvin (K)
    %   f : Fraction of kerosene on mass flow rate of air (c/G, dimensionless)
    %
    % -- Outputs --
    %
    %   Cp/v, gamma : Calorific constants of air-kerosene combustion 
    %                 products. (kJ/kmol · K)
    %   R  : Constant of the gas. (kJ/kmol · K)
    %   h_ref : Entalpy of reference. (kJ / kg)
    %
    % Author : Aitor Pitarch Ayza

    %% ---------------------- AIR ----------------------

    air.A0 = 2.5020051e-01;
    air.A1 = -5.1536879e-5;
    air.A2 = 6.5519486e-8;
    air.A3 = -6.7178376e-12;
    air.A4 = -1.5128259e-14;
    air.A5 = 7.6215767e-18;
    air.A6 = -1.4526770e-21;
    air.A7 = 1.0115540e-25;

    air.href = -1.7558886;  % (Btu/lbm)
    air.phiref = ( 8.31447 / 1.9858 ) * 0.0454323; % (kJ/kmol · K)

    air.cp_pol = [-air.A7 air.A6 air.A5 air.A4 ...
            -air.A3 air.A2 air.A1 air.A0];
    
    air.cp = ( 8.31447 / 1.9858 ) * polyval(air.cp_pol, T); % (kJ/kmol · K)

    air.h_pol =[air.A7/8 air.A6/7 air.A5/6 air.A4/5 ...
    air.A3/4 air.A2/3 air.A1/2 air.A0 air.href];

    air.h =  0.430 * polyval(air.h_pol, T); % (kJ/kg)

    %% ---------------------- PRODUCTS ----------------------

    prod.A0 = 7.3816638e-2;
    prod.A1 = 1.2258630e-3;
    prod.A2 = -1.3771901e-6;
    prod.A3 = 9.9686793e-10;
    prod.A4 = -4.2051104e-13;
    prod.A5 = 1.0212913e-16;
    prod.A6 = -1.3335668e-20;
    prod.A7 = 7.2678710e-25;

    prod.href = 30.58153; % (Btu/lbm)
    prod.phiref = ( 8.31447 / 1.9858 ) * 0.6483398; % (kJ/kmol · K)

    prod.cp_pol = [-prod.A7 prod.A6 prod.A5 prod.A4 ...
            -prod.A3 prod.A2 prod.A1 prod.A0];
    
    prod.cp = ( 8.31447 / 1.9858 ) * polyval(prod.cp_pol, T); % (kJ/kmol · K)

    prod.h_pol =[prod.A7/8 prod.A6/7 prod.A5/6 prod.A4/5 ...
    prod.A3/4 prod.A2/3 prod.A1/2 prod.A0 prod.href];

    prod.h =  0.430 * polyval(prod.h_pol, T); % (kJ/kg)

    %% ---------------------- RESULTS ----------------------

    cp = ( air.cp + f * prod.cp )/ ( 1 + f );

    h = ( air.h + f * prod.h )/ ( 1 + f );

    R = ( 8.31447 / 1.9858 ) * ( 1.9857117 / ( 28.97 - f * 0.946186 ) );
    
    cv = cp - R;
    
    gamma = cp / cv;
    
end