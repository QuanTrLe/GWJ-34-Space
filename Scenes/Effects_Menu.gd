extends MarginContainer

var current_selection = 0

const game = preload("res://Scenes/Level_1.tscn")
const difficulty_menu = preload("res://Scenes/Difficulty_Menu.tscn")


onready var selector_one = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Label
onready var selector_two = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Label
onready var selector_three = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer4/HBoxContainer/Label


func _ready():
	Global.load_settings()
	
	if Global.shake_enabled:
		$CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/OptionName.modulate = Color(0,0,0,1)
		$CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/OptionName.modulate = Color(255,0,0,255)
	else:
		$CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/OptionName.modulate = Color(255,0,0,255)
		$CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/OptionName.modulate = Color(0,0,0,1)
		
	set_current_selection(current_selection)
	

func _process(_delta):
	if Input.is_action_just_pressed("down") and current_selection < 2:
		$AudioStreamPlayer2.play()
		current_selection += 1
		set_current_selection(current_selection)
		
	elif Input.is_action_just_pressed("up") and current_selection > 0:
		$AudioStreamPlayer2.play()
		current_selection -= 1
		set_current_selection(current_selection)
	
	elif Input.is_action_just_pressed("accept"):
		$AudioStreamPlayer.play()
		handle_selection(current_selection)
		
		
func handle_selection(current_selection):
	if current_selection == 0:
		$CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/OptionName.modulate = Color(0,0,0,1)
		$CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/OptionName.modulate = Color(255,0,0,255)
		Global.shake_enabled = true		
		Global.save_settings()
		
	elif current_selection == 1:
		$CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/OptionName.modulate = Color(255,0,0,255)
		$CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/OptionName.modulate = Color(0,0,0,1)
		Global.shake_enabled = false
		Global.save_settings()
		
	elif current_selection == 2:
		var _unused_calue = get_tree().change_scene("res://Scenes/Main_Menu.tscn")
		Global.save_settings()
		
	Global.load_settings()
	
		
func set_current_selection(current_selection):
	selector_one.text = ""
	selector_two.text = ""
	selector_three.text = ""
	
	if current_selection == 0:
		selector_one.text = ">"
	elif current_selection == 1:
		selector_two.text = ">"
	elif current_selection == 2:
		selector_three.text = ">"
