function [A,w] = firamp(h,type,L)
% [A,w] = firamp(h,type,L)
% Amplitude response of a linear-phase FIR filter
% A : amplitude response at the frequencies w
% w : [0:L-1]*(2*pi/L);
% h : impulse response
% type = [1,2,3,4]
