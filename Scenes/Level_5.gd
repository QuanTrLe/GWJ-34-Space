extends Node2D

export var scene_to : PackedScene
var cannon 


func _ready():
	Global.can_change_scene = false
	
	var _unused_value = Global.connect("boss_death",self,"boss_death")
	var new_dialog = Dialogic.start("Boss",false)
	add_child(new_dialog)
	new_dialog.connect("timeline_end",self,"after_dialog")
	
	
func after_dialog(_timeline_name):
	Global.boss_played_once = true
	$Cannon_timer.start()


func roll_for_cannon():
	cannon = randi()%3
	
	if cannon == 1:
		$Cannon.play_animation()
	elif cannon == 2:
		$Cannon2.play_animation()
	elif cannon == 0:
		$Cannon3.play_animation()
	
	$Cooldown.start()
	
	
func _on_Cannon_timer_timeout():
	roll_for_cannon()


func _on_Cooldown_timeout():
	$Cannon_timer.start()
	

func boss_death():
	Global.can_change_scene = true
	$Enemy/DrBrain.queue_free()


func _on_Interactable_area_entered(area):
	if area.get_parent().is_in_group("Player") and Global.can_change_scene and Global.boss_dead:
		get_tree().change_scene("res://Scenes/Ending_H.tscn")
