function [leftEnc, rightEnc,returnCode] = Pioneer_p3dx_getEncoders(connection)
%PIONEER_P3DX_GETENCODERS get motor velocities in rad/sec 
% [leftMotorVel,rightMotorVel]=Pioneer_p3dx_setMotorSpeeds(connection)
[enc,~,returnCode]=coppelia_getStringPacked(connection,'Pioneer_p3dx_encoders');
leftEnc=enc(1);  %rad
rightEnc=enc(2); %rad
end