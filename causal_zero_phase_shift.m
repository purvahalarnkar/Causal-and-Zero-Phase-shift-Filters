clc
clear all
close all

%create a signal
signal=[zeros(1,100) cos(linspace(pi/2,5*pi/2,10)) zeros(1,100)];
n=length(signal);

subplot(221)
plot(1:n,signal,'k')
set(gca,'xlim',[0 n+1]);
title('Original Signal')
xlabel('Time points')

%power spectrum of original signal
signalpow=abs(fft(signal));

subplot(222)
plot(linspace(0,1,n),signalpow,'ko-')
set(gca,'xlim',[0 0.5]);
title('Frequency Response')
xlabel('Frequency')

%Low pass causal filter
filtkern=fir1(50,0.6,'low');
filtsignal=filter(filtkern,1,signal);

subplot(234)
plot(1:n,signal,'k')
hold on
plot(1:n,filtsignal,'b')
set(gca,'xlim',[0 n+1]);
title('Causal Low Pass Filter')
xlabel('Time Slots')
legend('Original','Forward Filtered')

%power spectrum of low pass causal filter
filtsignalpow=abs(fft(filtsignal));

subplot(222)
hold on
plot(linspace(0,1,n),filtsignalpow,'b','linew',2)

%flip the filtered signal backwards
filtsignalflip=filtsignal(end:-1:1);
filtback=filter(filtkern,1,filtsignalflip);

subplot(235)
plot(1:n,signal,'k')
hold on
plot(1:n,filtback,'r')
title('Filtered flipped signal')
xlabel('Time Slots')
legend('Original','Backward Filtered')

%power spectrum of flipped filtered signal
filtbackpow=abs(fft(filtback));

subplot(222)
hold on
plot(linspace(0,1,n),filtbackpow,'rs-')

%zero phase-shift filter
flipfiltback=filtback(end:-1:1);
zerophase=filter(filtkern,1,flipfiltback);

subplot(236)
plot(1:n,signal,'k')
hold on
plot(1:n,flipfiltback,'g')
title('Zero phase-shift filter')
xlabel('Time Slots')
legend('Original','Zero phase-shift')

%power spectrum of flipped filtered signal
zerophasepow=abs(fft(zerophase));

subplot(222)
hold on
plot(linspace(0,1,n),zerophasepow,'g','linew',3)
legend('Original','Causal Filter','Flipped','Zero Phase-shift')