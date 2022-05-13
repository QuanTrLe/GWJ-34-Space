extends KinematicBody2D

const SPEED = 550
const ACCELERATION = 2900
const FRICTION = 3100

var input_vec = Vector2()
var velocity = Vector2()

var sucked = false
var Sword = preload("res://Player/Sword.tscn")


func _ready():
	Global.player = self
	var sword = Sword.instance()
	add_child(sword)

	
func _process(_delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()


func _physics_process(delta):
	input_vec.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vec.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vec = input_vec.normalized()
	
	if input_vec != Vector2() and !sucked:
		velocity = velocity.move_toward(input_vec * SPEED, ACCELERATION * delta)
	elif input_vec != Vector2() and sucked:
		velocity = velocity.move_toward(input_vec * SPEED * 0.7, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2() , FRICTION * delta)
	var _unused_value = move_and_slide(velocity)


func being_sucked():
	sucked = true
	$Suck_timer.start()


func _on_Suck_timer_timeout():
	sucked = false
	
