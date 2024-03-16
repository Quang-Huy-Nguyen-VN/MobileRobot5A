function [x, y, theta] = Pioneer_p3dx_getTargetGhostPose(connection)   
%PIONEER_P3DX_GETTARGETGHOSTPOSE get robot pose (x,y,theta), where positions are in meter, 
%orientation in radian 
%
% [x, y, theta] = Pioneer_p3dx_getPose(connection)
 
  [pose,~,returnCode]=coppelia_getStringPacked(connection,'Pioneer_p3dx_targetGhostPose');
  x=pose(1);
  y=pose(2);
  theta=pose(3); % rad
end