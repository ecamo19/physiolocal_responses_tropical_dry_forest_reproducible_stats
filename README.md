# Reproducibility

This repository contains all the raw data and code used in the paper titled:

"Physiological and growth responses of tropical dry forest tree seedlings 
to water and nutrient additions".

You can report any issue with the repository to erickcamo19@gmail.com

Or visit the github repository at https://github.com/ecamo19/physiolocal_responses_tropical_dry_forest_reproducible_statss

For reproducing the results in the repository, two options have been implemented: 

## 1) Binder

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/ecamo19/physiolocal_responses_tropical_dry_forest_reproducible_stats/HEAD)

To run the binder enviroment visit the webside: 

https://mybinder.org/v2/gh/ecamo19/physiolocal_responses_tropical_dry_forest_reproducible_stats/HEAD. 

The link will take you to a binder repository where the code can be run. 

The image takes approximately __10-20 minutes to build__.

Inside the repository, go to the folder called notebooks. There you will find 
_.html_ and  _.ipynb_ files. Both contain the same code, their only difference 
is that the _.ipynb_ files can be used to execute and modify the code. 

__Press `crtl + enter` to run each cell (chunk) inside the .ipynb notebooks.__

## 2) Pixi dev

First, you have to install pixi into your local machine. To do it, please follow 
the developers guide found at https://pixi.sh/latest/. 

Second, download this repository. Do not modify anything inside the folder.

You can download the github repository by entering: 

`git clone ecamo19/physiolocal_responses_tropical_dry_forest_reproducible_stats`

In your terminal (macOS or Linux) or your command prompt (windows) set the 
working to the downloaded repository.

For example, if you downloaded the repository to your Downloads folder, enter:

`cd ~/Downloads/physiolocal_responses_tropical_dry_forest_reproducible_stats/`

Once you have setup your the working directory to the downloaded repository, 
enter:

`pixi shell` 

and then, to view the code enter: 

`pixi run jupyter notebook`
