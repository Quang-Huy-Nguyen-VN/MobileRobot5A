function retunCode=coppelia_stop(connection)
%COPPELIA_STOP start simulation if not already stoped
% Same as clicking on the 'stop' icon in CoppeliaSim
global isoctave;
if ~isoctave
  retunCode=connection.sim.simxStopSimulation(connection.clientID,connection.sim.simx_opmode_oneshot_wait);
else
  retunCode=simxStopSimulation(connection.clientID,connection.sim.simx_opmode_oneshot_wait);
end
end


