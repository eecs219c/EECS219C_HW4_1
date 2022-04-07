param map = localPath('../../../tests/formats/opendrive/maps/CARLA/Town05.xodr')  # or other CARLA map that definitely works
param carla_map = 'Town05'
model scenic.simulators.newtonian.model

'''
This program is just for a reference, not modification. 
This scenario models a cut-in situation. 

You can also reference road information using the object "network" whose road constructs
such as laneSection, lane, intersection, etc., are defined in src/scenic/domains/driving/roads.py
'''

laneSecWithRightLane = filter(lambda i: i._laneToRight, network.laneSections)
selectedLaneSec = Uniform(*laneSecWithRightLane)

behavior humanBehavior():
	print("you can print info for debugging purpose")
	print("ego's position: ", ego.position) # for attribute info, please refer to /src/scenic/domains/driving/model.scenic
	try:
		do FollowLaneBehavior(target_speed = 7)
	interrupt when (ego can see self) and Range(5,8) < (distance to humanDriver) < 10:
		do LaneChangeBehavior(ego.laneSection)
		abort
	do FollowLaneBehavior(target_speed = 7)

ego = Car on selectedLaneSec._laneToRight.centerline,
		with behavior FollowLaneBehavior(target_speed = 2)

humanDriver = Car on selectedLaneSec.centerline,
				with behavior humanBehavior()

require 5 < (distance from humanDriver) < 10
require (distance from intersection) > 30
require humanDriver can see ego