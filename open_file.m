function [fullFileName,theImage] =open_file()

% Have user browse for a file, from a specified "starting folder."
% For convenience in browsing, set a starting folder from which to browse.
startingFolder = 'C:\Users\Fast\Desktop\salmana3';
if ~exist(startingFolder, 'dir')
  % If that folder doesn't exist, just start in the current folder.
  startingFolder = pwd;
end
% Get the name of the file that the user wants to use.
defaultFileName = fullfile(startingFolder, '*.avi');
[baseFileName, folder] = uigetfile(defaultFileName, 'Select a file');
if baseFileName == 0


end
fullFileName = fullfile(folder, baseFileName);
theImage = VideoReader(fullFileName);
end