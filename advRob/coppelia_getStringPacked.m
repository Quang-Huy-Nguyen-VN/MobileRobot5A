function [data,packed,returnCode]=coppelia_getStringPacked(connection,sigName)
  
global isoctave;
  
if ~isoctave
  [ returnCode,packed]=connection.sim.simxGetStringSignal(connection.clientID,strcat(sigName,num2str(connection.robotNb)),connection.sim.simx_opmode_oneshot);
  if (returnCode~=connection.sim.simx_error_noerror)
    [ returnCode,packed]=connection.sim.simxGetStringSignal(connection.clientID,strcat(sigName,num2str(connection.robotNb)),connection.sim.simx_opmode_buffer);
    if (returnCode~=connection.sim.simx_error_noerror)
      [ returnCode,packed]=connection.sim.simxGetStringSignal(connection.clientID,strcat(sigName,num2str(connection.robotNb)),connection.sim.simx_opmode_blocking);
      if (returnCode~=connection.sim.simx_error_noerror)
        err = MException('advRob:RemoteApiError', sprintf('simxGetStringSignal ''%s'' failed',sigName));
        throw(err);
      end
    end
  end
  if(isempty(packed))
      err = MException('advRob:RemoteApiError', 'Empty packed returned');
      throw(err);
  end
  data=connection.sim.simxUnpackFloats(packed);
else
  [ returnCode,packed]=simxGetStringSignal(connection.clientID,strcat(sigName,num2str(connection.robotNb)),connection.sim.simx_opmode_oneshot);
  if (returnCode~=connection.sim.simx_error_noerror)
    [ returnCode,packed]=simxGetStringSignal(connection.clientID,strcat(sigName,num2str(connection.robotNb)),connection.sim.simx_opmode_buffer);
    if (returnCode~=connection.sim.simx_error_noerror)
      [ returnCode,packed]=simxGetStringSignal(connection.clientID,strcat(sigName,num2str(connection.robotNb)),connection.sim.simx_opmode_blocking);
      if (returnCode~=connection.sim.simx_error_noerror)
        error('advRob:RemoteApiError',  sprintf('simxGetStringSignal ''%s'' failed',sigName));%#ok
      end
    end
  end
  if(isempty(packed))
      error('advRob:RemoteApiError','Empty packed returned');
  end
  data=simxUnpackFloats(packed);
end
end
