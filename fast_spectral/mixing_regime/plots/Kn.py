import subprocess

import numpy as np
from edgfs2D.post_process.contour_plot import ContourPlot

outfile = "Kn.pdf"


# Define the grid
x = np.linspace(0, 2, 50)
y = np.linspace(0, 2, 50)
x, y = np.meshgrid(x, y)
z = (1e-4 + 0.5 * (np.tanh(7 - 5 * x) + np.tanh(-3 + 5 * x))) * (
    1e-4 + 0.5 * (np.tanh(7 - 5 * y) + np.tanh(-3 + 5 * y))
)

cp = ContourPlot()
fig, ax = cp.subplots()
contour = ax.contourf(x, y, z, levels=np.linspace(0, 1, 9), cmap=cp.cmap)
ax.set(xlabel="X (mm)", ylabel="Y (mm)")
ax.set(xlim=(0, 2), ylim=(0, 2))
cbar = cp.colorbar(contour, "Kn:", ticks=np.linspace(0, 1, 5))
cp.savepdf(outfile)
subprocess.call(["pdfcrop", outfile, outfile])
