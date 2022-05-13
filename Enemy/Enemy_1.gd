extends KinematicBody2D

var intensity = Global.enemy_1_intensity
var duration = Global.enemy_1_duration
var type = "Random"

var speed = Global.enemy_1_speed
var velocity = Vector2()
var input_vec = Vector2()
var misdirection = false
var swapped = false
var take_damage = true
var detected = false
var spawn_point 

var attack_lag = Global.enemy_1_lag

var misdirection_time = Global.misdirection

var path: Array = []
var levelNavigation : Navigation2D = null


func _ready():
	yield(get_tree(), "idle_frame")
	$Health.max_hp = 2
	$Health.hp = $Health.max_hp
	var _unused_value = $Health.connect("die",self,"die")
	var tree = get_tree()
	if tree.has_group("LevelNavigation"):
		levelNavigation = tree.get_nodes_in_group("LevelNavigation")[0]
		
	$Laser_hitbox/laser.visible = false
	$Laser_hitbox.monitoring = false
	$Laser_hitbox.monitorable = false
	
	$HealthBar.visible = false
	
	spawn_point = global_position
	
	look_at(Global.player.global_position)
	

func generate_path():
	if levelNavigation != null and Global.player != null:
		path = levelNavigation.get_simple_path(global_position,Global.player.global_position)
		
		
func navigate():
	if path.size() > 0:
		input_vec = global_position.direction_to(path[1])
		
		if global_position == path[0]:
			path.pop_front()


func take_damage(amount):
	if take_damage:
		take_damage = false
		$Health.got_damage(amount)
		$take_damage.start()


func _process(_delta):
	if $Health.hp < $Health.max_hp:
		$HealthBar.visible = true
		$HealthBar/ProgressBar.value = float($Health.hp)/$Health.max_hp * 100
		
		
func _physics_process(_delta):
	if Global.player and levelNavigation and detected:
		generate_path()
		navigate()
		
		look_at(Global.player.global_position)
		
		if !misdirection:
			velocity = input_vec * speed
		elif misdirection: 
			velocity = -input_vec * speed
		var _unused_value1 = move_and_slide(velocity)
		
	else:
		var direction = global_position.direction_to($Wander_controller.target_position)
		velocity = direction * speed
		var _unused_value2 = move_and_slide(velocity)
		
	
func _on_warp_detection_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if Input.is_action_pressed("warp"):
			swapped = true
			$AudioStreamPlayer2D2.play()
			var pre_position = global_position
			Global.player.velocity = Vector2()
			global_position = Global.player.global_position
			Global.player.global_position = pre_position
			get_tree().call_group("Enemy","stop_time")


func stop_time():
	set_process(false)
	set_physics_process(false)
	$Misdirection_timer.start(misdirection_time)


func _on_Misdirection_timer_timeout():
	set_process(true)
	set_physics_process(true)
	swapped = false


func _on_Player_detector_area_entered(area):
	if !$AnimationPlayer.is_playing():
		area.get_parent().being_sucked()
		$Attack_lag.start(attack_lag)


func _on_Player_detector_area_exited(_area):
	$Attack_lag.stop()


func _on_Attack_lag_timeout():
	set_process(false)
	set_physics_process(false)
	$AudioStreamPlayer2D.play()
	$AnimationPlayer.play("Laser")


func _on_Laser_hitbox_area_entered(area):
	if area.get_parent().is_in_group("Player"):
		var _unused_value = get_tree().reload_current_scene()
		

func finished_laser():
	set_process(true)
	set_physics_process(true)
	

func die():
	Global.shake(intensity,duration,type)
	queue_free()


func _on_take_damage_timeout():
	take_damage = true


func _on_Detection_area_entered(area):
	if area.get_parent().is_in_group("Player"):
		detected = true
		

func _on_Detection_area_exited(area):
	if area.get_parent().is_in_group("Player"):
		detected = false
