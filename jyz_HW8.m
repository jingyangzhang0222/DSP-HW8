close all
clear

load NoisySpeech.txt
load mtlb
N = NoisySpeech;
L = length(mtlb);
Nf = fft(N, 4096);
mtlbf = fft(mtlb, 4096);

fd = 2*pi*(2900/Fs);
b = conv([1 -2*cos(fd) 1],[1 1]);
b = b/polyval(b, 1); % make dc gain = 1
a = [1 0 0 0];
[H, w] = freqz(b,a);
y = filter(b,a,N);
delta = zeros(1,8);delta(1) = 1;
yf = fft(y, 4096);
IR = filter(b,a,delta);

figure(1)
subplot(3,1,1)
plot([0:L-1]/Fs, mtlb)
title('Waveform of The Clean Signal')
xlabel('Time (s)');xlim([0,(L-1)/Fs]);
ylim([-4, 4]);
subplot(3,1,2)
plot([0:L-1]/Fs,N)
title('Waveform of The Noisy Signal')
xlabel('Time (s)');xlim([0,(L-1)/Fs]);
ylim([-4, 4]);
subplot(3,1,3)
plot([0:L-1]/Fs,y)
title('Waveform of The Filtered Signal')
xlabel('Time (s)');xlim([0,(L-1)/Fs]);
ylim([-4, 4]);

figure(2)
subplot(3,1,1)
plot(0:Fs/4096:Fs-Fs/4096,abs(mtlbf))
title('Spectrum of The Clean Signal')
xlabel('Frequency(cycles/second)');xlim([0, 3708]);
subplot(3,1,2);
plot(0:Fs/4096:Fs-Fs/4096,abs(Nf))
title('Spectrum of The Noisy Signal');
xlabel('Frequency(cycles/second)');xlim([0, 3708]);
subplot(3,1,3)
plot(0:Fs/4096:Fs-Fs/4096,abs(yf))
title('Spectrum of The Filtered Signal')
xlabel('Frequency(cycles/second)');xlim([0, 3708]);

figure(3)
subplot(3,1,1)
plot(w/pi, abs(H))
title('Frequency Response of The System')
xlabel('\omega/\pi');xlim([0, 1]);
subplot(3,1,2)
stem(0:7,IR,'.')
title('Impulse Response of The System')
subplot(3,1,3)
zplane(b,a)
title('Pole/Zero Diagram of The System')
xlim([-1.1 1.1]);ylim([-1.1 1.1]);

soundsc(mtlb, Fs)
soundsc(N, Fs)
soundsc(y, Fs)