import subprocess

import numpy as np
from edgfs2D.post_process.contour_plot import ContourPlot
from matplotlib.colors import LogNorm
from matplotlib.ticker import FuncFormatter


def exp_format(x, pos):
    return "$10^{{{0}}}$".format(int(f"{x:.1e}".split("e")[1]))


if __name__ == "__main__":
    outfile = "Kn.pdf"

    # Define the grid
    x = np.linspace(0, 2, 100)
    y = np.linspace(0, 2, 100)
    x, y = np.meshgrid(x, y)
    z = (1e-4 + 0.5 * (np.tanh(6 - 5 * x) + np.tanh(-4 + 5 * x))) * (
        1e-4 + 0.5 * (np.tanh(6 - 5 * y) + np.tanh(-4 + 5 * y))
    )

    cp = ContourPlot()
    fig, ax = cp.subplots()
    levels = np.logspace(-7, 0, 8)
    contour = ax.contourf(x, y, z, levels=levels, cmap=cp.cmap, norm=LogNorm())
    ax.set(xlabel="X (mm)", ylabel="Y (mm)")
    ax.set(xlim=(0, 2), ylim=(0, 2))
    cbar = cp.colorbar(
        contour, "Kn:", ticks=levels, inset_params=[0.38, 1.05, 0.6, 0.05]
    )
    cbar.ax.xaxis.set_major_formatter(FuncFormatter(exp_format))
    cp.savepdf(outfile)
    subprocess.call(["pdfcrop", outfile, outfile])
