function [minD, obstacle_pose]=advRob_getObstaclesFromSonars(connection,robot)
% getObstaclesFromSonars  get the shortest obstacle from US data 
% 
% [minD, obstacle_pose]=advRob_getObstaclesFromSonars(connection,robot) 
% - mindD: should be the shortest distance perceived by the  sonars.
% - obstacle_pose: should be the position of the closest obstacle in the
%   robot frame


% read ultrasound sensors data
[us] = Pioneer_p3dx_getUltraSoundSensors(connection);
% get the shortest distance perceived by the sonar
[minD,minIdx]=min(us);

%TODO: calculate the relative position of the closest obstacle in the robot frame

%Comment/remove the following line when ready to define this function
gen_error('advRob:unimplemented',...
          'Function advRob_getObstaclesFromSonars is not implemented')

% Tips, the position and orientation of each ultrasound are stored in the robot variable:
% For instance, for the US1:
% pos_US1=robot.UltraSounds(1).position ;   % (x,y,z) position in the robot frame
% ori_US1=robot.UltraSounds(1).orientation; % the Euler angles (alpha, beta and gamma)

obstacle_pose=[];

end
