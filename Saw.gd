extends StaticBody2D


func _process(_delta):
	rotation_degrees += 120


func _on_Area2D_area_entered(area):
	if area.get_parent().is_in_group("Player"):
		var _unused_value = get_tree().reload_current_scene()
	
