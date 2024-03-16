function [connection] = coppelia_setup()
% COPPELIA_SETUP Simulation setup, will set the octave/matlab paths
% it define also the global variable 'isoctave'.
%
% ⚠
% **IMPORTANT**: Make sure to have the simulation scene advRob.ttt loaded in 
% CoppeliaSim!
%
    global isoctave;
    isoctave = isOctaveFcn();
        
    fileDir = fileparts(mfilename('fullpath')); % path to this m-file
    [libDir]=getLibDir(fileDir);
    addpath( libDir )
    % add the correct paths depending on the architecture
    if (isoctave)
      paths = fullfile(fileDir,'octave');
    else
      paths = fullfile(fileDir,'matlab');
    end
    
    addpath( paths );
        
    if (isoctave)
        connection.sim = remApiSetup(fullfile(libDir,'remApi.oct'));
        simxFinish(-1); % just in case, close all opened connections
    else
        connection.sim = remApi('remoteApi'); % using the prototype file (remoteApiProto.m)
        connection.sim.simxFinish(-1);
    end
    
end

function in = isOctaveFcn ()
    persistent inout;

    if isempty(inout),
        inout = exist('OCTAVE_VERSION','builtin') ~= 0;
    end
    in = inout;
end

function [libDir]=getLibDir(fileDir)
global isoctave;
if isoctave
  libDir = fullfile(fileDir, '..','lib','octave');
  if(strcmp(computer,'x86_64-pc-linux-gnu'))
      libDir = fullfile(libDir, 'linux');
  elseif(strcmp(computer,'i686-pc-linux-gnu') || strcmp(computer,'i586-pc-linux-gnu'))
      libDir = fullfile(libDir, 'linux');
  elseif(ispc())
      libDir = fullfile(libDir, 'win');
  elseif(ismac())
      libDir = fullfile(libDir, 'mac');
  else
      error('Not supported operation system detected');
  end
else
  libDir = [fileDir, '/../lib/matlab'];
  if(strcmp(computer,'GLNXA64'))
      libDir = fullfile(libDir, 'linux_x64');
  elseif(strcmp(computer,'GLNX8632'))
      libDir = fullfile(libDir, 'linux_x32');
  elseif(strcmp(computer,'PCWIN'))
      libDir = fullfile(libDir, 'win32');
  elseif(strcmp(computer,'PCWIN64'))
      libDir = fullfile(libDir, 'win64');
  elseif(strcmp(computer,'MACI64'))
      libDir = fullfile(libDir, 'mac');
  else
      error('Not supported operation system detected');
  end
end
end
