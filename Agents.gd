extends Node2D

func get_first() -> Agent :
	if get_child_count() == 0 : return null
	return get_child(0) as Agent