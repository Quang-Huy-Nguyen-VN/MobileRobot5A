function returnCode=coppelia_start(connection)
%COPPELIA_START start simulation if not already started
% Same as clicking on the 'play' icon in CoppeliaSim
  
global isoctave;
if (isoctave)
    returnCode=simxStartSimulation(connection.clientID,connection.sim.simx_opmode_oneshot_wait);

    % make sure the scripts on the Coppelia side had the time to execute at least once
    % (e.g. to set the signals). So we simply send 3 dummy requests (effectively waiting a bit here):
    simxGetFloatSignal(connection.clientID,'',connection.sim.simx_opmode_oneshot_wait);
    simxGetFloatSignal(connection.clientID,'',connection.sim.simx_opmode_oneshot_wait);
    simxGetFloatSignal(connection.clientID,'',connection.sim.simx_opmode_oneshot_wait);
else
    returnCode=connection.sim.simxStartSimulation(connection.clientID,connection.sim.simx_opmode_oneshot_wait);
    connection.sim.simxGetFloatSignal(connection.clientID,'',connection.sim.simx_opmode_oneshot_wait);
    connection.sim.simxGetFloatSignal(connection.clientID,'',connection.sim.simx_opmode_oneshot_wait);
    connection.sim.simxGetFloatSignal(connection.clientID,'',connection.sim.simx_opmode_oneshot_wait);
end
end
