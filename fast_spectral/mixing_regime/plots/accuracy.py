import subprocess

import matplotlib.pyplot as plt
import numpy as np
from edgfs2D.post_process.contour_plot import ContourPlot
from mpltools import annotation

colors = ["b", "g", "r", "c", "m", "y", "k", "w"]


if __name__ == "__main__":
    outfile = "accuracy.pdf"

    cp = ContourPlot()
    fig, ax = cp.subplots()

    # data obtained from compute_error.log generated from compute_error script
    E = [
        [1.9882467674609564e-06, 5.350876189264995e-07, 6.378121346388901e-08],
        [5.694296157831907e-07, 1.605914127946402e-08, 3.2612000239658497e-10],
        [1.5847898381273416e-07, 4.943404494995454e-10],
    ]
    P = np.arange(1, len(E) + 1)

    for j, p in enumerate(P):
        Ej = np.array(E[j])
        N = np.array([8, 32, 128, 512])[: len(Ej)]
        plt.loglog(1.0 / N, Ej, label="degree = {0}".format(p), color=colors[j])
        slope, intercept = np.polyfit(np.log(1.0 / N[-2:]), np.log(Ej[-2:]), 1)
        annotation.slope_marker(
            (1.0 / N[-1], Ej[-1]),
            ("{0:.2f}".format(slope), 1),
            ax=ax,
            poly_kwargs={"fill": False, "edgecolor": "black"},
            text_kwargs={"fontsize": 10},
        )

    ax.legend(loc="upper left", frameon=False)
    ax.set(xlabel="$1/N_e$", ylabel="$L^2$ error")
    ax.set(xlim=(5e-3, 1e-1), ylim=(1e-10, 1e-5))
    cp.savepdf(outfile)
    subprocess.call(["pdfcrop", outfile, outfile])
