dirs = dir();
dirs = dirs(3:end);

for i = 1:length(dirs)
    curr_dir = dirs(i).name;
    dcm_files = dir(fullfile(curr_dir, '*.dcm'));
    fprintf('found %d files in %s\n', length(dcm_files), curr_dir);
    for j = 1:length(dcm_files)
        path = fullfile(curr_dir, dcm_files(j).name);
        dicomanon(path, path);
        if ~mod(j,20)
            fprintf('completed %d files out of %d\n', j, length(dcm_files));
        end
    end
end