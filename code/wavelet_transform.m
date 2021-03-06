function wt = wavelet_transform(sig,fs,wname,params,multi_plot)
% wt = wavelet_transform(sig,fs,wname,params,multi_plot)
% Applies WT to input signal.
%
%   Inputs:
% sig: Input signal
% fs: Sampling frequency
% wname: Wavelet to use
% params: Wavelet parameters (for morse wavelets)
% multi_plot: Suppress figure creation for use in multi-plots
%
%   Outputs:
% wt: Continuous wavelet transform
%
% e.g. wt = wavelet_transform(sig1,fs1,'morse',[2 90]);

if (nargin < 5)
    multi_plot = 0;
end

% Calculate CWT
N = length(sig);
if (strcmp(wname,'morse'))
    [wt,freq] = cwt(sig,wname,fs,'WaveletParameters',params);
else
    params = [];
    [wt,freq] = cwt(sig,wname,fs);
end

% Plot CWT
if (multi_plot)
    imagesc(0:N-1,log2(freq),abs(wt));
    title({'Continuous Wavelet Transform ', [wname ' wavelet, params=' mat2str(params)]});
    xlabel('Samples');
    ylabel('Frequency (Hz)');
    set(gca,'Ydir','Normal');
    Yticks = 2.^(round(log2(min(freq))):round(log2(max(freq))));
    AX = gca;
    AX.YLim = log2([min(freq), max(freq)]);
    AX.YTick = log2(Yticks);
    AX.YDir = 'normal';
    set(AX,'YLim',log2([min(freq),max(freq)]), ...
        'layer','top', ...
        'YTick',log2(Yticks(:)), ...
        'YTickLabel',num2str(sprintf('%g\n',Yticks)), ...
        'layer','top');
    
else
    figure();
    sp(1) = subplot(2,1,1);
    imagesc(0:N-1,log2(freq),abs(wt));
    title({'Continuous Wavelet Transform ', ' ', [wname ' wavelet, params=' mat2str(params)]});
    xlabel('Samples');
    ylabel('Frequency (Hz)');
    set(gca,'Ydir','Normal');
    Yticks = 2.^(round(log2(min(freq))):round(log2(max(freq))));
    AX = gca;
    AX.YLim = log2([min(freq), max(freq)]);
    AX.YTick = log2(Yticks);
    AX.YDir = 'normal';
    set(AX,'YLim',log2([min(freq),max(freq)]), ...
        'layer','top', ...
        'YTick',log2(Yticks(:)), ...
        'YTickLabel',num2str(sprintf('%g\n',Yticks)), ...
        'layer','top');

    % Plot signal
    sp(2) = subplot(2,1,2);
    plot(sig);
    title('Input signal');
    xlabel('Samples');
    ylabel('s[n]');
    linkaxes(sp, 'x'); % Link x axes of subplots
end

end