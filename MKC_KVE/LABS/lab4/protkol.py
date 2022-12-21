import matplotlib
import matplotlib.pyplot as plt
import numpy as np
from sympy import S, symbols, printing

I_478nm =  [0,0,0,0.9,9.46,14.93,24.97,26.42,19.42] 
U_478nm =  [0.7,1.2,2.15,2.5,2.86,3,3.23,3.25,3.09] 
P_478nm =  [0,0,0,0.49,4.25,6.18,9.17,9.51,7.54] 



I_630nm =[0.09,0,2,3.5,4.8,6.7,14.16,19.8,22.5,26]
U_630nm =[1.7,1.32,1.85,1.88,1.91,1.96,2.06,2.14,2.17,2.2]
P_630nm =[0.0198,0,0.384,0.64,0.897,1.358,2.733,3.86,4.39,5.1]

I_565nm =[0.05,2.6,4.5,6.3,8.76,12.5,16,18.3,23.6,25]
U_565nm =[2.485,2.7,2.74,2.79,2.82,2.94,3,3.03,3.1,3.12]
P_565nm =[0.01,0.28,0.479,0.664,0.889,1.2,1.474,1.65,2,2.116]

I_650nm =[0,1.5,1.89,7.43,11.7,17.23,21.55,23.04,25.7,15.6]
U_650nm =[1.45,1.83,1.86,1.94,2,2,2,2.11,2.13,1.96]
P_650nm =[0,0.01,0.012,0.013,0.016,0.019,0.025,0.027,0.032,0.017]


list_of_titles = ["V/A a W/A charakteristika LED 478nm","V/A a W/A charakteristika LED 630nm",\
    "V/A a W/A charakteristika LED 565nm","V/A a W/A charakteristika laserové diody 650nm"]

save_name = ["LED_478nm.eps","LED_630nm.eps","LED_565nm.eps","Laser_650nm.eps"]

I = [I_478nm,I_630nm,I_565nm,I_650nm]
U = [U_478nm,U_630nm,U_565nm,U_650nm]
P = [P_478nm,P_630nm,P_565nm,P_650nm]

for i in range(len(list_of_titles)):
    I_plot, U_plot, P_plot= zip(*sorted(zip(I[i],U[i],P[i])))
    fig,ax = plt.subplots(figsize=(8, 4), dpi=300)
    ax.plot(I_plot,U_plot,"-xr")
    ax2 = ax.twinx()
    ax2.plot(I_plot,P_plot,"-xb")
    ax.set_title(list_of_titles[i])
    ax.set_xlabel("I [mA]")
    ax.set_ylabel("U [V]",color="r")
    ax2.set_ylabel("P [mW]", color="b")
    #ax.set_yticks(U_LED_478nm)
    #ax2.set_yticks(P_LED_478nm)

    if save_name[i] == "Laser_650nm.eps":
        linear_model = np.polyfit(I_plot[-4:],P_plot[-4:],1)
        linear_model_fn = np.poly1d(linear_model)
        x_poly = np.arange(2,I_plot[-1]*1.2)
        ax2.plot(x_poly,linear_model_fn(x_poly),":g")
        ax2.plot([-2,32],[0,0,],":b")
        ax.set_xlim(-2,32)
        print(linear_model_fn)
        ax.text(11,1.63,str(linear_model_fn),color="g")


        linear_model = np.polyfit(I_plot[-8:],U_plot[-8:],1)
        linear_model_fn = np.poly1d(linear_model)
        x_poly = np.arange(-2,I_plot[-1]*1.2)
        ax.plot(x_poly,linear_model_fn(x_poly),":r")
        ax.set_xlim(-2,32)
        print(linear_model_fn)
        ax.text(0,2,str(linear_model_fn),color="r")
    
    else:

        linear_model = np.polyfit(I_plot[-7:],P_plot[-7:],1)
        linear_model_fn = np.poly1d(linear_model)
        x_poly = np.arange(0,I_plot[-1]*1.2)
        ax2.plot(x_poly,linear_model_fn(x_poly),":g")
        ax2.plot([-2,32],[0,0,],":b")
        ax.set_xlim(-2,32)
        print(linear_model_fn)
        ax2.text(15,(max(P_plot) - min(P_plot))/2.5,str(linear_model_fn),color="g")

        linear_model = np.polyfit(I_plot[-6:],U_plot[-6:],1)
        linear_model_fn = np.poly1d(linear_model)
        x_poly = np.arange(-2,I_plot[-1]*1.2)
        ax.plot(x_poly,linear_model_fn(x_poly),":r")
        ax.set_xlim(-2,32)
        print(linear_model_fn)
        ax.text(0,max(U_plot),str(linear_model_fn),color="r")


    ax.grid(visible=True,which="minor",axis="both",color="k",linestyle="dashed",linewidth=0.3)
    ax.grid(visible=True,which="major",axis="both",color="k",linestyle="-")
    ax.minorticks_on()

 
    fig.savefig(save_name[i],format="eps")
    #ax2.grid(visible=True,which="both",axis="both",color="b",linestyle="dashed")
    #plt.show()

