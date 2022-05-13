extends MarginContainer

var current_selection = 0

const tutorial_menu = preload("res://Scenes/Tutorial_Menu.tscn")
const difficulty_menu = preload("res://Scenes/Difficulty_Menu.tscn")
const effect_menu = preload("res://Scenes/Effects_Menu.tscn")
const input_remapping = preload("res://Scenes/Input_mapping.tscn")

onready var selector_one = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Label
onready var selector_two = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Label
onready var selector_three = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer4/HBoxContainer/Label
onready var selector_four = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Label
onready var selector_five = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer5/HBoxContainer/Label


func _ready():
	Global.menu_music()
	Global.load_settings()
	set_current_selection(current_selection)
	

func _process(_delta):
	if Input.is_action_just_pressed("down"):
		if current_selection == 4:
			current_selection = 0
		else:
			current_selection += 1
		set_current_selection(current_selection)
		
	elif Input.is_action_just_pressed("up"):
		if current_selection == 0:
			current_selection = 4
		else:
			current_selection -= 1
		set_current_selection(current_selection)
	
	elif Input.is_action_just_pressed("accept"):
		handle_selection(current_selection)
		
		
func handle_selection(current_selection):
	if current_selection == 0:
		var _unused_calue = get_tree().change_scene_to(tutorial_menu)
	elif current_selection == 1:
		var _unused_calue = get_tree().change_scene_to(difficulty_menu)
	elif current_selection == 2:
		var _unused_calue = get_tree().change_scene_to(effect_menu)
	elif current_selection == 3:
		var _unused_calue = get_tree().change_scene_to(input_remapping)
	elif current_selection == 4:
		Global.save_settings()
		get_tree().quit()
		
		
func set_current_selection(current_selection):
	selector_one.text = ""
	selector_two.text = ""
	selector_three.text = ""
	selector_four.text = ""
	selector_five.text = ""
	
	if current_selection == 0:
		selector_one.text = ">"
	elif current_selection == 1:
		selector_two.text = ">"
	elif current_selection == 2:
		selector_three.text = ">"
	elif current_selection == 3:
		selector_four.text = ">"
	elif current_selection == 4:
		selector_five.text = ">"
	
