%% Smart PID-Based Temperature Control Simulation
clc; clear; close all;

%% --------------------------- Test Cases -----------------------------
% Define multiple plant models (e.g., thermal system, motor)
plants = {
    tf([1],[1 10 20]),     % Plant 1: Second-order system
    tf([5],[1 5 6]),       % Plant 2: Second-order, different dynamics
    tf([2],[1 4 3])        % Plant 3: Another example
};

plant_names = {'Plant 1', 'Plant 2', 'Plant 3'};

% Define PID gain sets to test
PID_gains = [
    100  50  20;   % Kp Ki Kd
    200 100  50;
    350 300  50
];

gain_names = {'Gains Set 1','Gains Set 2','Gains Set 3'};

%% --------------------------- Simulation -----------------------------
t = 0:0.01:5;  % time vector

for p = 1:length(plants)
    figure('Name', plant_names{p}, 'NumberTitle','off'); hold on; grid on;
    title([plant_names{p} ' - Step Response for Multiple PID Gains']);
    
    for g = 1:size(PID_gains,1)
        Kp = PID_gains(g,1);
        Ki = PID_gains(g,2);
        Kd = PID_gains(g,3);
        
        controller = pid(Kp, Ki, Kd);           % PID controller
        closedLoop = feedback(controller*plants{p},1); % Closed-loop system
        
        [y, ~] = step(closedLoop, t);           % Step response
        plot(t, y, 'LineWidth', 2);             % Plot response
        
        % Compute performance metrics
        info = stepinfo(closedLoop);
        fprintf('%s - %s:\n', plant_names{p}, gain_names{g});
        fprintf('  RiseTime: %.3f s, SettlingTime: %.3f s, Overshoot: %.2f%%, SteadyState: %.2f\n',...
                info.RiseTime, info.SettlingTime, info.Overshoot, y(end));
    end
    
    xlabel('Time (s)');
    ylabel('Temperature / Output');
    legend(gain_names,'Location','best');
end

%% --------------------------- Error Analysis -------------------------
for p = 1:length(plants)
    figure('Name', ['Error Signal - ' plant_names{p}], 'NumberTitle','off'); hold on; grid on;
    
    for g = 1:size(PID_gains,1)
        Kp = PID_gains(g,1);
        Ki = PID_gains(g,2);
        Kd = PID_gains(g,3);
        
        controller = pid(Kp, Ki, Kd);
        closedLoop = feedback(controller*plants{p},1);
        [y, ~] = step(closedLoop, t);
        r = ones(size(t));  % desired step input
        error = r - y;
        plot(t, error, 'LineWidth', 2);
    end
    
    xlabel('Time (s)');
    ylabel('Error');
    title(['Error Signals - ' plant_names{p}]);
    legend(gain_names,'Location','best');
end

%% --------------------------- Comparison of P, PI, PD, PID -------------------------
% Using Plant 1 as example
plant = plants{1};
figure('Name','Controller Comparison - Plant 1','NumberTitle','off'); hold on; grid on;

controllers = {pid(350,0,0), pid(350,300,0), pid(350,0,50), pid(350,300,50)};
ctrl_names = {'P','PI','PD','PID'};

for k = 1:length(controllers)
    closedLoop = feedback(controllers{k}*plant,1);
    step(closedLoop, t);
end

title('P vs PI vs PD vs PID Controller - Step Response');
xlabel('Time (s)'); ylabel('Output');
legend(ctrl_names,'Location','best');
