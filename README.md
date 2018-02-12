# dichromatic reflection model

Uploaded for Civil 6451 Mid term 1


## ToDo
1. Running Manual

## Prereq.s

Matlab
Tensorflow version
Kears


python libraries:

```
chmod +x pythonReady.sh
yes "yes" | sudo sh pythonReady.sh
```
## Run


## Quick Overview of The Results



## Traing Results

description

<ul>
<img src="https://github.com/ElliotHYLee/CVIL6451/blob/master/Try2/Images/md.jpg" width="400">
<img src="https://github.com/ElliotHYLee/CVIL6451/blob/master/Try2/Images/cd.jpg" width="400">
<img src="https://github.com/ElliotHYLee/CVIL6451/blob/master/Try2/Images/ms.jpg" width="400">
<img src="https://github.com/ElliotHYLee/CVIL6451/blob/master/Try2/Images/cs.jpg" width="400">

</ul>

## Test Results

The first three predictions' mse = [0.611, 0.726, 1.162] meters per frame. One cause can be the texture-lacking environments of the sequence 1,3, and 4. Anouther is that these sequences have only a few hundreds data points. Even though these are trained, the generalization is limited. <br>

Yet, if the model is fed with "similar" environement, mse is not too irrational. For the rest of the sets, mse = [0.381 0.419 0.461 0.632]

<ul>
<img src="https://github.com/ElliotHYLee/OpticalFlow2VelocityEstimation/blob/master/Images/seq1.png" width="400">
<img src="https://github.com/ElliotHYLee/OpticalFlow2VelocityEstimation/blob/master/Images/seq3.png" width="400">
<img src="https://github.com/ElliotHYLee/OpticalFlow2VelocityEstimation/blob/master/Images/seq4.png" width="400">
<img src="https://github.com/ElliotHYLee/OpticalFlow2VelocityEstimation/blob/master/Images/seq5.png" width="400">
<img src="https://github.com/ElliotHYLee/OpticalFlow2VelocityEstimation/blob/master/Images/seq6.png" width="400">
<img src="https://github.com/ElliotHYLee/OpticalFlow2VelocityEstimation/blob/master/Images/seq7.png" width="400">
<img src="https://github.com/ElliotHYLee/OpticalFlow2VelocityEstimation/blob/master/Images/seq10.png" width="400">
</ul>

