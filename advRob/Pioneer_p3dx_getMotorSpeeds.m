function [leftVelRadPerSec,rightVelRadPerSec,returnCode] = Pioneer_p3dx_getMotorSpeeds(connection)
%PIONEER_P3DX_GETMOTORSPEEDS get motor velocities in rad/sec 
% [leftMotorVel,rightMotorVel]=Pioneer_p3dx_setMotorSpeeds(connection)
[vel,~,returnCode]=coppelia_getStringPacked(connection,'Pioneer_p3dx_velocities');
leftVelRadPerSec=vel(1);
rightVelRadPerSec=vel(2);

end