extends Node2D
class_name Queue

onready var pool : Node2D = $Agents
var slots : Array
var locked : bool = false
var waiting_lock : int = 0

func _ready():
	EventBus.connect("queue_add", self, "_on_Queue_add")
	EventBus.connect("queue_free", self, "_on_Queue_free")
	EventBus.connect("queue_agent_placed", self, "_on_Queue_agent_placed")
	slots = $Slots.get_children()

func _process(delta : float) -> void :
	update()

func _queue_advance() -> void :
	var delay = 0.0
	for agent in pool.get_children() :
		if agent.get_index() < slots.size() :
			var target := _get_corresponding_slot(agent).position
			agent.move(target, delay)
			delay += 0.2

func _on_Queue_add(agent: Agent) -> void :
	if locked : return
	if agent == null : return
	if slots.size() <= 0 : return
	
	var slot : Position2D  = slots[slots.size() - 1] as Position2D
	agent.position = Vector2(slot.position.x, slot.position.y)
	pool.add_child(agent)
	
	if agent.get_index() < slots.size() :
		var target := _get_corresponding_slot(agent).position
		agent.move(target)
		lock()

func _on_Queue_free() -> void :
	if locked : return
	var agent = pool.get_first()
	if agent != null:
		pool.remove_child(agent)
		get_tree().get_root().get_node("Scene/Space").add_child(agent)
		agent.move(Vector2(1100, 200 + randi() % 600))
		agent.freed = true
		_queue_advance()
		var count = pool.get_child_count()
		if count > 0 : lock(min(count, slots.size()))

func _on_Queue_agent_placed(agent : Agent) -> void :
	waiting_lock -= 1
	if waiting_lock <= 0 :
		unlock()

func lock(wl := 1) -> void :
	locked = true
	waiting_lock = wl

func unlock() -> void :
	locked = false

func _get_corresponding_slot(agent : Agent) -> Position2D :
	var i = agent.get_index()
	var slot_id := min(i, slots.size() - 1)
	return slots[slot_id] as Position2D