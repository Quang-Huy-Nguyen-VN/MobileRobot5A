function [ vel, omega ] = advRob_calculateControlOutput( robotPose, goalPose, parameters )
%ADVROB_CALCULATECONTROLOUTPUT This function computes the motor velocities for a 
% differential driven robot
% 
% [ vel, omega ] = advRob_calculateControlOutput( robotPose, goalPose, parameters ) 
% where robotPose contains the current robot position (x,y) and orientation (theta) 
% goalPose contains the goal robot position (xg,yg) and orientation (theta_g)
% and parameters should contains the control parameters.

%Comment/remove the following line when ready to define this function
%gen_error('advRob:unimplemented',...
 %         'Function advRob_calculateControlOutput is not implemented');

%TODO: calculate the velocities of the robot
deltax = goalPose(1) - robotPose(1);
deltay = goalPose(2) - robotPose(2);

direction = atan2(deltay,deltax);
% Calcul de l'erreur d'orientation
   errort = direction - robotPose(3);
% Appliquer le contrôle de l'orientation
   if errort > pi
       errort = errort - 2 * pi;
   elseif errort < -pi
       errort = errort + 2 * pi;
   end

vel = parameters.Krho * sqrt(deltax^2 + deltay^2);
omega = errort;
end
