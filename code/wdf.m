function wd = wdf(sig,fs,win_len,overlap,multi_plot)
% wd = wdf(sig,fs,win_len,overlap,multi_plot)
% Computes the WDF of the input signal.
%
%   Inputs:
% sig: Input signal
% fs: Sampling frequency
% win_len: Window length
% overlap: Window overlap ratio
% multi_plot: Suppresses figure creation for use in multi-plots
%
%   Outputs:
% wd: WDF of input singal
%
% e.g. wd = wdf(sig1,fs1,200,0.5);

if (nargin < 5)
    multi_plot = 0;
end

% Compute WDF over overlapping windows
N = length(sig);
wd = zeros(win_len,N);
slide = win_len*(1-overlap);
for k = 1:slide:N-win_len+1
    windowed_sig = sig(k:k+win_len-1);
    window = hann(win_len);
    W = mywigner(windowed_sig, window);
    wd(:,k:k+win_len-1) = wd(:,k:k+win_len-1) + transp(W);
end
nfft = size(W,2);
freq = (-nfft/2+1:nfft/2) / nfft * fs;

% Plot distribution
if (multi_plot)
    imagesc([0 N], [freq(1) freq(end)], log10(wd));
    title({'Wigner Distribution Function (Hann Window) ', [' win\_len=' num2str(win_len) ' overlap ' ...
        num2str(overlap*100) '%']});
    xlabel('Samples');
    ylabel('Frequency (Hz)');
    set(gca,'Ydir','Normal');
    
else
    figure();
    sp(1) = subplot(2,1,1);
    imagesc([0 N], [freq(1) freq(end)], log10(wd));
    title({'Wigner Distribution Function', [' win\_len=' num2str(win_len) ' overlap ' ...
        num2str(overlap*100) '%']});
    xlabel('Samples');
    ylabel('Frequency (Hz)');
    set(gca,'Ydir','Normal');

    % Plot signal
    sp(2) = subplot(2,1,2);
    plot(sig);
    title('Input signal');
    xlabel('Samples');
    ylabel('s[n]');
    linkaxes(sp, 'x'); % Link x axes of subplots
end

end