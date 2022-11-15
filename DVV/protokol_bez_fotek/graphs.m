close all
clear variables
clc


CN = [40,35,30,25,20,17,15,12,10,5,3,0];
SNR_P_70dBm = [25.4, 25.8, 25.2, 24.4, 22.6, 20.5, 19.2, 16.6, 14.7, 10.2, 8.5, 6];
SNR_P_50dBm = [33.5, 31.4, 30.7, 27.5, 24.4, 21.4, 20.1, 17.1, 15.1, 10.4, 8.5, 6.1];
SNR_P_20dBm = [31.9, 31.8, 29.6, 26.4, 24.1, 21.3, 19.7, 17.2, 15.2, 10.4, 8.5, 6];

figure(1)
plot(CN,SNR_P_70dBm,'x-r',CN,SNR_P_50dBm,'x-g',CN,SNR_P_20dBm,'x-b')
grid on
grid minor
title("Závislost SNR na C/N, TM I")
xlabel("C/N")
ylabel("SNR")
legend(["P = 70dBm", "P = 50dBm", "P = 20dBm"],"Location","southeast")
saveas(gcf,"SNR_CN","epsc")


CN = [40, 35, 30, 25, 20, 17, 15, 12, 10, 5, 3, 0];
% TM_1 =  [31.6, 30.9, 30.7, 27.7, 24.6, 21.5, 19.8, 17.1, 15.1, 10.5, 8.6, 6.1];
TM_2 =  [32.2, 31.2, 30.5, 27.5, 24.4, 22, 19.8, 16.9, 15.2, 10.4, 8.5, 6.1];
TM_3 =  [32.4, 32.5, 30.6, 28.2, 24.4, 21.8, 20.1, 17.4, 15, 10.9, 8.2, 6.1];
TM_4 =  [32.2, 29.7, 28.6, 26.4, 23.5, 21.4, 20, 16.8, 15.2, 10.2, 8.8, 5.8];


figure(2)
plot(CN,TM_2,'x-r',CN,TM_3,'x-g',CN,TM_4,'x-b')
grid on
grid minor
title("Závislost SNR na C/N, Pout = -50dBm")
xlabel("C/N")
ylabel("SNR")
legend(["TM II", "TM III", "TM IV"],"Location","southeast")
saveas(gcf,"SNR_CN_TM_MODES","epsc")




CN = [40, 35, 30, 25, 20, 17, 15, 10, 5, 0];

RA4 = [21.8, 19.7, 15.5, 13.5, 12.6, 10.2, 11, 8.4, 5.5, 2.7];
RA6 =  [32.7, 29.1, 28.1, 20.2, 14.3, 14.1, 15, 10.6, 7, 3.5];
TU6 = [29.1, 25.5, 26.4, 24.7, 21.7, 19.2, 17.3, 13.7, 9.8, 4.8];
TU12 = [27.7, 26.4, 26.2, 24.6, 21.5, 19, 17, 14.9, 11.3, 5.4];

figure(3)
plot(CN, RA4, '-xr', CN, RA6, '-xg', CN, TU6, '-xb', CN, TU12, '-xk')
grid on
grid minor
title("Závislost SNR na C/N, Pout = -50dBm, TM = I")
xlabel("C/N")
ylabel("SNR")
legend(["RA4", "RA6", "TU6","TA12"],"Location","southeast")
saveas(gcf,"SNR_CN_CHANNELS","epsc")