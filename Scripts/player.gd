class_name player
extends CharacterBody2D
@onready var anim_player: AnimatedSprite2D = $"anim-player"
const SPEED=450
const grav=980
const jump_vel = -1000
const maxhealth=100
var health=maxhealth
@onready var heal_timer: Timer = $heal_timer
@onready var collision_hitbox: CollisionShape2D = $"hitbox/collision-hitbox"
@onready var ini_hitbox_x=collision_hitbox.position.x
@onready var game_over: Node2D = $"Camera2D/GAME-OVER"
var direction
var is_dead
var go_main_menu
var restart_game
func _ready() -> void:
	game_over.visible=false
func _physics_process(_delta: float) -> void:
	if !is_dead:
		if Input.is_action_pressed("right"):
			velocity.x=move_toward(velocity.x,SPEED, SPEED)
			if is_on_floor():anim_player.play("walk")
			anim_player.flip_h=false
			collision_hitbox.position.x= ini_hitbox_x
		elif Input.is_action_pressed("left"):
			velocity.x=move_toward(velocity.x,-SPEED, SPEED)
			if is_on_floor():anim_player.play("walk")
			anim_player.flip_h=true
			collision_hitbox.position.x= -ini_hitbox_x
		else:
			velocity.x=move_toward(velocity.x,0, SPEED)
			if is_on_floor():
				if Input.is_action_pressed("attack") && !is_dead:
					anim_player.play("attack")
					collision_hitbox.disabled=0
				else:
					collision_hitbox.disabled=1
					anim_player.play("idle")
		if is_on_floor() && Input.is_action_pressed("up"):
			velocity.y=move_toward(velocity.y, jump_vel, 3000)
		if !is_on_floor():
			velocity.y=move_toward(velocity.y, grav, 60)
			anim_player.play("jump")
	else:
		if anim_player.frame!=10:
			anim_player.play("death")
		else:
			anim_player.frame=10
	if health < 100:
		heal_timer.start()
	move_and_slide()
func _on_hurt_box_hurt() -> void:
	if health!=0:
		health-=10
		is_dead=false
	elif health<=0:
		is_dead=true
		game_over.visible=true
func _on_heal_timer_timeout() -> void:
	if !(health+10>100):
		health+=10
func _on_gameover_go_main_menu() -> void:
	go_main_menu=1
	restart_game=0
func _on_gameover_restart_game() -> void:
	restart_game=1
	go_main_menu=0
