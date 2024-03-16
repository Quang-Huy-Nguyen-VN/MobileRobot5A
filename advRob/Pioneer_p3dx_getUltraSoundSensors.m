function [us,returnCode] = Pioneer_p3dx_getUltraSoundSensors(connection)
%PIONEER_P3DX_GETULTRASOUNDSENSORS get ultrasound sensory data (m)
%
% [us_data]=Pioneer_p3dx_setMotorSpeeds(connection) return a vector with the 16 
% ultrasound data
%
[us,~,returnCode]=coppelia_getStringPacked(connection,'Pioneer_p3dx_ultrasoundSensors');
end

