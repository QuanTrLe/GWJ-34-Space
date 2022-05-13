extends Node

var hp = 1
var max_hp = 1

signal die


func _process(_delta):
	if hp > max_hp:
		hp = max_hp
	
	if hp <= 0:
		emit_signal("die")


func got_damage(amount):
	hp -= amount
