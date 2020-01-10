extends Button

func _ready() -> void :
	connect("pressed", self, "_on_Add_pressed")

func _on_Add_pressed() -> void :
	var agent = preload("res://Agent.tscn").instance()
	EventBus.emit_signal("queue_add", agent)