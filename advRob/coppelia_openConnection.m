function [connection] = coppelia_openConnection(connection, robotNb)
%COPPELIA_OPENCONNECTION Opens a remote connection to CoppeliaSim. Note that
%the CoppeliaSim simulation has to be running at this point, and coppelia_setup()
%function called.

	global isoctave;
  if (isempty(isoctave))
      gen_error('You have to call coppelia_setup() first');
  end

    connection.robotNb = robotNb;
    
     % to properly close the last opened connection if it wasn't closed:
    global lastConnectionId;
    if ~isempty(lastConnectionId)
        if (isoctave)
            simxFinish(lastConnectionId);
        else
            connection.sim.simxFinish(lastConnectionId);
        end
    end

    % 19997 is the port specified in remoteApiConnections.txt in the Coppelia
    % folder.
    % Additionally Coppelia opens port 19999 on simulation start in the advRob
    % script. You could also use that port here, but then simulation has to
    % be started manually before connecting through MATLAB.
    if (isoctave)
        connection.clientID=simxStart('127.0.0.1',19997,true,true,5000,5);
         [~,connection.dt]=simxGetFloatingParameter(connection.clientID,connection.sim.sim_floatparam_simulation_time_step,connection.sim.simx_opmode_oneshot_wait);        
    else
        connection.clientID=connection.sim.simxStart('127.0.0.1',19997,true,true,5000,5); [~,connection.dt]=connection.sim.simxGetFloatingParameter(connection.clientID,connection.sim.sim_floatparam_simulation_time_step,connection.sim.simx_opmode_oneshot_wait);
    end
    if (connection.clientID<=-1)
      gen_error('Could not open connection');
    else
      disp('Connected to CoppeliaSim remote API server');
    end
    lastConnectionId = connection.clientID;
end
