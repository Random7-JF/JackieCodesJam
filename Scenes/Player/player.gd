extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -350.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_double_jump: bool = true
var is_attacking: bool = false

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var attack_sword_area: Area2D = $AttackSword

func _process(_delta):
	update_animation()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if Input.is_action_just_pressed("jump") and can_double_jump:
			velocity.y = JUMP_VELOCITY
			can_double_jump = false
	else:
		can_double_jump = true

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

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
		
	if Input.is_action_just_pressed("attack"):
		is_attacking = true
		animation_tree["parameters/conditions/is_attacking"] = true


func _on_animation_tree_animation_finished(anim_name):
	print("anim_name: ", anim_name)
	if anim_name == "attack_sword_left" or anim_name == "attack_sword_right":
		is_attacking = false
		animation_tree["parameters/conditions/is_attacking"] = false
 
func get_is_attacking() -> bool:
	print("get_is_attacking")
	return is_attacking
