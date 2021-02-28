function preprocessing_single_subject(subject_dir)

% List of open inputs
% Slice Timing: Session - cfg_files
% Coregister: Estimate & Reslice: Reference Image - cfg_files
% Normalise: Estimate & Write: Image to Align - cfg_files

fprintf('#######\nALL Exps\n#######\n');
% Choose the main directory of the subject
% subject_dir = uigetdir([], 'choose subject''s dir');
% A dir containing all experiments
experiments_path = fullfile(subject_dir, '02_functional', '02_nifti');
experiments_dirs = dir(experiments_path);
% The name of each experiment's directory:
experiments_dirs = experiments_dirs(3:end); %experiments_dirs(3:end)
nii_dirs = {};
paths_for_deletion = {};
for exp = 1:length(experiments_dirs)
    curr_experiment = experiments_dirs(exp).name;
    % a dir containing all runs
    runs = dir(fullfile(experiments_path, curr_experiment));
    runs = runs(3:end); % runs(3:end)
    for run = 1:length(runs)
        curr_run = runs(run).name;
        nii_path = fullfile(experiments_path, curr_experiment, curr_run);
        paths_for_deletion{end+1} = nii_path;
        nii_dir = dir(fullfile(nii_path, '*.nii'));
        if ~isempty(nii_dir)
            nii_names = extractfield(nii_dir, 'name');
            nii_files = fullfile(nii_path, nii_names);
            % Make sure the cell is transposed:
            nii_dirs{end+1} = nii_files';
        end
    end
end

nrun = length(nii_dirs); % enter the number of runs here
% jobfile = {'C:\Users\Tal\Dropbox\Documents\SI_MRI_analysis\preprocessing_job.m'};
jobfile = {'preprocessing_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(3, nrun);
anat_dir = fullfile(subject_dir, '02_functional');
anat_file = dir(fullfile(anat_dir, 'anat*.nii'));
anat_path = fullfile(anat_dir, anat_file.name);

for crun = 1:nrun
    inputs{1, crun} = nii_dirs{crun}; % Slice Timing: Session - cfg_files
    inputs{2, crun} = {anat_path}; % Coregister: Estimate & Reslice: Reference Image - cfg_files
    inputs{3, crun} = {anat_path}; % Normalise: Estimate & Write: Image to Align - cfg_files
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});

%% delete unnecessary files
for dir_path = 1:length(paths_for_deletion)
    fprintf('deleting unnecessary files from:\n%s\n', paths_for_deletion{dir_path});
    delete_preprocessing(paths_for_deletion{dir_path});
end

end
