import matplotlib.pyplot as plt
import numpy as np

data_x = np.arange(0, 10, 0.1)
data_y = np.sin(data_x)

Vf = 0.5e-8
N_sigma = 1.6e25
N_i = 1.034e23
gamma = (1.5+1.3)/100
lmbda = 697e-9
efficiency = 0.01
c = 3e8
w21 = 2*np.pi*c/lmbda
h_reduced = 1.0545718e-34
planck_w21 = h_reduced*w21
tau_21 = 3e-3
Wb_star = 337.670
Wb = np.arange(0*Wb_star,4.05*Wb_star,0.05*Wb_star)
#Wb = 2*Wb_star
T2 = 0.03
PL_tangent = (Vf*(N_sigma + N_i)*planck_w21)/(4*tau_21)*(T2/gamma)
PL = PL_tangent*(Wb/Wb_star - 1)
PL = np.clip(PL, a_min=0, a_max=np.max(PL))
print(PL)
if 1:

    fig, ax = plt.subplots(figsize=(8, 4), dpi=300)
    ax.axhline(y=0, color='k')
    N_values = []
    Wbmnin = 333.3333333
    linear_model = np.polyfit([0, Wbmnin],[-N_sigma,0],1)
    linear_model_fn = np.poly1d(linear_model)
    x_poly = np.arange(0,Wbmnin*1.1,Wbmnin/10)
    ax.plot(x_poly,linear_model_fn(x_poly),"-r")
    ax.plot([ Wb_star,4*Wb_star],[N_i,N_i],"-r")

    linear_model = np.polyfit([Wbmnin, Wb_star],[0,N_i],1)
    linear_model_fn = np.poly1d(linear_model)
    x_poly = np.linspace(Wbmnin,Wb_star,5)
    ax.plot(x_poly,linear_model_fn(x_poly),"-r")
    ax.set_title("$\Delta N_i = f(W_b)$ - zoom")
    ax.set_ylabel("N[-]; $\eta = 100\%$")
    ax.set_yticks([-N_sigma,0,N_i])
    ax.set_yticklabels([f"$-N_\Sigma$ = {-N_sigma}" ,"0",\
        f"$\Delta N_i^*$ = {N_i}"])

    ax.set_xticks([0,  Wbmnin, Wb_star, 4*Wb_star])
    ax.set_xticklabels(["0" + "$\,s^{-1}$" ,"$W_{bmin}$ = 333.333" + "$\,s^{-1}$",\
    f"$W_b^*$ = {Wb_star}" + "$\,s^{-1}$", f"$2W_b^*$ = {4*Wb_star}" + "$\,s^{-1}$"])

    ax.tick_params(axis='both', which='major', labelsize=7)
    ax.grid(visible=True, which= "major" , color= "black", linestyle= "-", linewidth= 0.3)
    #ax.grid(visible=True, which= "minor", color= "black", linestyle= "--", linewidth= 0.1)
    #ax.minorticks_on()

    ax.set_xlim(Wbmnin*0.995, Wb_star*1.005)
    ax.set_ylim(-N_i,N_i*1.2)

    fig.savefig("N_graph_zoom.eps", format= "eps")
    #plt.show()
    plt.show()

if 0:
    fig, ax = plt.subplots(figsize=(8, 4), dpi=300)
    ax.axhline(y=0, color='k')
    ax.plot(Wb, PL)
    ax.set_title("$P_L = f(W_b)$ při účinnosti buzení $\eta = 100\%$")
    ax.set_ylabel("PL[W] ;$\eta = 100\%$")
    ax.set_yticks([0,2.05028418,6])  
    ax.set_xticks([Wb_star, 2*Wb_star, 4*Wb_star])
    ax.set_xticklabels([f"$W_b^*$ = {Wb_star}" + "$\,s^{-1}$" ,f"$2W_b^*$ = {2*Wb_star}" + "$\,s^{-1}$",\
        f"$2W_b^*$ = {4*Wb_star}" + "$\,s^{-1}$"])
    ax.tick_params(axis='both', which='major', labelsize=7)
    ax.grid(visible=True, which= "major" , color= "black", linestyle= "-", linewidth= 0.3)
    #ax.grid(visible=True, which= "minor", color= "black", linestyle= "--", linewidth= 0.1)
    #ax.minorticks_on()


    ax.set_xlim(0, 4.25*Wb_star)

    fig.savefig("graphs.eps", format= "eps")