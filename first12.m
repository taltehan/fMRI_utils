function first12(participant_dir)
%Creates 'first12' directory and moves the first 12 scans

original_dir = pwd;
cd(participant_dir);

% first 12 file names
first_str = {'*'};
second_str = cellstr(compose('%03.f', 1:12));
third_str = {'.nii'};
file_names = strcat(first_str, second_str, third_str);

path2experiment = fullfile('02_functional', '02_nifti');
run_dirs = dir(fullfile(path2experiment, '0*.*', '0*.*'));
% create a 'first12' dir in each run's directory
for i = 1:length(run_dirs)
    path2scans = fullfile(run_dirs(i).folder, run_dirs(i).name);
    path2first12 = fullfile(path2scans, 'first12');
    mkdir(path2first12);
    % move the first 12 files to the new directory
    for j = 1:length(file_names)
        movefile(fullfile(path2scans, file_names{j}), path2first12);
    end
end

cd(original_dir); % return to original dir

end

