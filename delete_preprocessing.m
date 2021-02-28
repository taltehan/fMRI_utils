function delete_preprocessing(dir_path)
% Delete files after preprocessing
% Keep only the original nii's and the smoothed ones
%   the relative or full path to the nii dir is required

delete(fullfile(dir_path, 'a20*.nii')); % slice time correction
delete(fullfile(dir_path,'ra20*.nii')); % realign
delete(fullfile(dir_path,'rra20*.nii')) % coregister
delete(fullfile(dir_path,'wrra20*.nii')) % normalize

end

