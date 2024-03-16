function cleanMeUp()
% CLEANMEUP function called when it ctrl-c
%
  global connection
  
  % Stop the robot...
  Pioneer_p3dx_setMotorSpeeds(connection,0, 0);
  
  % You may additional stuff here...
end
