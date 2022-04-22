import matplotlib.collections
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.figure import Figure
from matplotlib.backends.backend_tkagg import (FigureCanvasTkAgg, NavigationToolbar2Tk)


class Mode:
    def _init_(self, center, samples_x, samples_y):
        self.center = center
        self.samples_x = samples_x
        self.samples_y = samples_y


class ModeGroup:
    def _init_(self, label):
        self.label = label
        self.modes = []


MODE_NO = 8
SAMPLE_NO = 32


def close_window():
    exit()


def generate_plot():

    try:
        mode_no_0 = int(mode_no_entry_0.get())
    except ValueError:
        mode_no_0 = MODE_NO

    try:
        mode_no_1 = int(mode_no_entry_1.get())
    except ValueError:
        mode_no_1 = MODE_NO

    try:
        sample_no = int(sample_no_entry.get())
    except ValueError:
        sample_no = SAMPLE_NO

    mode_groups = [ModeGroup(0), ModeGroup(1)]

    rng = np.random.default_rng()
    # class_assignment = rng.choice(2, mode_no)
    # print(class_assignment)

    mode_centers_0 = list(zip(rng.uniform(0, 1, mode_no_0), rng.uniform(0, 1, mode_no_0)))
    stdevs_0 = rng.uniform(0, 0.075, mode_no_0)

    mode_centers_1 = list(zip(rng.uniform(0, 1, mode_no_1), rng.uniform(0, 1, mode_no_1)))
    stdevs_1 = rng.uniform(0, 0.075, mode_no_1)

    for index, mode_center in enumerate(mode_centers_0):
        samples_x = rng.normal(mode_center[0], stdevs_0[index], sample_no)
        samples_y = rng.normal(mode_center[1], stdevs_0[index], sample_no)
        mode_groups[0].modes.append(Mode(mode_center, samples_x, samples_y))

    for index, mode_center in enumerate(mode_centers_1):
        samples_x = rng.normal(mode_center[0], stdevs_1[index], sample_no)
        samples_y = rng.normal(mode_center[1], stdevs_1[index], sample_no)
        mode_groups[1].modes.append(Mode(mode_center, samples_x, samples_y))
    plot.clear()

    for mode in mode_groups[0].modes:
        plot.scatter(mode.samples_x, mode.samples_y, s=10, marker='o', c='#32a852')
        plot.scatter(mode.center[0], mode.center[1], s=20, marker='o', c='#ff0000')

    for mode in mode_groups[1].modes:
        plot.scatter(mode.samples_x, mode.samples_y, s=10, marker='^', c='#a83277')
        plot.scatter(mode.center[0], mode.center[1], s=20, marker='^', c='#002aff')

    canvas.draw()


window = Tk()
window.title("AI Fundamentals")
window.geometry("1000x700")

Button(window, text="Generate", width=10, height=4, command=generate_plot, highlightbackground="green") \
    .grid(row=0, column=1, sticky=W)

Button(window, text="Exit", width=10, height=4, command=close_window, highlightbackground="red") \
    .grid(row=7, column=1, sticky=W)

Label(window, text="Mode number for class 0 (green): ").grid(row=1, column=1, sticky=W)
mode_no_entry_0 = Entry(window)
mode_no_entry_0.grid(row=2, column=1, sticky=W)

Label(window, text="Mode number for class 1 (purple): ").grid(row=3, column=1, sticky=W)
mode_no_entry_1 = Entry(window)
mode_no_entry_1.grid(row=4, column=1, sticky=W)

Label(window, text="Samples per mode number: ").grid(row=5, column=1, sticky=W)
sample_no_entry = Entry(window)
sample_no_entry.grid(row=6, column=1, sticky=W)

figure = Figure(figsize=(7, 7), dpi=100)
canvas = FigureCanvasTkAgg(figure, master=window)
plot = figure.add_subplot(1, 1, 1)
canvas.get_tk_widget().grid(row=0, rowspan=8, column=0, sticky=W)

window.mainloop()