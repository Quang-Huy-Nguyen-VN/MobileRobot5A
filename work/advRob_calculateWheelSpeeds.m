function [ LeftWheelVelocity, RightWheelVelocity ] = advRob_calculateWheelSpeeds(vel, omega, robot)
%ADVROB_CALCULATEWHEELSPEEDS This function computes the motor velocities for a differential driven robot
%
% See also Pioneer_p3dx_init()

%Comment/remove the following line when ready to define this function
%gen_error('advRob:unimplemented',...
      %    'Function advRob_calculateWheelSpeeds is not implemented');

%TODO: calculate the wheel velocities of the robot
LeftWheelVelocity = (vel - robot.interWheelDist*omega)/(robot.wheelDiameter/2);
RightWheelVelocity = (vel + robot.interWheelDist*omega)/(robot.wheelDiameter/2);

end
