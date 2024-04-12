function cp = cp_T(T, f)

    % This function calculates the Cp of products of air-kerosene combustion
    % with the Mattingly semi-perfect gas model.

    % -- Inputs --
    % 
    %   T : Absolute Temperature in Kelvin (K)
    %   f : Fraction of kerosene on mass flow rate of air (c/G, dimensionless)
    %
    % -- Outputs --
    %
    %   Cp : Calorific constants of air-kerosene combustion. (kJ/kmol · K)
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

    air.cp_pol = [-air.A7 air.A6 air.A5 air.A4 ...
            -air.A3 air.A2 air.A1 air.A0];
    
    air.cp = ( 8.31447 / 1.9858 ) * polyval(air.cp_pol, T); % (kJ/kmol · K)

    %% ---------------------- PRODUCTS ----------------------

    prod.A0 = 7.3816638e-2;
    prod.A1 = 1.2258630e-3;
    prod.A2 = -1.3771901e-6;
    prod.A3 = 9.9686793e-10;
    prod.A4 = -4.2051104e-13;
    prod.A5 = 1.0212913e-16;
    prod.A6 = -1.3335668e-20;
    prod.A7 = 7.2678710e-25;

    prod.cp_pol = [-prod.A7 prod.A6 prod.A5 prod.A4 ...
            -prod.A3 prod.A2 prod.A1 prod.A0];
    
    prod.cp = ( 8.31447 / 1.9858 ) * polyval(prod.cp_pol, T); % (kJ/kmol · K)

    %% ---------------------- RESULTS ----------------------

    cp = ( air.cp + f * prod.cp )/ ( 1 + f );
    
end