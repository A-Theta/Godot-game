extends CharacterBody2D
@onready var anim_enemy: AnimatedSprite2D = $"anim-enemy"
const SPEED=150
const grav=980
const maxhealth=100
var health=maxhealth
@onready var del_timer: Timer = $del_timer
@onready var collision_hitbox: CollisionShape2D = $"hitbox/collision-hitbox"
@onready var ini_coll_x=collision_hitbox.position.x
var direction
var player_in=0
var player_out=0
var player2D:Vector2
var is_dead=0
var is_player_dead=0
var player_range_in
var player_range_out
func _ready() -> void:
	collision_hitbox.disabled=true
func _physics_process(delta: float) -> void:
	if !is_dead:
		if player_in && !player_out && !(player_range_in && !player_range_out):
			if position.x-player2D.x>0:
				anim_enemy.flip_h=false
				position.x=move_toward(position.x, player2D.x, SPEED*delta)
				anim_enemy.play("walk")
				collision_hitbox.position.x=ini_coll_x
			elif position.x-player2D.x<0:
				anim_enemy.flip_h=true
				position.x=move_toward(position.x, player2D.x, SPEED*delta)
				anim_enemy.play("walk")
				collision_hitbox.position.x=-ini_coll_x
			else:
				anim_enemy.play("idle")
		else:
			if player_range_in && !player_range_out && !is_player_dead:
				collision_hitbox.disabled=false
				anim_enemy.play("attack")
			else:
				if !is_on_floor():
					velocity.y=move_toward(velocity.y, grav, 60)
				anim_enemy.play("idle")
	move_and_slide()
func _on_hurtbox_hurt() -> void:
	if health!=0:
		health-=10
	elif health<=0:
		is_dead=1
		anim_enemy.play("death")
		del_timer.start()
func _on_del_timer_timeout() -> void:
	self.queue_free()
func _on_playerdetection_body_entered(body: Node2D) -> void:
	if body is player:
		player2D=body.position
		is_player_dead=body.is_dead
		player_in=1
		player_out=0
func _on_playerdetection_body_exited(body: Node2D) -> void:
	if body is player:
		is_player_dead=body.is_dead
		player2D=body.position
		player_in=0
		player_out=1
func _on_enemy_range_body_entered(body: Node2D) -> void:
	if body is player:
		is_player_dead=body.is_dead
		player_range_in=1
		player_range_out=0
func _on_enemy_range_body_exited(body: Node2D) -> void:
	if body is player:
		is_player_dead=body.is_dead
		player_range_in=0
		player_range_out=1
