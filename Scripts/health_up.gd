extends Node2D

@onready var hud = get_tree().get_nodes_in_group("HUD")[0]

func _ready():
	$AnimationPlayer.play("Idle")

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		if GameManager.lives < 3:
			var live_bar = hud.get_node("LiveBar")
			var lives = live_bar.get_children()
			lives[GameManager.lives].visible = true
			GameManager.lives += 1
		$AudioStreamPlayer.playing = true
		$AnimationPlayer.play("Get")
