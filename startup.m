% Add paths
dir_ = fileparts(mfilename('fullpath'));
found_ = false;
for i = 1:3
    advRobDir_ = fullfile(dir_, 'advRob');
    if  exist(advRobDir_, 'file')
        addpath(advRobDir_);
        found_ = true;
        break;
    end
    dir_ = fileparts(dir_);
end

if not(found_)
  error('Could not find homework common folder!');
end
clear dir_ advRobDir_ found_;
