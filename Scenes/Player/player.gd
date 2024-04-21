extends CharacterBody2D
class_name Player

const SPEED = 200.0
const JUMP_VELOCITY = -350.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_double_jump: bool = true

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var attack_sword_area: Area2D = $AttackSword

func _process(_delta):
	if Input.is_action_just_pressed("attack"):
		attack()

	update_animation()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		if Input.is_action_just_pressed("jump") and can_double_jump:
			velocity.y = JUMP_VELOCITY
			can_double_jump = false
	else:
		can_double_jump = true

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

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
	print("anim_name: ", anim_name)
	if anim_name == "attack_sword_left" or anim_name == "attack_sword_right":
		animation_tree["parameters/conditions/is_attacking"] = false
 
