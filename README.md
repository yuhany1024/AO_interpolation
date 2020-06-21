# AO-pattern-interpolation-tools-for-remote-focusing
The codes can be used for AO pattern interpolation for remote focusing. We provide two approaches for the interpolation.
## 1. Modal approach
We fit the measured AO patterns(unwrapped) for the first 45 Zernike modes. We then interpolate the corresponding coefficent values for the desired focal shift.
## 2. Zonal approach
This method can only be applied to single-pupil-segmentation AO measurements(N Ji, et al(2010)). During the measurement, the back pupil is divided into multiple segments and we measure the phase gradient of each segment. The zonal approach fit and interpolate the phase gradints and then reconstruct the phase distribution  using the method introduced in S. I. Panagopoulou and D. P. Neal(2005).

We also provide some data to test the code under each folder.
