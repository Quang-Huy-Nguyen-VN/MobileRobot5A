function returnCode=Pioneer_p3dx_setMotorSpeeds(connection,leftInRadPerSec,rightInRadPerSec)
%PIONEER_P3DX_SETMOTORSPEEDS set motor velocities in rad/sec 
% Pioneer_p3dx_setMotorSpeeds(connection,leftMotorVel,rightMotorVel)
%
global isoctave;

if ~isoctave
  signalValue=connection.sim.simxPackFloats([leftInRadPerSec,rightInRadPerSec]);
  returnCode=connection.sim.simxSetStringSignal(connection.clientID,strcat('Pioneer_p3dx_reqVelocities',num2str(connection.robotNb)),signalValue,connection.sim.simx_opmode_oneshot);
else
  signalValue=simxPackFloats([leftInRadPerSec,rightInRadPerSec]);
  returnCode=simxSetStringSignal(connection.clientID,strcat('Pioneer_p3dx_reqVelocities',num2str(connection.robotNb)),signalValue,connection.sim.simx_opmode_oneshot);
end
end