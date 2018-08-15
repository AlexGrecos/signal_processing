function wt = wavelet_transform(sig,fs,wname,params)
% wt = wavelet_transform(sig,fs,wname,params)
% Applies WT to input signal.
%
%   Inputs:
% sig: Input signal
% fs: Sampling frequency
% wname: Wavelet to use
% params: Wavelet parameters (for morse wavelets)
%
%   Outputs:
% wt: Continuous wavelet transform
%
% e.g. wt = wavelet_transform(sig1,fs1,'morse',[2 90]);

% Calculate CWT
N = length(sig);
if (strcmp(wname,'morse'))
    [wt,freq] = cwt(sig,wname,fs,'WaveletParameters',params);
else
    params = [];
    [wt,freq] = cwt(sig,wname,fs);
end

% Plot CWT
figure();
sp(1) = subplot(2,1,1);
imagesc([0 N],[freq(1) freq(end)], abs(wt));
title(['Wavelet Transform ' wname ' wavelet params=' mat2str(params)]);
xlabel('Samples');
ylabel('Frequency');
set(gca,'Ydir','Normal');

% Plot signal
sp(2) = subplot(2,1,2);
plot(sig);
title('Input signal');
xlabel('Samples');
ylabel('s[n]');
linkaxes(sp, 'x'); % Link x axes of subplots

end