%{
This is Deniz Yüksel
21600880
EEE391 Section 1
MATLAB ASSIGNMENT 1
%}
%{
recObj = audiorecorder(16000, 8, 1);
disp("Start recording.");
recordblocking(recObj, 5);
disp("End of Recording.");


play(recObj);
%}
% DONT DELETE THE COMMENTS ABOVE, YOU WILL LOSE THE RECORDED HARMONICA!!!
load('test.mat');
soundArray = getaudiodata(recObj);
figure;
plot(soundArray);
title('My recorded C harmonica');
xlabel('Samples');
ylabel('Amplitude');

partOfSoundArray = soundArray(65000:1:66000);

figure;
plot(partOfSoundArray);
title('partOfSoundArray 1000 samples Observation');
xlabel('Samples');
ylabel('Amplitude');


fundamentalFreq = 659.25;
fundamentalPeriod = 1 / 659.25;
sampleRate = 16000;
samplingPeriod = 1 / 16000;
wavelength = 52.33;
noOfSamples = fundamentalPeriod * sampleRate;
sample_count_oop = fundamentalPeriod / samplingPeriod;
sampleCountInOnePeriod = ceil(sample_count_oop);
graphicalFundamentalPeriod = 25;
graphicalErrorFundamentalPeriod = 10;

firstPeriodOfPartOfSoundArray = partOfSoundArray(1:1:graphicalFundamentalPeriod);


figure;
plot(firstPeriodOfPartOfSoundArray);
title('Observation for 1 period (in theory)');
xlabel('Samples');
ylabel('Amplitude');

figure;
plot(partOfSoundArray(1:1:10));
title('Observation for 1 period (in practice)');
xlabel('Samples');
ylabel('Amplitude');



x = firstPeriodOfPartOfSoundArray.';

%quantizing time.
t = 0:1:graphicalFundamentalPeriod - 1;
TsOne = graphicalFundamentalPeriod;

ak = zeros(1,TsOne);


%evaluating the integral.

for k = -(TsOne-1):TsOne-1
    expTerm = exp(-j*(2*pi)*k*(t/TsOne));
    ak(k+TsOne) = trapz( (x.*expTerm) / TsOne);
    abs_ak = abs(ak);
end

% the interval -N,N
N = -(TsOne - 1):1: TsOne - 1;


figure;
stem(N, real(abs_ak))
title('Magnitude of Fourier Series Coefficients in One Period');
xlabel('|ak| coefficients')
ylabel('complex amplitude')


% Part 4

t_second = 0:graphicalFundamentalPeriod/TsOne: graphicalFundamentalPeriod - graphicalFundamentalPeriod/TsOne;
synthesizedSignal = zeros(size(t_second));

for k = -(TsOne-1):TsOne-1 
   synthesizedSignal = synthesizedSignal + (ak(k+graphicalFundamentalPeriod)* exp(k*1j*2*pi*(t_second/graphicalFundamentalPeriod))); 
end
figure;
plot(t_second,real(synthesizedSignal)); % The one period signal

n = 40;
newArray = repmat(synthesizedSignal,1,n);
regeneratedGraph = real(newArray);
figure;
plot(regeneratedGraph);
title('Regenerated Signal with 1000 Samples');
xlabel('Samples')
ylabel('Amplitude')

% Now write the audiofile...
%sound(regeneratedGraph);
audiowrite('harmonica_reproduced.wav', regeneratedGraph, 16000);
%}

%PART 6

bk(6) = ak(25);        %This is ak(0).
bk(7) = ak(26);
bk(5) = ak(24);
bk(4) = ak(23);
bk(3) = ak(22);
bk(2) = ak(21);
bk(1) = ak(20);
bk(8) = ak(27);
bk(9) = ak(28);
bk(10) = ak(29);

TsTwo = 5;
t_second_2 = 0:graphicalFundamentalPeriod/TsTwo: graphicalFundamentalPeriod - graphicalFundamentalPeriod/TsTwo;
reSynthesizedSignal = zeros(size(t_second_2));

for k = 1:10 
   reSynthesizedSignal = reSynthesizedSignal + (bk(k)* exp(k*1j*2*pi*(t_second_2/graphicalFundamentalPeriod))); 
end
figure;
plot(t_second_2,real(reSynthesizedSignal)); % The one period signal
title('Part6 Regenerated Signal From New Coefficients One Period');
xlabel('Samples')
ylabel('Amplitude')


n = 40;
newArray2 = repmat(reSynthesizedSignal,1,n);
reSynthesizedSignal = real(newArray2);
%figure;
%plot(reSynthesizedSignal);
%title('Part6 Regenerated Signal From New Coefficients');
%xlabel('Samples')
%ylabel('Amplitude')

% Now write the audiofile...
%sound(reSynthesizedSignal);

%Part 7

ck(6) = 1;        %This is ak(0).
ck(7) = 1;
ck(5) = 1;
ck(4) = 1;
ck(3) = 1;
ck(2) = 1;
ck(1) = 1;
ck(8) = 1;
ck(9) = 1;
ck(10) = 1;

TsTwo = 5;
t_second_2 = 0:graphicalFundamentalPeriod/TsTwo: graphicalFundamentalPeriod - graphicalFundamentalPeriod/TsTwo;
reSynthesizedSignal = zeros(size(t_second_2));

for k = 1:10 
   reSynthesizedSignal = reSynthesizedSignal + (ck(k)* exp(k*1j*2*pi*(t_second_2/graphicalFundamentalPeriod))); 
end
figure;
plot(t_second_2,real(reSynthesizedSignal)); % The one period signal
title('Part7 Regenerated Signal From New Coefficients One Period');
xlabel('Samples')
ylabel('Amplitude')


n = 40;
newArray2 = repmat(reSynthesizedSignal,1,n);
reSynthesizedSignal = real(newArray2);
%figure;
%plot(reSynthesizedSignal);
%title('Part6 Regenerated Signal From New Coefficients');
%xlabel('Samples')
%ylabel('Amplitude')

% Now write the audiofile...
sound(reSynthesizedSignal);


