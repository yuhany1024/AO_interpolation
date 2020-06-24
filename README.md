# AO-pattern-interpolation-tools-for-remote-focusing
The codes can be used for AO pattern interpolation for remote focusing. We provide two approaches for the interpolation.
## 1. Modal approach
We fit the measured AO patterns(unwrapped) for the first 45 Zernike modes. We then interpolate the corresponding coefficent values for the desired focal shift.
## 2. Zonal approach
This method can only be applied to single-pupil-segmentation AO measurements(N Ji, et al(2010)). During the measurement, the back pupil is divided into multiple segments and we measure the phase gradient of each segment. The zonal approach fit and interpolate the phase gradints and then reconstruct the phase distribution  using the method introduced in S. I. Panagopoulou and D. P. Neal(2005).

We also provide some data to test the code under each folder.

## References
1. V. N. Mahajan and G. Dai, "Orthonormal polynomials in wavefront analysis: analytical solution," J. Opt. Soc. Am. A 24, 2994–3016 (2007).
2. M. A. Herráez, D. R. Burton, M. J. Lalor, and M. A. Gdeisat, "Fast two-dimensional phase-unwrapping algorithm based on sorting by reliability following a noncontinuous path," Applied Optics 41, 7437 (2002).
3. M. F. Kasim, "Fast 2D phase unwrapping implementation in MATLAB," GitHub (2017), https://github.com/mfkasim91/unwrap_phase.
