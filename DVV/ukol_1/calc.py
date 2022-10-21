#FROM RGB TO XYZ
def rgb2XYZ(r,g,b):
    X = 2.2770*r + 1.7526*g + 1.130*b
    Y = r + 4.591*g + 0.06*b
    Z = 0*r+ 0.057*g + 5.594*b

    return X,Y,Z

#FROM XYZ to RGB
def XYZ2rgb(X,Y,Z):
    r = 0.419 *X - 0.159*Y -0.083*Z
    g = -0.091*X + 0.252*Y + 0.016*Z
    b = 0.001*X + 0.003*Y + 0.179*Z
    return r,g,b

#FROM XYZ to xyz
def XYZ2xyz(X,Y,Z):
    x = X/(X+Y+Z)
    y = Y/(X+Y+Z)
    z = Z/(X+Y+Z)
    return x,y,z

def rgb2xyz(r,g,b):
    X,Y,Z = rgb2XYZ(r,g,b)
    x,y,z = XYZ2xyz(X,Y,Z)
    return x,y,z

#test rgb(1,1,1) should give cca (1/3,1/3,1/3)
print(rgb2xyz(1,1,1)) #(0.313432473149633, 0.34328376342518346, 0.34328376342518346)

#UKOL 1:
#xy cordinates of points M1 and M2
M1_rgb = (10,8,1)
M2_rgb = (20,5,25)

M1_xyz = rgb2xyz(*M1_rgb)
M2_xyz = rgb2xyz(*M2_rgb)
print("M1",M1_xyz) # (0.41781953926230847, 0.5155202580906755, 0.06666020264701605)
print("M2",M2_xyz) # (0.30902175988141184, 0.16640900192031985, 0.5245692381982684)

#COLOR MIXING
# M1 + M2 = M
def addColorXYZ(x1,y1,z1,coef1,x2,y2,z2,coef2):
    x = coef1*x1+x2*coef2
    y = coef1*y1+y2*coef2
    z = coef1*z1+z2*coef2
    return x,y,z

#final result
M_final_xyz = XYZ2xyz(*addColorXYZ(*M1_xyz,1,*M2_xyz,1))
print("M1 + M2",M_final_xyz) # (0.36342064957186015, 0.34096463000549765, 0.29561472042264225)

#sytost
pe = (M_final_xyz[0]- 1/3)/(0.57-1/3)
print("sytost",pe) # 0.127129505233212