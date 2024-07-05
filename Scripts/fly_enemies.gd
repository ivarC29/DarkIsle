extends Path2D

@export var SPEED = 200
@onready var routes = get_children()

var is_in_screen = false

func _physics_process(delta):
	if !is_in_screen:
		return
	for route in routes:
		if route.get_class() == "PathFollow2D":
			await route.get_child(1).wake_up()
			if !route.get_child(1).dead:
				route.progress += SPEED * delta


func _on_visible_on_screen_notifier_2d_screen_entered():
	is_in_screen = true
  
