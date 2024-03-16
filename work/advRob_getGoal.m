function [xg,yg,thetag] = advRob_getGoal(connection,mode)
% ADVROB_GETGOAL Set/Get target goal pose 
%
% [xg,yg,thetag] = advRob_getGoal(connection,mode)
%  - mode=0: fixed goal
%  - mode=1: use the 'target ghost' to define the goal in CoppeliaSim

if mode<1
  %fixed definition of the goal, 
  % feel free to adapt it
  xg=-50;
  yg=10;
  thetag=0;
else
  % use the ghost target:
  % Set the 'ghost target' visible
  Pioneer_p3dx_setTargetGhostVisible(connection,1);
  
  % Enable mouse navigation
  coppelia_setMouseNavigation(connection,1);
  % Select 'ghost target' in the simulation
  coppelia_selectObject(connection,1);
  input ("Move the ghost target in the simulation, and hit any key when done.");
  [xg, yg, thetag] = Pioneer_p3dx_getTargetGhostPose(connection);
  
  % Set the 'ghost target' invisible
  Pioneer_p3dx_setTargetGhostVisible(connection,0);
end
end
