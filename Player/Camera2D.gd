extends Camera2D


func _ready():
	limit_left = $Limits/Top_left.position.x
	limit_top = $Limits/Top_left.position.y
	limit_right = $Limits/Bottom_right.position.x
	limit_bottom = $Limits/Bottom_right.position.y

