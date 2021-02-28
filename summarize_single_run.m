function run_summary = summarize_single_run(file_path)
%Summarize a single run's results

conditions = {'HelekNone', 'HelekSome', 'KolAll', 'KolNone', 'KolSome'};
correct_response = [3, 4, 4, 3, 3];
critical = 'HelekAll';
all_data = readtable(file_path);
all_data = all_data(2:end, :); % remove the practice trials

% calculate misses
no_nulls = all_data(~strcmp(all_data.Cond, 'Null'), :);
responses = no_nulls.SjtChoice;
misses = length(responses(isnan(responses)));
miss_rate = misses / responses;

% calculate accuracy
accuracy = zeros(1, length(conditions));
for i = 1:length(conditions)
   current_cond = all_data(strcmp(all_data.Cond, conditions{i}), :);
   current_responses = current_cond.SjtChoice;
   corrects = length(current_responses(current_responses == correct_response(i)));
   accuracy(i) = corrects / length(current_responses);
end
control_accuracy = mean(accuracy);

% calculate pragmatic responses
critical_responses = all_data(strcmp(all_data.Cond, critical), :);
pragmatic_responses = length(critical_responses.SjtChoice(critical_responses.SjtChoice == 3));
logical_responses = length(critical_responses.SjtChoice(critical_responses.SjtChoice == 4));
pragmatic_rate = pragmatic_responses / logical_responses;

run_summary = table(miss_rate, control_accuracy, pragmatic_rate);

end