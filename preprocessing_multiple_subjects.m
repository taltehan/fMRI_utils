% Preprocessing: Multiple subjects

% Choose multiple subjects
subjects = uigetdir2();

% Run preprocessing for each subject
for i = 1:length(subjects)
    fprintf('########\nPreprocessing\nsubject %d of %d\n########\n', i, length(subjects));
    preprocessing_single_subject(subjects{i});
end