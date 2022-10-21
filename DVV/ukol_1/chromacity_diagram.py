import colour
import numpy as np
from colour.plotting import *

RGB = colour.models.eotf_inverse_sRGB(np.array([[79, 2, 45], [87, 12, 67]]) / 255)

plot_RGB_chromaticities_in_chromaticity_diagram_CIE1931(RGB)