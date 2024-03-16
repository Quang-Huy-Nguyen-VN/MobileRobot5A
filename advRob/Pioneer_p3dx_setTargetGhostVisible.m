function returnCode=Pioneer_p3dx_setTargetGhostVisible(connection,visible)
global isoctave;
  if ~isoctave
      returnCode=connection.sim.simxSetIntegerSignal(connection.clientID,strcat('Pioneer_p3dx_reqTargetGhostVisibility',num2str(connection.robotNb)),visible,connection.sim.simx_opmode_oneshot);
  else
      returnCode=simxSetIntegerSignal(connection.clientID,strcat('Pioneer_p3dx_reqTargetGhostVisibility',num2str(connection.robotNb)),visible,connection.sim.simx_opmode_oneshot);
  end
end