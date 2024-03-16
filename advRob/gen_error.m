function gen_error(id,msg)
%GEN_ERROR Display an error message and stop m-file execution

if nargin==1
   msg=id; 
   id = 'advRob:RemoteApiError';
end

global isoctave;
if (isempty(isoctave))
  if  exist('OCTAVE_VERSION','builtin') ~= 0
    error('advRob:RemoteApiError','You have to call coppelia_setup() first');
  else
    err = MException('advRob:RemoteApiError', 'You have to call coppelia_setup() first');
    throw(err);
   end
end
if isoctave
  error(id, msg);
else
  err = MException(id, msg);
  throw(err);
end
