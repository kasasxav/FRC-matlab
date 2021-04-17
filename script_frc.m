% %% This script computes the FRC of two images
% 
clear
clc
close all

path = [''];
files = dir([path '*.tif']); 
pixel_size = 30;
N = size(files, 1);
res = zeros(1, N);

for i = 1:N

% Read images
i1 = imread([path files(i).name], 1);
i2 = imread([path files(i).name], 2);

% Normalize images from 0 to 1
i1 = (i1 - min(i1))./(max(i1) - min(i1));
i2 = (i2 - min(i2))./(max(i2) - min(i2));

% Fourier transform and shift (0,0) to center of the images
I1 = fftshift(fft2(double(i1)));
I2 = fftshift(fft2(double(i2)));

% Calculate FRC components
[rd, C]  = average_radial_profile(I1.*conj(I2));
[~, C1] = average_radial_profile(I1.*conj(I1));
[~, C2] = average_radial_profile(I2.*conj(I2));

% Normalize radius to Nyquist frequency
f = rd./(ceil(size(I1,1))/2);

% Calculate FRC and smooth it
FRC = abs(C./(sqrt(C1.*C2)));
sFRC = smooth(smooth(FRC));

%% Resolution
% Find cutoff
s = (sFRC - 1/7).^2;
res(i) = 2*pixel_size/((f(s==min(s))));

%% Plot
hold on;
plot(f/(2*pixel_size), sFRC,'LineWidth', 2);

end
% Plot 1/7 threshold
hold on; 
plot(f/(2*pixel_size), 1/7*ones(length(f), 1),'LineWidth', 2);