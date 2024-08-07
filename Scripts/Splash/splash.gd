extends Node2D

@onready var animationPionners: AnimationPlayer = $AnimationPixelPionners
@onready var animationEndless: AnimationPlayer = $AnimationEndLess
@onready var animationPixelFrog: AnimationPlayer = $AnimationPixelFrog

var _main_scene = "res://Scenes/UI/main_screen.tscn"

func _ready():
	animationPionners.play("Do")

func _input(event):
	if event is InputEventKey:
		_go_first_scene()
		
func _go_first_scene():
	get_tree().change_scene_to_file(_main_scene)

func _on_animation_pixel_pionners_animation_finished(_anim_name):
	animationEndless.play("Do")


func _on_animation_end_less_animation_finished(_anim_name):
	animationPixelFrog.play("Do")
	await get_tree().create_timer(4).timeout
	_go_first_scene()
