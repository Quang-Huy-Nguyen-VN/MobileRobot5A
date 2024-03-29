function coppelia_setMouseNavigation(connection,index)
% COPPELIA_SETMOUSENAVIGATION
% allows to set the mouse navigation mode: 0=camera pan, 1=object shift, 2=object rotate
global isoctave;
  if ~isoctave
      connection.sim.simxSetIntegerSignal(connection.clientID,strcat('Pioneer_p3dx_reqNavigation',num2str(connection.robotNb)),index,connection.sim.simx_opmode_oneshot);
  else
      simxSetIntegerSignal(connection.clientID,strcat('Pioneer_p3dx_reqNavigation',num2str(connection.robotNb)),index,connection.sim.simx_opmode_oneshot);
  end
end