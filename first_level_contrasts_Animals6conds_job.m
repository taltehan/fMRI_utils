%-----------------------------------------------------------------------
% Job saved on 04-Apr-2019 13:27:06 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7487)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.spm.stats.fmri_spec.dir = '<UNDEFINED>';
matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'scans';
matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 1;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 16;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 8;
matlabbatch{1}.spm.stats.fmri_spec.sess(1).scans = '<UNDEFINED>';
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(1).multi = '<UNDEFINED>';
matlabbatch{1}.spm.stats.fmri_spec.sess(1).regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(1).multi_reg = '<UNDEFINED>';
matlabbatch{1}.spm.stats.fmri_spec.sess(1).hpf = 128;
matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;
matlabbatch{3}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
% Audio contrasts
matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'Basic_AudiovsNull';
matlabbatch{3}.spm.stats.con.consess{1}.tcon.weights = [1 1 1 0 0 0];
matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'repl';
matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = 'Some-All_audio';
matlabbatch{3}.spm.stats.con.consess{2}.tcon.weights = [1 -1 0 0 0 0];
matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'repl';
matlabbatch{3}.spm.stats.con.consess{3}.tcon.name = 'All-Some_audio';
matlabbatch{3}.spm.stats.con.consess{3}.tcon.weights = [-1 1 0 0 0 0];
matlabbatch{3}.spm.stats.con.consess{3}.tcon.sessrep = 'repl';
% Response contrasts
matlabbatch{3}.spm.stats.con.consess{4}.tcon.name = 'Basic_ResponsevsNull';
matlabbatch{3}.spm.stats.con.consess{4}.tcon.weights = [0 0 0 1 1 1];
matlabbatch{3}.spm.stats.con.consess{4}.tcon.sessrep = 'repl';
matlabbatch{3}.spm.stats.con.consess{5}.tcon.name = 'Some-All_response';
matlabbatch{3}.spm.stats.con.consess{5}.tcon.weights = [0 0 0 1 -1 0];
matlabbatch{3}.spm.stats.con.consess{5}.tcon.sessrep = 'repl';
matlabbatch{3}.spm.stats.con.consess{6}.tcon.name = 'All-Some_response';
matlabbatch{3}.spm.stats.con.consess{6}.tcon.weights = [0 0 0 -1 1 0];
matlabbatch{3}.spm.stats.con.consess{6}.tcon.sessrep = 'repl';
matlabbatch{3}.spm.stats.con.delete = 1;