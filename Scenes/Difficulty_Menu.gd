extends MarginContainer

var current_selection = 0

onready var selector_two = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Label
onready var selector_three = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer4/HBoxContainer/Label
onready var selector_four = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer5/HBoxContainer/Label


func _ready():
	Global.load_settings()
	
	if Global.difficulty == true:
		$CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/OptionName.modulate = Color(255,0,0,255)
		$CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer4/HBoxContainer/OptionName.modulate = Color(0,0,0,1)
	elif Global.difficulty == false:
		$CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer4/HBoxContainer/OptionName.modulate = Color(255,0,0,255)
		$CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/OptionName.modulate = Color(0,0,0,1)
		
	set_current_selection(current_selection)
	

func _process(_delta):
	if Input.is_action_just_pressed("down") and current_selection < 2:
		current_selection += 1
		set_current_selection(current_selection)
		
	elif Input.is_action_just_pressed("up") and current_selection > 0:
		current_selection -= 1
		set_current_selection(current_selection)
	
	elif Input.is_action_just_pressed("accept"):
		handle_selection(current_selection)
		

func handle_selection(current_selection):
	if current_selection == 0:
		Global.enemy_1_lag = 0.55
		Global.enemy_2_lag = 0.6
		Global.enemy_1_speed = 170
		Global.enemy_2_speed = 140
		Global.misdirection = 0.75
		$CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/OptionName.modulate = Color(255,0,0,255)
		$CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer4/HBoxContainer/OptionName.modulate = Color(0,0,0,1)
		Global.difficulty = true
		Global.save_settings()
		
	elif current_selection == 1:
		Global.enemy_1_lag = 0.3
		Global.enemy_2_lag = 0.35
		Global.enemy_1_speed = 210
		Global.enemy_2_speed = 180
		Global.misdirection = 0.4
		$CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer4/HBoxContainer/OptionName.modulate = Color(255,0,0,255)
		$CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/OptionName.modulate = Color(0,0,0,1)
		Global.difficulty = false
		Global.save_settings()
		
	elif current_selection == 2:
		Global.save_settings()
		var _unused_calue = get_tree().change_scene("res://Scenes/Main_Menu.tscn")

	
func set_current_selection(current_selection):
	selector_two.text = ""
	selector_three.text = ""
	selector_four.text = ""
	
	if current_selection == 0:
		selector_two.text = ">"
	elif current_selection == 1:
		selector_three.text = ">"
	elif current_selection == 2:
		selector_four.text = ">"
	
