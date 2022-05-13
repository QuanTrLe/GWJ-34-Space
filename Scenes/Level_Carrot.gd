extends Node2D

export var scene_to : PackedScene


func _ready():
	Global.carrot = true
	
	
func _on_Interactable_body_entered(body):
	get_tree().change_scene("res://Scenes/Level_1.tscn")


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().change_scene("res://Scenes/Ending_C.tscn")
