extends MarginContainer

var current_selection = 0

onready var selector_one = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Label
onready var selector_two = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Label


func _ready():
	set_current_selection(current_selection)
	

func _process(_delta):
	if Input.is_action_just_pressed("down"):
		if current_selection == 1:
			current_selection = 0
		else:
			current_selection += 1
		set_current_selection(current_selection)
		
	elif Input.is_action_just_pressed("up"):
		if current_selection == 0:
			current_selection = 1
		else:
			current_selection -= 1
		set_current_selection(current_selection)
	
	elif Input.is_action_just_pressed("accept"):
		handle_selection(current_selection)
		
		
func handle_selection(current_selection):
	if current_selection == 0:
		var _unused_calue = get_tree().change_scene("res://Scenes/Level_1.tscn")
	elif current_selection == 1:
		var _unused_calue = get_tree().change_scene("res://Scenes/Main_Menu.tscn")
		

func set_current_selection(current_selection):
	selector_one.text = ""
	selector_two.text = ""
	
	if current_selection == 0:
		selector_one.text = ">"
	elif current_selection == 1:
		selector_two.text = ">"

	
