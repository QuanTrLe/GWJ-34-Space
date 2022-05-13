extends Sprite

var intensity = 20
var duration = 0.2
var type = "Random"

func _on_warp_detection_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if Input.is_action_pressed("warp") and Global.boss_played_once:
			var pre_position = global_position
			Global.player.velocity = Vector2()
			global_position = Global.player.global_position
			Global.player.global_position = pre_position


