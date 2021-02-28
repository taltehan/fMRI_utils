% List of open inputs
% Factorial design specification: Directory - cfg_files
% Factorial design specification: Scans - cfg_files
% Contrast Manager: Name - cfg_entry

% Allow extracting the nth element of multiple cells
extract = @(C, k) cellfun(@(c)c(k), C);

% Choose multiple subjects
subjects = uigetdir2();
first_level_name_options = {'03_Shapes_firstLevel_6conds'
                           '04_Shapes_firstLevel_12conds'
                           '05_Flanker_firstLevel'
                           '06_Animals_firstLevel_3conds'
                           '07_Animals_firstLevel_6conds'};
first_level_name = choosedialog('First Level Directory', 'Choose Directory', first_level_name_options);
first_level_split = strsplit(first_level_name, '_');
dir_description = inputdlg('Enter Description');
dir_description = dir_description{1};

% Second level directory name
second_level_path = 'C:\Users\TalT\Dropbox\Documents\SI_MRI_analysis\second_level_analysis';
if length(first_level_split) == 3
    second_level_name = [first_level_split{2}];
else
    second_level_name = [first_level_split{2}, '_', first_level_split{4}];
end
second_level_dir = fullfile(second_level_path, second_level_name, dir_description);

% Extract the contrast files of each subject
all_subjects_contrasts = cell(1,length(subjects));
for subject = 1:length(subjects)
    contrast_path = fullfile(subjects{subject}, first_level_name);
    contrast_dir = dir(fullfile(contrast_path, 'con*.nii'));
    contrast_filenames = extractfield(contrast_dir, 'name');
    contrast_files = fullfile(contrast_dir(1).folder, contrast_filenames);
    all_subjects_contrasts{subject} = contrast_files';
    % extract the contrasts names (first subject only)
    if subject == 1
        spm_mat_path = fullfile(contrast_path, 'SPM.mat');
        spm_mat_data = matfile(spm_mat_path);
        spm_mat_data = spm_mat_data.SPM;
        contrast_data = spm_mat_data.xCon;
        contrast_names = extractfield(contrast_data, 'name');
    end
end

% SPM inputs
nrun = length(all_subjects_contrasts{1}); % one run for each contrast
jobfile = {'second_level_general_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(3, nrun);
for crun = 1:nrun
    curr_dir_name = sprintf('%d_%s', crun, contrast_names{crun}(1:end-15));
    curr_dir_path = fullfile(second_level_dir, curr_dir_name);
    curr_contrasts = extract(all_subjects_contrasts, crun);
    inputs{1, crun} = {curr_dir_path}; % Factorial design specification: Directory - cfg_files
    inputs{2, crun} = curr_contrasts'; % Factorial design specification: Scans - cfg_files
    inputs{3, crun} = contrast_names{crun}; % Contrast Manager: Name - cfg_entry
end

spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});

% Save input file for future review
save(fullfile(second_level_dir, 'inputs'), 'inputs');