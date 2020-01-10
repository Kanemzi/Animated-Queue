tool
extends Position2D

func _ready():
	pass

func _process(delta : float) -> void :
	update()

func _draw() -> void :
	if get_index() < get_parent().get_child_count() - 1:
		var next := get_parent().get_child(get_index() + 1)
		draw_line(Vector2.ZERO, next.position - position, Color.white, 4.0, true)
	
	draw_line(Vector2(-20, 0), Vector2(20, 0), Color.darkgray, 4.0, true)
	draw_line(Vector2(0, -20), Vector2(0, 20), Color.darkgray, 4.0, true)

