results_files = uigetfile('*.*', 'MultiSelect', 'on');
% subject | run | miss_rate | control_accuracy | pragmatic_rate
% 01a_shapes_log_subject_3_run_2

% Table properties
varNames = {'subject', 'run', 'miss_rate', 'control_accuracy', 'pragmatic_rates'};
rows = length(results_files);
columns = length(varNames);
sz = [rows columns];
varTypes = {'double', 'double', 'double', 'double', 'double'};
Summary = table('Size', sz, 'VariableTypes', varTypes, 'VariableNames', varNames);

for i = 1:length(results_files)
    file_name = strsplit(result_files{i}, '.');
    file_split = strsplit(file_name{1}, '_');
    run = file_split{end};
    subject = file_split{end-2};
    subject_details = table(subject, run);
    run_summary = summarize_single_run(results_files{i});
    run_results = [subject_details, run_summary];
    Summary(i, :) = [run_summary, run_results];
end
    