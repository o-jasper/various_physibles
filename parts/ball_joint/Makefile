
default:scad

all: scad

scad: output/joint_petal.stl output/joint_flower.stl output/joint_ball.stl output/joint_cover.stl

output/joint_petal.stl: ball_joint.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/ball_joint.scad>;joint_petal();'\
		output/joint_petal.stl

output/joint_flower.stl: ball_joint.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/ball_joint.scad>;joint_flower();'\
		output/joint_flower.stl

output/joint_ball.stl: ball_joint.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/ball_joint.scad>;joint_ball();'\
		output/joint_ball.stl

output/joint_cover.stl: ball_joint.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/ball_joint.scad>;flower_cover();'\
		output/joint_cover.stl
