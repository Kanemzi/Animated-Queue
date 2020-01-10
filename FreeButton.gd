extends Button

func _ready() -> void :
	connect("pressed", self, "_on_Free_pressed")

func _on_Free_pressed() -> void :
	EventBus.emit_signal("queue_free")