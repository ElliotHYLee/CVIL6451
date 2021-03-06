# dichromatic reflection model
The true repository will be linked after the publication.

The possible application can be light elimination/sepration from an observed scene.
## Prereq.s

Matlab
Tensorflow version
Kears

<a href = 'https://github.com/ElliotHYLee/CVIL6451/blob/master/manual.pdf'>
Please see manual.pdf
</a>


## Run
1. main_full.m: At the 2nd line of this file, try different imgIndex.<br>
This will run the full pipe line of the program. However, it requires dependencies. Also, depending on machine, the optimizer may stop early so error may be large. It may happen to cpu-based tensorflow library.

2. main_light.m: At the 2nd line of this file, try different imgIndex.<br>
This will show the result images. It is stand-alone.

## Quick Overview of The Results


<ul>
<img src="https://github.com/ElliotHYLee/CVIL6451/blob/master/Scripts/Images/md.jpg" width="400">
<img src="https://github.com/ElliotHYLee/CVIL6451/blob/master/Scripts/Images/cd.jpg" width="400">
<pre>
<div align='center'>
mD						     cD
</pre>
</div>
<br>
<img src="https://github.com/ElliotHYLee/CVIL6451/blob/master/Scripts/Images/ms.jpg" width="400">
<img src="https://github.com/ElliotHYLee/CVIL6451/blob/master/Scripts/Images/cs.jpg" width="400">
<br>
<pre>
<div align='center'>
mS						     cS
</pre>
</div>
<br>
<img src="https://github.com/ElliotHYLee/CVIL6451/blob/master/Scripts/Images/ld.jpg" width="400">
<img src="https://github.com/ElliotHYLee/CVIL6451/blob/master/Scripts/Images/ls.jpg" width="400">
<br>
<pre>
<div align='center'>
LD						     LS
</pre>
</div>
<br>
<img src="https://github.com/ElliotHYLee/CVIL6451/blob/master/Scripts/Images/observed.jpg" width="400">
<img src="https://github.com/ElliotHYLee/CVIL6451/blob/master/Scripts/Images/L.jpg" width="400">
<br>
<pre>
<div align='center'>
Observed					      LD+LS
</pre>
</div>
</ul>


