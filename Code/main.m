%% Actuaciones de Aerorreactores: primer caso de estudio %% AVRO CANADA ORENDA 14
%%% Piedrabuena Muñoz, Marcos
%%% Prados Palacios, Luis Miguel
%%% Pitarch Ayza, Aitor

close all
clc
clear
%% Datos
    P0 = 101325; %Pa
    T0 = 288.15; %K
    M0 = 0; %adim.
    G = 56.699046; %kg/s
    gamma = 1.4;
    %Para el caso de gas perfecto, recomiendo hacer una función que calcule
    %un 'gamma perfecto', que sea f(T)
    pi_23 = 6.932; %Relación compresión en compresor
    pi_12 = 0.88; %Pérdida presión de remanso en difusor
    pi_34 = 0.9; %Pérdida de presión en la cámara
    eta_c = 0.8; %Rendimiento compresor
    eta_t = 0.8; %Rendimiento turbina
    T4t = 1190; %Temperatura entrada turbina, K
    Cp = 1012; %J/kg/K
    L = 43E6; %Poder calorífico
    eta_cb = 0.88;%Rendimiento combustión
    Rg = 287; %cte. gases
    eta_m = 0.99; %Rendimiento del eje transmitiendo potencia

    gas_model = 'ideal';

%% Sección 0: condiciones ambiente

    [T0t, P0t, a0] = fcond(T0, P0, M0, gamma, Rg, gas_model);
    
%% Sección 1: labio de entrada del difusor

    [T1t, P1t] = intake(T0t, P0t, gas_model);
    
%% Sección 2: entrada del compresor

    [T2t, P2t] = diffuser(T1t, P1t, pi_12, gas_model);
    
%% Sección 3: entrada de la cámara de combustión/salida compresor

    [T3t, P3t] = compressor(T2t, P2t, pi_23, eta_c, gamma, gas_model);
    
%% Sangrado 31: 6% gasto a NGV, 4% a rotor turb.
%No se altera Presión y temp. de remanso
    
    g1 = 0.06;
    g2 = 0.04;
    T31t = T3t;
    P31t = P3t;

%% Sección 4: Salida cámara combustión
    
[f, P4t] = cchamber(T31t, T4t, P31t, pi_34, eta_cb, L, Cp, gas_model);
    
%% Refrigeración 41: Incorporación sangrado NGV

 [T41t, P41t] = ngv_ref(T3t, T4t, P4t, g1, g2, f, Cp, gas_model);
    
%% Sección 5: salida de la turbina/entrada de la tobera (no hay AB)

    [T5t, P5t, pi_45] = turbine(T2t, T3t, T41t, P4t, g1, g2, eta_m,...
                                eta_t, f, gamma,  gas_model);
    
%% Refrigeración turbina, quedando la corriente '51'
    
[T51t, P51t] = turb_ref(T3t, T5t, P5t, g1, g2, f, Cp, gas_model);
    
%% Sección 8: entrada de la tobera

    T8t=T51t;
    P8t=P51t;
    
%% Sección 9: salida de la tobera

    [T9t, P9t, T9, P9, V9, M9, A9] = nozzle(T8t, P8t, P0, gamma,...
                                            Cp, Rg, G, f, gas_model);
%La tobera si quisiésemos hacer un análisis de actuaciones se podría
%complicar más poniendo 'if's en los que se comprobase para unas
%condiciones ambientes dadas, si existe bloqueo en la garganta, cómo es la
%presión de salida, etc.

%% Parámetros del motor

V0 = a0*M0;
T = G * (V9 - V0) + A9*(P9-P0) %El término de presiones será nulo. Más gral.
Isp = T/G % En m/s
Ce = G*f/T


    
