function coppelia_closeConnection(connection)
%COPPELIA_CLOSECONNECTION Ends the communication with CoppeliaSim.
% This should be the very last remote API function called on the client side.
global isoctave;
if ~isoctave
    connection.sim.simxFinish(connection.clientID);
else
    simxFinish(connection.clientID);
end
end
