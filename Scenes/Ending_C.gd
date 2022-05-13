extends Node2D


func _ready():
		var new_dialog = Dialogic.start("Ending_C",false)
		add_child(new_dialog)
		new_dialog.connect("timeline_end",self,"after_dialog")


func after_dialog(_timeline_name):
	get_tree().change_scene("res://Scenes/Main_Menu.tscn")
