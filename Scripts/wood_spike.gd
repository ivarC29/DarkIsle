extends Node2D

var direction
var speed = 200.0
var lifetime = 2.0
var hit = false

func _ready():
	await get_tree().create_timer(lifetime).timeout
	destroyed()
	
func _physics_process(delta):
	position.x += abs(speed * delta) * direction
	
func destroyed():
	hit = true
	speed = 0
	$AnimationPlayer.play("Destroyed")


func _on_area_2d_area_entered(area):
	if area.get_parent() is Player && !hit:
		area.get_parent().take_damage(2)
		destroyed()
