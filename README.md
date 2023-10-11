# train-scripts-argos
These scripts display the current speed, internet speed (if available), and information about the next station as arrival time, delay, and name in the top panel of GNOME. 
These scripts require [argos](https://github.com/p-e-w/argos) to run. 
The following cli tools are also required: curl, jq, wc

## Usage
Place the scripts in `~/.config/argos`.
Currently the scripts show `NIT` when you are **n**ot **i**n a **t**rain.
Running ICE and ÖBB scripts at the same time will also result in at least two NIT being displayed.
The best experience at the moment is to move the scripts to a subdirectory when you are not on these types of trains.
