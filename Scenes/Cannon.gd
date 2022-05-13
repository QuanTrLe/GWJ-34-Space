extends Sprite

var intensity = Global.cannon_intensity
var duration = Global.cannon_duration
var type = "Random"


func _ready():
	frame = 0
	$laser_hitbox.monitoring = false
	$laser_hitbox.monitorable = false
	$Laser.visible = false


func play_animation():
	$AnimationPlayer.play("shoot")


func blast_sound():
	$AudioStreamPlayer.play()
	

func _on_laser_hitbox_area_entered(area):
	if area.get_parent().is_in_group("Player"):
		var _unused_value = get_tree().reload_current_scene()
	elif area.get_parent().is_in_group("Enemy"):
		Global.boss_death()


func shake():
	Global.shake(intensity,duration,type)
