CN = [40,35,30,25,20,17,15,12,10,5,3,0];
SNR_P_70dBm = [25.4, 25.8, 25.2, 24.4, 22.6, 20.5, 19.2, 16.6, 14.7, 10.2, 8.5, 6];
SNR_P_50dBm = [33.5, 31.4, 30.7, 27.5, 24.4, 21.4, 20.1, 17.1, 15.1, 10.4, 8.5, 6.1];
SNR_P_20dBm = [31.9, 31.8, 29.6, 26.4, 24.1, 21.3, 19.7, 17.2, 15.2, 10.4, 8.5, 6];

figure(1)
plot(CN,SNR_P_70dBm,'x-r',CN,SNR_P_50dBm,'x-g',CN,SNR_P_20dBm,'x-b')
grid on
grid minor
title("Závislost SNR na C/N")
xlabel("C/N")
ylabel("SNR")
legend(["P = 70dBm", "P = 50dBm", "P = 20dBm"],"Location","southeast")
saveas(gcf,"SNR_CN","epsc")