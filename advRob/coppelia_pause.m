function coppelia_pause(connection)
    global isoctave;
    if ~isoctave;
        connection.sim.simxPauseSimulation(connection.clientID,connection.sim.simx_opmode_oneshot_wait);
    else
        simxPauseSimulation(connection.clientID,connection.sim.simx_opmode_oneshot_wait);
    end
end
