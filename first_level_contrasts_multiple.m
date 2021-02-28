% First level + contrasts for multiple subjects

% Choose multiple subjects
subjects = uigetdir2();
% Choose the first level dir (for all subjects)
first_level_name_options = {'03_Shapes_firstLevel_6conds'
                           '04_Shapes_firstLevel_12conds'
                           '05_Flanker_firstLevel'
                           '06_Animals_firstLevel_3conds'
                           '07_Animals_firstLevel_6conds'};
first_level_name = choosedialog('First Level Directory', 'Choose Directory', first_level_name_options);
for i = 1:length(subjects)
    first_level_contrasts(subjects{i}, first_level_name);
end