% List of open inputs
% Factorial design specification: Directory - cfg_files
% Factorial design specification: Scans - cfg_files
% Factorial design specification: Scans - cfg_files
% Factorial design specification: Scans - cfg_files

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
second_level_dir = fullfile(second_level_path, second_level_name, 'anova', dir_description);

% Extract the contrast files of each subject
all_subjects_contrasts = cell(1,length(subjects));
for subject = 1:length(subjects)
    contrast_path = fullfile(subjects{subject}, first_level_name);
    contrast_dir = dir(fullfile(contrast_path, 'beta*.nii'));
    contrast_filenames = extractfield(contrast_dir, 'name');
    contrast_files = fullfile(contrast_dir(1).folder, contrast_filenames);
    all_subjects_contrasts{subject} = contrast_files';
    % extract the contrasts names (first subject only)
%     if subject == 1
%         spm_mat_path = fullfile(contrast_path, 'SPM.mat');
%         spm_mat_data = matfile(spm_mat_path);
%         spm_mat_data = spm_mat_data.SPM;
%         contrast_data = spm_mat_data.xCon;
%         contrast_names = extractfield(contrast_data, 'name');
%     end
end

% SPM inputs
nrun = 1; % enter the number of runs here
jobfile = {'second_level_anova_shapes_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(4, nrun);
beta1 = extract(all_subjects_contrasts,1); % someALL
beta2 = extract(all_subjects_contrasts,2); % allALL
beta3 = extract(all_subjects_contrasts,3); % someSOME
% second run betas
beta14 = extract(all_subjects_contrasts,14); % someALL
beta15 = extract(all_subjects_contrasts,15); % allALL
beta16 = extract(all_subjects_contrasts,16); % someSOME 

for crun = 1:nrun
    inputs{1, crun} = {second_level_dir}; % Factorial design specification: Directory - cfg_files
    inputs{2, crun} = [beta1 beta14]'; % Factorial design specification: Scans - cfg_files
    inputs{3, crun} = [beta2 beta15]'; % Factorial design specification: Scans - cfg_files
    inputs{4, crun} = [beta3 beta16]'; % Factorial design specification: Scans - cfg_files
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
