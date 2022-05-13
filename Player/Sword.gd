extends Node2D

var can_swing = true


func _ready():
	$Sword.rotation_degrees = 0
	$Sword.enabled = false


func _process(_delta):
	if Input.is_action_just_pressed("swing") and can_swing:
		can_swing = false
		$Swing_timer.start()
		if $Sword.rotation_degrees == 0:
			$AnimationPlayer.play("swing_left")
			$AudioStreamPlayer.play()
		else:
			$AnimationPlayer.play("swing_right")
			$AudioStreamPlayer.play()
	
	if $Sword.is_colliding():
		if $Sword.get_collider().is_in_group("Enemy"):
			var target = $Sword.get_collider()
			$AudioStreamPlayer2.play()
			target.take_damage(1)
			

func _on_Swing_timer_timeout():
	can_swing = true
