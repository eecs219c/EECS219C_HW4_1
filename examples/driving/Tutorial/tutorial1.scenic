param map = localPath('../../../tests/formats/opendrive/maps/CARLA/Town05.xodr')  # or other CARLA map that definitely works
param carla_map = 'Town05'
model scenic.simulators.newtonian.model

'''
This scenic program models a car trailing another car in front on the same lane. 

You will modify this scenic program for your HW4 Problem 2. 
Please keep the ego's position fixed as given.
Change the remainder of the code as instructed in HW4 Problem 2

We provided action, behavior, model libraries for you to reference to quickly model scenarios.
Please refer to /src/scenic/domains/driving/actions.py, behaviors.scenic, model.scenic to view
these libraries. 

Suggestion, please keep the target speed below 7 m/s to reduce unstable driving behavior. 
The PID controller is not perfect. 
'''
ego = Car at 210.74702858950224 @ 10.61841579738986, 
		with behavior FollowLaneBehavior(target_speed=7) # 10meters / sec

humanDriver = Car on ego.laneSection.centerline,
				with behavior FollowLaneBehavior(target_speed=5)

require 10 < (distance from humanDriver) < 15
require (distance from intersection) > 30
require humanDriver can see ego
