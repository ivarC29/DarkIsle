extends CharacterBody2D

# Exported variables
@export var speed = 40.0
@export var max_health = 10
@export var damage = 2
@export var can_take_damage = true
@onready var detection_area = $PlayerDetection
@onready var attack_area = $AttackArea
@onready var hit_box = $HitBox
@onready var sprite = $Sprite2D
var win_screen = "res://Scenes/UI/win.tscn"
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Internal variables
var current_health
var player_detected = false
var can_attack = true
var player_near = false

var facing_right = false
var current_speed = 0.0
var dead = false
var hit = false
# Animation states
enum {
	STATE_IDLE,
	STATE_RUN,
	STATE_SCARE_RUN,
	STATE_ATTACK,
	STATE_JUMP,
	STATE_FALL,
	STATE_HIT,
	STATE_DEAD_HIT,
	STATE_DEAD_GROUND
}

var state = STATE_IDLE

@onready var animation_player = $AnimationPlayer

func _ready():
	current_health = max_health

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	match state:
		STATE_IDLE:
			_handle_idle_state()
		STATE_RUN:
			_handle_run_state()
		STATE_SCARE_RUN:
			_handle_scare_run_state()
		STATE_ATTACK:
			_handle_attack_state()
		STATE_JUMP:
			_handle_jump_state()
		STATE_FALL:
			_handle_fall_state()
		STATE_HIT:
			_handle_hit_state()
		STATE_DEAD_HIT:
			_handle_dead_hit_state()
		STATE_DEAD_GROUND:
			_handle_dead_ground_state()
	if player_detected and !dead:	
		velocity.x = speed
		move_and_slide()

func _handle_idle_state():
	if player_detected:
		state = STATE_RUN
	else:
		animation_player.play("Idle")

func _handle_run_state():
	animation_player.play("Run")
	if player_near and can_attack:
		state = STATE_ATTACK

func _handle_scare_run_state():
	if can_attack:
		state = STATE_ATTACK
	else:
		animation_player.play("ScareRun")

func _handle_attack_state():
	animation_player.play("Attack")

func _handle_jump_state():
	animation_player.play("Jump")

func _handle_fall_state():
	animation_player.play("Fall")

func _handle_hit_state():
	can_attack = false
	animation_player.play("Hit")

func _handle_dead_hit_state():
	animation_player.play("DeadHit")
	state = STATE_DEAD_GROUND
	dead = true

func _handle_dead_ground_state():
	animation_player.play("DeadGround")
	
# Signals
func _on_player_detection_area_entered(area):
	if area.get_parent() is Player and !dead:
		check_player_position(area)
		player_detected = true
		
func _on_player_detection_area_exited(area):
	if area.get_parent() is Player and !dead:
		player_detected = false
		state = STATE_IDLE
		
func _on_attack_area_area_entered(area):
	if area.get_parent() is Player and !dead and can_attack:
		player_near = true
		_deal_damage(area.get_parent())

func _on_attack_area_area_exited(area):
	if area.get_parent() is Player and !dead:
		player_near = false
		state = STATE_RUN

# Actions
func flip():
	facing_right = !facing_right
	scale.x =abs(scale.x) 
	if facing_right:
		speed = abs(speed)
		sprite.scale.x = abs(sprite.scale.x)
		$AttackArea.scale.x = abs(sprite.scale.x)
	else:
		speed = abs(speed) * -1
		sprite.scale.x = abs(sprite.scale.x) * -1 
		$AttackArea.scale.x = abs(sprite.scale.x) * -1 

func check_player_position(player):
	if facing_right and player.global_position.x < global_position.x:
		flip()
	elif not facing_right and player.global_position.x > global_position.x:
		flip()

func take_damage(amount):
	if dead and !can_take_damage:
		return
	can_take_damage = false
	current_health -= amount
	print("Danio: ", amount)
	print("Vida: ", current_health)
	get_node("HealthBar").update_healthbar(current_health, max_health)
	if current_health <= 0:
		state = STATE_DEAD_HIT
	elif current_health <= 5:
		state = STATE_SCARE_RUN
	else:
		state = STATE_HIT

func _deal_damage(entity):
	can_attack = false
	entity.take_damage(damage)
	can_attack = true
	
func win():
	get_tree().change_scene_to_file(win_screen)
	







