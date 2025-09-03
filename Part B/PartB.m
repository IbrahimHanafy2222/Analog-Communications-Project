clear ;
close all;
clc;

[~, ~, m2] = generate_message_signals();
%%%%%%%%%%%%%%%%%%%%%%%Checkpoint 1 (Plotting m1 and m2)%%%%%%%%%%%%%%%%%%%%%%%


[t, m1] = generate_m1(); 
kp_values = [0.05, 1, 5, 10]; % Different k_p values

% Loop through each kp and plot the modulated signal
for i = 1:length(kp_values)
    kp = kp_values(i);
    s1 = cos(2*pi*1e4*t + kp * m1); % Phase modulation with fc = 10kHz, Ac = 1
    figure;
    plot(t*1e3, s1);
    title(['Phase Modulated Signal s_1(t) with k_p = ', num2str(kp)]);
    xlabel('Time (msec)'); ylabel('s_1(t)'); grid on;
    saveas(gcf,['phase_modulation_fig_' num2str(i) ]);
end

%%%%%%%%%%%%%%%%%%%%%%%Chechkpoint 2 Part 2 and 3 Finished%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
fs = 1e6;              % Sampling frequency
T = 2e-3;              % Duration
t = 0:1/fs:T;          % Time vector
fc = 10e3;             % Carrier frequency (Hz)
Ac = 1;                % Amplitude
kf = 1000;             % Frequency deviation constant

% Define m2(t) as piecewise constant

m2 = zeros(size(t));
m2(t < 0.5e-3) = 1;
m2(t >= 0.5e-3 & t < 1e-3) = 0.5;
m2(t >= 1e-3 & t < 1.5e-3) = -0.5;
m2(t >= 1.5e-3) = -1;

% integral from ∞ to t = negative integral from t to end
int_m2 = -cumsum(flip(m2)) / fs;
int_m2 = flip(int_m2);  % Flip back to match t

% Generate FM signal s2(t)
s2 = Ac * cos(2*pi*fc*t + kf * int_m2);

% Plot
figure;
plot(t*1e3, s2, 'LineWidth', 1.2);
xlabel('Time (msec)');
ylabel('s_2(t)');
title('FM Signal s_2(t) with Integration from ∞ to t and K_f = 1000');
grid on;
saveas(gcf,['Part4.jpg']);

%%%%%%%%%%%%%%%%%%%%%%% Last Checkpoint Part 5 Done%%%%%%%%%%%%%%%%%%%%%%%

% Generate message signal
dt = t(2) - t(1);    % Time step
fc = 10e3;           % Carrier frequency
Ac = 1;              % Amplitude
kf2 = 2000;           % Frequency sensitivity

% Compute the integral from t to T (then multiply by -1)
% Flip the array and integrate forward
m1_reversed = flip(m1);
int_tail = cumtrapz(t, m1_reversed);
m1_tail_integral = flip(int_tail);  % So now we have int_t^T

% Multiply by -1 to get int_inf^t approximation
m1_integrated = -m1_tail_integral;

% Generate FM signal
s3 = Ac * cos(2*pi*fc*t + kf2 * m1_integrated);

% Plot
figure;
plot(t*1e3, s3);
title('FM Signal s_3(t) with Integration from ∞ to t (Approximated)');
xlabel('Time (msec)');
ylabel('s_3(t)');
grid on;
saveas(gcf,['Part5.jpg']);


function [t, m1, m2] = generate_message_signals()
    fs = 1e6;
    T = 2e-3;
    t = 0:1/fs:T;
    m1 = -sawtooth(2*pi*1000*t + pi);
    % Create m2(t) as a piecewise constant signal
    m2 = zeros(size(t));
    m2(t < 0.5e-3) = 1;
    m2(t >= 0.5e-3 & t < 1e-3) = 0.5;
    m2(t >= 1e-3 & t < 1.5e-3) = -0.5;
    m2(t >= 1.5e-3) = -1;

    % Plot m1
    figure;
    plot(t*1e3, m1, 'b');
    title('Fig. 1: Information signal m1(t)');
    xlabel('Time (msec)'); ylabel('m1(t)'); grid on;

    % Plot m2
    figure;
    plot(t*1e3, m2, 'LineWidth', 1.5);
    xlabel('Time (msec)');
    ylabel('m_2(t)');
    title('Fig. 2: Information signal m_2(t)');
    grid on;
end

%% Function: Generate m1 
function [t, m1] = generate_m1()
    fs = 1e6;          % Sampling frequency
    T = 2e-3;          % Total time (2 ms)
    t = 0:1/fs:T;      % Time vector
    m1 = -sawtooth(2*pi*1000*t + pi);  % m1 from 0 to 1 to -1
end
