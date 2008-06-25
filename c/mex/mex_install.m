function mex_install(mtexpath,mexoptions)
% compiles all mex files for use with MTEX

global mtex_path;

opwd = pwd; 
if nargin == 0, mtexpath = mtex_path;end
mexpath = [mtexpath,'/c/mex/'];
cd(mexpath)

places = {'S1Grid','S2Grid','SO3Grid','quaternion'};

if nargin < 2
  if strfind(computer,'64')
    mexoptions = '-largeArrayDims';
  else
    mexoptions = '-compatibleArrayDims';
  end
end

for p = 1:length(places)
  files = dir([mexpath places{p} '_*.c']);
  files = {files.name};
  for f = 1:length(files)
    if exist([mexpath,files{f}],'file')      
      disp(['>   compile ',files{f}]);
      if newer_version(7.3)
        mex(mexoptions,[mexpath,files{f}]);
      else
        mex([mexpath,files{f}]);
      end
    end
  end
%  try
%    movefile([mexpath,places{p},'*.mex*'],...
%      [mtexpath,'/geometry/@',places{p},'/private']);
%  catch
%    disp('There was an error while moving the mex files! Please move the files manualy')
%  end
end
cd(opwd);
