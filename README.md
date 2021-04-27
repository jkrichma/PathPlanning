# Path Planning Scripts for "Importance of Path Planning Variability: A Simulation Study"
# Jeff Krichmar, April, 2021
# University of California, Irvine

This repository contains the MATLAB scripts to run the path planning algorithms in the "Strategy Variation due to Cost of Traversal" section of our TopiCS paper.

To generate these results:
1) generateSimMaps.m - will create the maps shown in Figure 2.  Note these maps are already in the repository.
2) getSimStrategies.m - will run all path planning algorithms on all maps. Returns a matrix used by plotSimStrats.m Note the results are already in the repository.
3) plotSimStrats.m - will generate the histograms shown in Figure 10.

If you are interested in the different path planning algorithms, you can look at these scripts. Note that all scripts take a map as input, a start location, a goal location, and a flag that will display the trajectories if set to one. Currently, these scripts are called with the display flag set to zero.
	spikeWave.m - generates the least costly path for the given map.
	topoWave.m - generates a topological path using the given landmarks (lm)
	routeStrategySim - generates a path using the given familiar route. 
	routeWave.m - generates a path where the first half uses the familiar route and the second half uses a survey or topological strategy.


 
