tool
extends Node2D
class_name Agent

onready var tween := $Tween

var freed := false

func _ready():
	pass

func _process(delta : float) -> void :
	update()

func _draw() -> void :
	draw_circle(Vector2.ZERO, 32.0, Color.darkcyan)

func move(target : Vector2, delay := 0.0) -> void :
	tween.interpolate_property(self, "position", position, target, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT, delay)
	tween.start()

func _on_Tween_tween_completed(object, key):
	tween.stop(object, key)
	if !freed :
		EventBus.emit_signal("queue_agent_placed", self)