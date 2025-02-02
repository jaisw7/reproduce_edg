import glob
import re
import subprocess
from pathlib import Path

import matplotlib.pyplot as plt
import meshio
from edgfs2D.post_process.contour_plot import ContourPlot

files = []

# Load the VTU file
natsort = lambda s: [
    int(t) if t.isdigit() else t.lower() for t in re.split(r"(\d+)", s)
]
for filename in sorted(glob.glob("../*.vtk"), key=natsort):
    mesh = meshio.read(filename)
    outfile = Path(filename).with_suffix(".pdf").name
    x, y = mesh.points[:, 0], mesh.points[:, 1]
    triangles = mesh.cells[1].data
    cp = ContourPlot()
    fig, ax = cp.subplots()
    plt.triplot(x, y, triangles, color="black", linewidth=0.5)  # Overlay edges
    ax.set(xlim=(0, 2), ylim=(0, 2))
    cp.savepdf(outfile)
    subprocess.call(["pdfcrop", outfile, outfile])
    files.append(outfile)

outfile = "mixing_regime_meshes.pdf"
subprocess.call(["pdfjam", "--nup", f"{len(files)}x1", *files, "-o", outfile])
subprocess.call(["pdfcrop", outfile, outfile])

for file in files:
    os.remove(file)
