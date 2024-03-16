function coppelia_selectObject(connection,index)
% COPPELIA_SELECTOBJECT
% allows to select one specific object: 
%    * index=-1, no object is selected,
%    * index= 0, Pioneer_p3dx is selected, 
%    * index= 1, 'ghost target' is selected, 

	global isoctave;
    if ~isoctave
        connection.sim.simxSetIntegerSignal(connection.clientID,strcat('Pioneer_p3dx_reqSelection',num2str(connection.robotNb)),index,connection.sim.simx_opmode_oneshot);
    else
        simxSetIntegerSignal(connection.clientID,strcat('Pioneer_p3dx_reqSelection',num2str(connection.robotNb)),index,connection.sim.simx_opmode_oneshot);
    end
end