function [h,returnCode] = coppelia_getObject(connection,objName)
global isoctave;
if ~isoctave
  if (connection.robotNb==0)
      [returnCode,h]=connection.sim.simxGetObjectHandle(connection.clientID,objName,connection.sim.simx_opmode_oneshot_wait);
  else
      [returnCode,h]=connection.sim.simxGetObjectHandle(connection.clientID,strcat(objName,num2str(connection.robotNb-1)),connection.sim.simx_opmode_oneshot_wait);
  end
  if (returnCode~=connection.sim.simx_error_noerror)
      err = MException('advRob:RemoteApiError', sprintf('simxGetObjectHandle ''%s'' failed',objName));
      throw(err);
  end
else
  if (connection.robotNb==0)
      [returnCode,h]=simxGetObjectHandle(connection.clientID,objName,connection.sim.simx_opmode_oneshot_wait);
  else
      [returnCode,h]=simxGetObjectHandle(connection.clientID,strcat(objName,num2str(connection.robotNb-1)),connection.sim.simx_opmode_oneshot_wait);
  end
  if (returnCode~=connection.sim.simx_error_noerror)
      error('advRob:RemoteApiError',  sprintf('simxGetObjectHandle ''%s'' failed',objName));
  end
end
end
