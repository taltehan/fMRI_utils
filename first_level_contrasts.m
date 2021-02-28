function first_level_contrasts(subject_dir, first_level_name)
% Run first level, estimation and create contrasts
%   Single subject

% List of open inputs
% fMRI model specification: Directory - cfg_files
% fMRI model specification: Scans - cfg_files
% fMRI model specification: Multiple conditions - cfg_files
% fMRI model specification: Multiple regressors - cfg_files
% fMRI model specification: Scans - cfg_files
% fMRI model specification: Multiple conditions - cfg_files
% fMRI model specification: Multiple regressors - cfg_files

% Get the relevant paths
first_level_dir = fullfile(subject_dir, first_level_name);
first_level_split = strsplit(first_level_name, '_');
experiment_name = lower(first_level_split{2});
experiment_path = fullfile(subject_dir, '02_functional', '02_nifti', ['*', experiment_name]);
experiment_dir = dir(experiment_path);
runs = dir(fullfile(experiment_dir.folder, experiment_dir.name));
runs = runs(3:end);
single_run_flag = 0;
% Check if there is only one run
if length(runs) == 1
    single_run_flag = 1;
end
preprocessed_files = cell(1,length(runs));
rp_files = cell(1,length(runs));
% Get the scans and rp file for each run
for run = 1:length(runs)
    curr_run = runs(run).name;
    nii_path = fullfile(runs(run).folder, curr_run);
    nii_dir = dir(fullfile(nii_path, 'swrra*.nii')); % preprocessed files
    nii_names = extractfield(nii_dir, 'name');
    nii_files = fullfile(nii_path, nii_names);
    preprocessed_files{run} = nii_files';
    rp_dir = dir(fullfile(nii_path, 'rp_*.txt'));
    rp_name = fullfile(rp_dir.folder, rp_dir.name);
    rp_files{run} = {rp_name};
end

% Get the condition matrices
conditions_dir = dir(fullfile(first_level_dir, '0*.mat'));
conditions1 = fullfile(conditions_dir(1).folder, conditions_dir(1).name);
if ~single_run_flag
    conditions2 = fullfile(conditions_dir(2).folder, conditions_dir(2).name);
end

% Get the name of spm's job file
if length(first_level_split) ==4
    job_name = [first_level_split{2}, first_level_split{4}];
else
    job_name = first_level_split{2};
end

nrun = 1; % enter the number of runs here
job_name = ['first_level_contrasts_', job_name, '_job.m'];
jobfile = {job_name};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(7, nrun);

for crun = 1:nrun
    inputs{1, crun} = {first_level_dir}; % fMRI model specification: Directory - cfg_files
    inputs{2, crun} = preprocessed_files{1}; % fMRI model specification: Scans - cfg_files
    inputs{3, crun} = {conditions1}; % fMRI model specification: Multiple conditions - cfg_files
    inputs{4, crun} = rp_files{1}; % fMRI model specification: Multiple regressors - cfg_files
    if ~single_run_flag
        inputs{5, crun} = preprocessed_files{2}; % fMRI model specification: Scans - cfg_files
        inputs{6, crun} = {conditions2}; % fMRI model specification: Multiple conditions - cfg_files
        inputs{7, crun} = rp_files{run}; % fMRI model specification: Multiple regressors - cfg_files
    end
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});

end