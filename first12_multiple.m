% remove first 12 files: multiple subjects

% Choose multiple subjects
subjects = uigetdir2();

% remove first 12 files for each subject
for i = 1:length(subjects)
    fprintf('########\nWorking on\nsubject %d of %d\n########\n', i, length(subjects));
    first12(subjects{i});
end