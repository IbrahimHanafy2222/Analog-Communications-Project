clc;
clear;
close all;
% DSB-QAM Part A 

% Sampling Parameters
fs = 1*10^5;           % Sampling frequency (100 kHz)
ts = 1/fs;             % Sampling period Inverse Of Freq
T=2*10^-3;
t = 0:ts:T;            % Time vector (0 to 2 ms)

m1_frequency = 1/(1*10^-3);              
m1 = sawtooth(-2*pi*m1_frequency*t+pi,1);  

m2 = zeros(size(t));
m2(t <= 0.5e-3) = 1;
m2(t > 0.5e-3 & t <= 1e-3) = 0.5;
m2(t > 1e-3 & t <= 1.5e-3) = -0.5;
m2(t > 1.5e-3) = -1;

% Plot m1(t) Fig.1
figure;
plot(t*1000, m1, 'b', 'LineWidth', 1);
title('Fig. 1: Information Signal m_1(t)');
xlabel('Time (ms)');
ylabel('m_1(t)');
grid on;
yticks([-1 -0.5 0 0.5 1]);
savefig("m1(t)");

% Plot m2(t) Fig.2
figure;
plot(t*1000, m2, 'r', 'LineWidth', 1);
title('Fig. 2: Information Signal m_2(t)');
xlabel('Time (ms)');
ylabel('m_2(t)');
grid on;
yticks([-1 -0.5 0 0.5 1]);
xticks([0 0.5 1 1.5 2])
savefig("m2(t)");

%Checkpoint 1 Part 1

%Now we will define the carrier signal
Carrier_frequency=5*10^3;
Carrier1=5*cos(2*pi*Carrier_frequency*t);
Carrier2=5*sin(2*pi*Carrier_frequency*t);

S_t=Carrier1.*m1+Carrier2.*m2;

figure;
plot(t*1000, S_t, 'r', 'LineWidth', 1);
title('Fig. 3: Modulated Signal s(t)');
xlabel('Time (ms)');
ylabel('s(t)');
grid on;
savefig("s(t)");
%Checkpoint 2 Part 2

%Now We will implement the QAM Reciever;  

Demodulated_m1A=S_t.*Carrier1;
Demodulated_m2A=S_t.*Carrier2;

cutoff_Frequency=5000;
% Apply LPF
Demodulated_m1_1A = lowpass(Demodulated_m1A,cutoff_Frequency,5*fs); 
Demodulated_m2_2A = lowpass(Demodulated_m2A,cutoff_Frequency,5*fs);

Demodulated_m1_1A = 2*Demodulated_m1_1A / (5^2); 
Demodulated_m2_2A = 2*Demodulated_m2_2A / (5^2);

figure(Name="The Original Carrier");
subplot(2,1,1);
plot(t*1000, Demodulated_m1_1A, 'b', 'LineWidth', 1);
title('Fig. 4: DeModulated Signal m_1(t)');
xlabel('Time (ms)');
ylabel('m1(t)');
grid on;
subplot(2,1,2);
plot(t*1000, Demodulated_m2_2A, 'r', 'LineWidth', 1);
title('Fig. 5: DeModulated Signal m_2(t)');
xlabel('Time (ms)');
ylabel('m2(t)');
grid on;
savefig("Original");
% Checkpoint 3 Demodulated The 2 Signals

Demodulated_m1_B=S_t.*cos(2*pi*Carrier_frequency*t+pi/3);
Demodulated_m2_B=S_t.*sin(2*pi*Carrier_frequency*t+pi/3);

cutoff_Frequency=5000;
% Apply LPF
Demodulated_m1_1B = lowpass(Demodulated_m1_B,cutoff_Frequency,5*fs)/3; 
Demodulated_m2_2B = lowpass(Demodulated_m2_B,cutoff_Frequency,5*fs)/2.5;



figure(Name="The Original Carrier +pi/3");
subplot(2,1,1);
plot(t*1000, Demodulated_m2_2B, 'b', 'LineWidth', 1);
title('Fig. 6: DeModulated Signal m_1(t)');
xlabel('Time (ms)');
ylabel('m1(t)');
grid on;

subplot(2,1,2);
plot(t*1000, Demodulated_m1_1B, 'r', 'LineWidth', 1);
title('Fig. 7: DeModulated Signal m_2(t)');
xlabel('Time (ms)');
ylabel('m2(t)');
grid on;
savefig("2");
%Last Checkpoint Demodulating With Ansynchronous Reciever


Demodulated_m1_C=S_t.*cos(2.02*pi*Carrier_frequency*t);
Demodulated_m2_C=S_t.*sin(2.02*pi*Carrier_frequency*t);

cutoff_Frequency=5000;
% Apply LPF
Demodulated_m1_1C = lowpass(Demodulated_m1_C,cutoff_Frequency,5*fs); 
Demodulated_m2_2C = lowpass(Demodulated_m2_C,cutoff_Frequency,5*fs);

Demodulated_m1_11C = lowpass(Demodulated_m1_1C,cutoff_Frequency,5*fs); 
Demodulated_m2_22C = lowpass(Demodulated_m2_2C,cutoff_Frequency,5*fs);

figure(Name="The Original Carrier with different w");
subplot(2,1,1);
plot(t*1000, Demodulated_m1_11C, 'b', 'LineWidth', 1);
title('Fig. 8: DeModulated Signal m_1(t)');
xlabel('Time (ms)');
ylabel('m1(t)');
grid on;

subplot(2,1,2); 
plot(t*1000, Demodulated_m2_22C, 'r', 'LineWidth', 1);
title('Fig. 9: DeModulated Signal m_2(t)');
xlabel('Time (ms)');
ylabel('m2(t)');
grid on;
savefig("3");
