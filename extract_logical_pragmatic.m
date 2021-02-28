% Divide participants into pragmatic and logical
excel_summary = readtable(fullfile('..', 'Participants_summary.xlsx'));
% create strings formatted like '01_ES', '34_ES' etc.
pragmatic_numbers = excel_summary.Number(strcmp(excel_summary.L_P, 'P'));
pragmatic_numbers = pragmatic_numbers';
pragmatic_numbers = compose('%02.0f', pragmatic_numbers);
pragmatics = strcat(pragmatic_numbers, '_ES');
% pragmatic_indices = contains(subjects, pragmatics);
% same for logicals
logical_numbers = excel_summary.Number(strcmp(excel_summary.L_P, 'L'));
logical_numbers = logical_numbers';
logical_numbers = compose('%02.0f', logical_numbers);
logicals = strcat(logical_numbers, '_ES');
% logical_indices = contains(subjects, logicals);
