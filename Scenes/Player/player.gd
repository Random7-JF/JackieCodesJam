extends CharacterBody2D
class_name Player

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var attack_sword_area: Area2D = $AttackSword

@export var speed = 200.0
@export var jump_velocity = -350.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_double_jump: bool = true

var can_interact: bool = false
var keys: int = 0



func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		interact()		
	if Input.is_action_just_pressed("attack"):
		attack()
	update_animation()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		if Input.is_action_just_pressed("jump") and can_double_jump:
			velocity.y = jump_velocity
			can_double_jump = false
	else:
		can_double_jump = true

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

func interact():
	var objects = attack_sword_area.get_overlapping_areas()
	for object in objects:
		if object.get_parent().is_in_group("interactable"):
			object.get_parent().loot()
			break

func attack():
	animation_tree["parameters/conditions/is_attacking"] = true
	var objects = attack_sword_area.get_overlapping_areas()
	for object in objects:
		if object.is_in_group("breakable"):
			object.break_box()

func update_animation():
	var blend_value = velocity.normalized().x
	if not velocity == Vector2.ZERO:
		animation_tree["parameters/Run/blend_position"] = blend_value
		animation_tree["parameters/Attack_Sword/blend_position"] = blend_value
	if velocity == Vector2.ZERO:
		animation_tree["parameters/conditions/is_idling"] = true
		animation_tree["parameters/conditions/is_running"] = false
	else:
		animation_tree["parameters/conditions/is_idling"] = false
		animation_tree["parameters/conditions/is_running"] = true

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "attack_sword_left" or anim_name == "attack_sword_right":
		animation_tree["parameters/conditions/is_attacking"] = false
 
func add_key() -> void:
	keys += 1

func use_key() -> bool:
	if keys > 0:
		keys -= 1
		return true
	else:
		return false
