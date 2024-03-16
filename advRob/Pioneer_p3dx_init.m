function [robot] = Pioneer_p3dx_init(connection)
%PIONEER_P3DX_INIT initialize the robot and get some of its parameters
%
% Pioneer 3-DX is a small lightweight two-wheel two-motor differential
% drive robot ideal for indoor laboratory or classroom use. 
% The robot comes with front and rear SONAR (16), one battery, wheel encoders
% 
% [robot] = Pioneer_p3dx_init(connection);
% 
% return
%  - robot.bodyDiameter: (max) robot diameter
%  - robot.wheelDiameter: the wheel diameter
%  - robot.interWheelDist: the distance between the left and right wheels
%  - robot.nbUS: the number of sonars
%  - robot.maxUSdist: the maximum distance perceived by sonars
%  - robot.UltraSounds a 16-vectors containing information about sonars
%     The position and orientation of each SONAR are stored in the robot variable nds
%     For instance, for the US1:
%     pos_US1=robot.UltraSounds(1).position ;   % (x,y,z) position in the robot frame
%     ori_US1=robot.UltraSounds(1).orientation; % the Euler angles (alpha, beta and gamma)



global isoctave;

[robot.handler,returnCode] = coppelia_getObject(connection,'Pioneer_p3dx');  
if (returnCode~=connection.sim.simx_error_noerror)
  error('advRob:RemoteApiError', 'simxGetFloatSignal ''robotHandler'' failed');
end

robot.nbUS=16;
if isoctave
  [returnCode,robot.maxUSdist]=simxGetFloatSignal(connection.clientID,strcat('Pioneer_p3dx_maxUSdist',num2str(connection.robotNb)),connection.sim.simx_opmode_oneshot_wait);
  if (returnCode~=connection.sim.simx_error_noerror)
    error('advRob:RemoteApiError', 'simxGetFloatSignal ''maxUSdist'' failed');
  end
else
  [returnCode,robot.maxUSdist]=connection.sim.simxGetFloatSignal(connection.clientID,strcat('Pioneer_p3dx_maxUSdist',num2str(connection.robotNb)),connection.sim.simx_opmode_oneshot_wait);
  if (returnCode~=connection.sim.simx_error_noerror)
    err = MException('sim:RemoteApiError', 'simxGetFloatSignal  ''maxUSdist'' failed');
    throw(err);
  end
end
  
for idx=1:robot.nbUS
  [usH] = coppelia_getObject(connection,sprintf('Pioneer_p3dx_ultrasonicSensor%d',idx));
  if isoctave
    [~,ori]=simxGetObjectOrientation(connection.clientID,usH,robot.handler,connection.sim.simx_opmode_oneshot_wait);
    [~,pos]=simxGetObjectPosition(connection.clientID,usH,robot.handler,connection.sim.simx_opmode_oneshot_wait);
  else
    [~,ori]=connection.sim.simxGetObjectOrientation(connection.clientID,usH,robot.handler,connection.sim.simx_opmode_oneshot_wait);
    [~,pos]=connection.sim.simxGetObjectPosition(connection.clientID,usH,robot.handler,connection.sim.simx_opmode_oneshot_wait);
  end
  robot.UltraSounds(idx).H=usH;
  robot.UltraSounds(idx).position=pos;
  robot.UltraSounds(idx).orientation=ori;
end



if ~isoctave
  %is Matlab
  
  [returnCode,robot.bodyDiameter]=connection.sim.simxGetFloatSignal(connection.clientID,strcat('Pioneer_p3dx_bodyDiameter',num2str(connection.robotNb)),connection.sim.simx_opmode_oneshot_wait);
  if (returnCode~=connection.sim.simx_error_noerror)
    err = MException('sim:RemoteApiError', 'simxGetFloatSignal  ''bodyDiameter'' failed');
    throw(err);
  end
  [returnCode,robot.wheelDiameter]=connection.sim.simxGetFloatSignal(connection.clientID,strcat('Pioneer_p3dx_wheelDiameter',num2str(connection.robotNb)),connection.sim.simx_opmode_oneshot_wait);
  if (returnCode~=connection.sim.simx_error_noerror)
    err = MException('sim:RemoteApiError', 'simxGetFloatSignal ''wheelDiameter'' failed');
    throw(err);
  end
  [returnCode,robot.interWheelDist]=connection.sim.simxGetFloatSignal(connection.clientID,strcat('Pioneer_p3dx_interWheelDist',num2str(connection.robotNb)),connection.sim.simx_opmode_oneshot_wait);
  if (returnCode~=connection.sim.simx_error_noerror)
    err = MException('sim:RemoteApiError', 'simxGetFloatSignal ''interWheelDist'' failed');
    throw(err);
  end
  [returnCode,robot.maxWheelVel]=connection.sim.simxGetFloatSignal(connection.clientID,strcat('Pioneer_p3dx_maxWheelVel',num2str(connection.robotNb)),connection.sim.simx_opmode_oneshot_wait);
  if (returnCode~=connection.sim.simx_error_noerror)
    err = MException('sim:RemoteApiError', 'simxGetFloatSignal ''maxWheelVel'' failed');
    throw(err);
  end
  
else
  %is Octave
  [returnCode,robot.bodyDiameter]=simxGetFloatSignal(connection.clientID,strcat('Pioneer_p3dx_bodyDiameter',num2str(connection.robotNb)),connection.sim.simx_opmode_oneshot_wait);
  if (returnCode~=connection.sim.simx_error_noerror)
    error('advRob:RemoteApiError', 'simxGetFloatSignal ''bodyDiameter'' failed');
  end
  [returnCode,robot.wheelDiameter]=simxGetFloatSignal(connection.clientID,strcat('Pioneer_p3dx_wheelDiameter',num2str(connection.robotNb)),connection.sim.simx_opmode_oneshot_wait);
  if (returnCode~=connection.sim.simx_error_noerror)
    error('advRob:RemoteApiError', 'simxGetFloatSignal ''wheelDiameter'' failed');
  end
  [returnCode,robot.interWheelDist]=simxGetFloatSignal(connection.clientID,strcat('Pioneer_p3dx_interWheelDist',num2str(connection.robotNb)),connection.sim.simx_opmode_oneshot_wait);
  if (returnCode~=connection.sim.simx_error_noerror)
    error('advRob:RemoteApiError', 'simxGetFloatSignal ''interWheelDist'' failed');
  end
  [returnCode,robot.maxWheelVel]=simxGetFloatSignal(connection.clientID,strcat('Pioneer_p3dx_maxWheelVel',num2str(connection.robotNb)),connection.sim.simx_opmode_oneshot_wait);
  if (returnCode~=connection.sim.simx_error_noerror)
    error('advRob:RemoteApiError', 'simxGetFloatSignal ''maxWheelVel'' failed');
  end
end
end



