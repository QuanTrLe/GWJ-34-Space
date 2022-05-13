extends Node2D

export(int) var wander_range = 32

onready var start_position = global_position
onready var target_position = global_position
	
	
func update_target():
	var rand_choice = randi()%2
	var target_vector = Vector2.ZERO
	
	var rand_x = rand_range(-wander_range,wander_range)
	var rand_y = rand_range(-wander_range,wander_range)
	
	if rand_choice == 0:
		target_vector = Vector2(rand_x,rand_y)
	elif rand_choice == 1:
		target_vector = Vector2.ZERO
		
	target_position = start_position + target_vector 


func _on_Timer_timeout():
	update_target()
	$Timer.start()
