function returnCode=Pioneer_p3dx_setTargetGhostPose(connection,x,y,theta)
global isoctave;
global realRobot;
global ghostPose; %target pose for the real robot

if ~isoctave
  signalValue=connection.sim.simxPackFloats([x,y,gamma]);
  returnCode=connection.sim.simxSetStringSignal(connection.clientID,strcat('Pioneer_p3dx_reqTargetGhostPose',num2str(connection.robotNb)),signalValue,connection.sim.simx_opmode_oneshot);
else
  signalValue=simxPackFloats([x,y,gamma]);
  returnCode=simxSetStringSignal(connection.clientID,strcat('Pioneer_p3dx_reqTargetGhostPose',num2str(connection.robotNb)),signalValue,connection.sim.simx_opmode_oneshot);
end
end