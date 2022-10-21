close all
clear all

time = linspace(60,120*60,100);

bit = 10;

bitrate = (2*6.75+13.5)*bit*1e6; 
memory = time .* bitrate;

compress_10_bit = memory./4.7e9;

bit = 8
bitrate = (2*6.75+13.5)*bit*1e6; 
memory = time .* bitrate;

compress_8_bit = memory./4.7e9;

figure(1)
plot(time./60,compress_10_bit, "-r")
hold on
plot(time./60,compress_8_bit, "-g")
grid on
grid minor
legend("10 bit", "8 bit")
title("závislost kompresního poměru")
xlabel("čas [min]")
ylabel("Kompresní poměr")
saveas(gcf,"kompres","epsc")

