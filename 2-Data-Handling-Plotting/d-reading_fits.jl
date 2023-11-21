using FITSIO
using Plots

# Set the file and provide general Metadata
fits550 = FITS("2-Data-Handling-Plotting/data/hst_9973_6a_acs_hrc_f550m_drz.fits")

# Show the metadata of the 2nd channel
fits550[2]

# read the second channel 
data550 = read(fits550[2])

plot(data550[500,1:end])

heatmap(data550, clim=(0,200))

lowcut = 10^-2
heatmap(map(x->x>lowcut ? log10(x) : log10(lowcut), data550), clim=(-2,4))
