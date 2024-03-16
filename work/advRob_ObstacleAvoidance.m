function [ LeftWheelVelocity, RightWheelVelocity ] = advRob_obstacleAvoidance(connection,LeftWheelVelocity0, RightWheelVelocity0, robot)
%ADVROB_OBSTACLEAVOIDANCE This function computes the motor velocities to avoid obstacle in the vicinity
% 

% Get ultrasound sensory data 
[us] = Pioneer_p3dx_getUltraSoundSensors(connection);
us(isinf(us))=robot.maxUSdist;

%Define the Braitenberg weighted matrix 
W= zeros(2,robot.nbUS); 

%TODO: calculate the wheel velocities of the robot
% Nombre de capteurs ultrasonores
numSensors = length(us);

% Initialisation des vitesses des roues en fonction des vitesses initiales
LeftWheelVelocity = LeftWheelVelocity0;
RightWheelVelocity = RightWheelVelocity0;

% Paramètres d'évitement d'obstacles
avoidanceGain = 3; % Facteur de gain pour l'évitement d'obstacles
minDistance = 0.5;   % Distance minimale pour éviter les obstacles
maxSensorValue = max(us); % Valeur maximale possible des capteurs

for i = 1:numSensors
   sensorValue = us(i);   
   if sensorValue < minDistance
       sensorWeight = avoidanceGain * (1 - (1 / maxSensorValue) * sensorValue);
       LeftWheelVelocity = LeftWheelVelocity0 - sensorWeight; 
       RightWheelVelocity = RightWheelVelocity0 - sensorWeight;
   end
       
end
   
% Assurez-vous que les vitesses finales sont dans la plage valide
LeftWheelVelocity = max(0, min(10, LeftWheelVelocity));
RightWheelVelocity = max(0, min(10, RightWheelVelocity));
end
