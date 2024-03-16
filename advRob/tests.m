% Make sure to have the simulation scene advRob.ttt loaded in CoppeliaSim!
% before running this script
%
% In order to run the tests script:
%   - Start CoppeliaSim
%   - Load the scene madvRob.ttt
%   - Start this script

% Simulation setup, will set the octave/matlab paths
[connection] = coppelia_setup();

% the robot we want to interact with
robotNb = 0;

% Open the connection with CoppeliaSim
connection = coppelia_openConnection(connection, robotNb);
% Start simulation if not already started
coppelia_start(connection);

% Initialize the robot
robot = Pioneer_p3dx_init(connection);

%Get robot pose (x,y,theta), where positions are in meter, orientation in radian 
[x, y, theta] = Pioneer_p3dx_getPose(connection);
% set motor velocities in rad/sec 
Pioneer_p3dx_setMotorSpeeds(connection,pi,pi/2);
% get motor velocities in rad/sec
[leftVel, rightVel] = Pioneer_p3dx_getMotorSpeeds(connection);
pause(5)
Pioneer_p3dx_setMotorSpeeds(connection,0,0);

% get motor encoders
[leftEnc,rightEnc] = Pioneer_p3dx_getEncoders(connection);

% read ultrasound sensors data
[us] = Pioneer_p3dx_getUltraSoundSensors(connection);


% Set the 'ghost target' visible
Pioneer_p3dx_setTargetGhostVisible(connection,1);
% Get the 'ghost target' pose
[xg, yg, thetag] = Pioneer_p3dx_getTargetGhostPose(connection);


% Enable mouse navigation
coppelia_setMouseNavigation(connection,1);

% Select object in the simulation
coppelia_selectObject(connection,1);

% stop the simulation
coppelia_stop(connection);


% close the connection with CoppeliaSim
coppelia_closeConnection(connection);
