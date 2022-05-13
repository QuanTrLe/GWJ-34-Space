extends Node

const menu = preload("res://Scenes/Main_Menu.tscn")
var menu_music_toggle = false
const level = preload("res://Scenes/Level_1.tscn")
var level_music_toggle = false

var difficulty = true
var enemy_1_intensity = 2
var enemy_1_duration = 0.1
var enemy_2_intensity = 5
var enemy_2_duration = 0.15
var cannon_intensity = 1
var cannon_duration = 1.35

var shake_enabled = true
var camera_shake_intensity = 0.0
var camera_shake_duration = 0.0
var camera_shake_type = "Random"
var noise : OpenSimplexNoise

var player

var can_change_scene = false

var start_played_once = false
var boss_played_once = false
var boss_dead_played_once = false

var enemy_1_lag = 0.45
var enemy_2_lag = 0.5

var enemy_1_speed = 180
var enemy_2_speed = 150

var misdirection = 0.65

var carrot = false
var go_back = false
var can_go_back = true

var boss_dead = false

var filepath = "res://keybinds.ini"
var configfile
var keybinds = {}

var settings_file = "user://settings.save"

signal boss_death


func _ready():
	load_settings()
	
	configfile = ConfigFile.new()
	if configfile.load(filepath) == OK:
		for key in configfile.get_section_keys("keybinds"):
			var key_value = configfile.get_value("keybinds",key)
			
			if str(key_value) != "":
				keybinds[key] = key_value
			else:
				keybinds[key] = null
				
	else:
		print("Config file not found")
		get_tree().quit()
		
	noise = OpenSimplexNoise.new()
	noise.seed = randi()
	noise.octaves = 4
	noise.period = 20
	noise.persistence = 0.8
	
	set_game_binds()


func menu_music():
	if !menu_music_toggle:
		$AudioStreamPlayer2.stop()
		$AudioStreamPlayer.play()
		menu_music_toggle = true
		level_music_toggle = false


func level_music():
	if !level_music_toggle:
		$AudioStreamPlayer.stop()
		$AudioStreamPlayer2.play()
		level_music_toggle = true
		menu_music_toggle = false
	
	
func set_game_binds():
	for key in keybinds.keys():
		var value = keybinds[key]
		
		var actionlist = InputMap.get_action_list(key)
		if !actionlist.empty():
			InputMap.action_erase_event(key, actionlist[0])
		
		if value != null:
			var new_key = InputEventKey.new()
			new_key.set_scancode(value)
			InputMap.action_add_event(key,new_key)


func write_config():
	for key in keybinds.keys():
		var key_value = keybinds[key]
		if key_value != null:
			configfile.set_value("keybinds",key,key_value)
		else:
			configfile.set_value("keybinds",key,"")
	configfile.save(filepath)
	
	
func boss_death():
	if !boss_dead_played_once:
		boss_dead_played_once = true
		var new_dialog1 = Dialogic.start("Boss_death",false)
		add_child(new_dialog1)
		new_dialog1.connect("timeline_end",self,"after_dialog")
	

func after_dialog(_timeline_name):
	boss_dead = true
	emit_signal("boss_death")


func shake(intensity,duration, type):
	if !shake_enabled:
		intensity = 0
		
	elif intensity > camera_shake_intensity and duration > camera_shake_duration:
		camera_shake_intensity = intensity
		camera_shake_duration = duration
		camera_shake_type = type


func _process(delta):
	
	var camera = get_tree().current_scene.get_node("Camera2D")
	
	if camera_shake_duration <= 0:
		camera.offset = Vector2.ZERO
		camera_shake_intensity = 0.0
		camera_shake_duration = 0.0
		return
	
	camera_shake_duration -= delta
	
	var offset = Vector2.ZERO
	
	if camera_shake_type == camera_shake_type:
		offset = Vector2(randf(), randf()) * camera_shake_intensity
	
	camera.offset = offset
	
	
func save_settings():
	var f = File.new()
	f.open(settings_file, File.WRITE)
	f.store_var(shake_enabled)
	f.store_var(difficulty)
	f.close()


func load_settings():
	var f = File.new()
	if f.file_exists(settings_file):
		f.open(settings_file, File.READ)
		shake_enabled = f.get_var()
		difficulty = f.get_var()
		f.close()


