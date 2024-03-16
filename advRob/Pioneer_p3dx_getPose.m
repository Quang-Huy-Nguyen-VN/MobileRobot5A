function [x, y, theta, returnCode] = Pioneer_p3dx_getPose(connection)
%PIONEER_P3DX_GETPOSE get robot pose (x,y,theta), where positions are in meter, 
%orientation in radian 
%
% [x, y, theta] = Pioneer_p3dx_getPose(connection)

[pose,~,returnCode]=coppelia_getStringPacked(connection,'Pioneer_p3dx_pose');
x=pose(1);
y=pose(2);
theta=pose(3); % rad
end