%% AdvRob Simulation practical work
% In order to run the simulation:
%   - Start coppeliaSim
%   - Load the scene scenes/advRob.ttt
%   - Hit the run button
%   - Start this script


global connection
% Simulation setup, will set the octave/matlab paths
[connection] = coppelia_setup();

% Open the connection with CoppeliaSim
connection = coppelia_openConnection(connection, 0);
% Start simulation if not already started
coppelia_start(connection);

% Initialize the robot

robot = Pioneer_p3dx_init(connection);
% Allows to handle ctrl-c...
cleanupObj = onCleanup(@cleanMeUp);

% controller parameters
parameters.dist_threshold= 0.25; % threshold distance to goal
parameters.angle_threshold = 0.1; % threshold orientation to goal
parameters.Krho = 0.2;  % to be defined
parameters.Kalpha = 1; % to be defined
parameters.Kbeta = -0.2; % to be defined

% Get the goal pose
[xg,yg,thetag] = advRob_getGoal(connection,1);

%% CONTROL LOOP.
% Change the MaxStep to increase/decrease the maximum number of iteration
% You can change the 'for-loop', in a 'while(~EndCond)', but the EndCond must properly defined
MaxStep=500;
EndCond = 0;

% Prepare storing 
x=zeros(1,MaxStep);
y=zeros(1,MaxStep);
theta=zeros(1,MaxStep);
vel=zeros(1,MaxStep);
omega=zeros(1,MaxStep);
LeftWheelVelocity=zeros(1,MaxStep);
RightWheelVelocity=zeros(1,MaxStep);

for step=1:MaxStep
  %Get robot pose  where positions are in meter, orientation in radian 
  [x(step), y(step), theta(step)] = Pioneer_p3dx_getPose(connection);
  dist_to_goal = sqrt((xg-x(step))^2+(yg-y(step))^2); 

  % Run control step
  [ vel(step), omega(step) ] = advRob_calculateControlOutput([x(step), y(step), theta(step)], [xg, yg, thetag], parameters);
  
  % Calculate robot wheel velocity
  [ LeftWheelVelocity(step), RightWheelVelocity(step) ] = advRob_calculateWheelSpeeds(vel(step), omega(step), robot);
  % Obstacle avoidance
  [ LeftWheelVelocity(step), RightWheelVelocity(step) ] = advRob_ObstacleAvoidance(connection,LeftWheelVelocity(step), RightWheelVelocity(step), robot);
  % Define the ending condition
  EndCond = dist_to_goal ;  % to be defined
  if EndCond <= 0.1
     break; %stop the loop
  end

  % Set  ROBOT WHEEL SPEEDS.
  Pioneer_p3dx_setMotorSpeeds(connection,LeftWheelVelocity(step), RightWheelVelocity(step));
end

% Stop the robot
Pioneer_p3dx_setMotorSpeeds(connection,0, 0);
if EndCond
  disp('sucessfully reach the goal!')
else
  warning('Robot doesn''t have reach the goal :( :', dist_to_goal)
end

% stop the simulation
coppelia_stop(connection);
% close the connection with CoppeliaSim
coppelia_closeConnection(connection);



% Example of plotting results
% here plot the linear velocity
Times=(1:MaxStep).*connection.dt;
figure(1);
clf; hold all; grid on;
plot(Times,vel);
xlabel('Times (sec)')
ylabel('Velocity (m/s)')

