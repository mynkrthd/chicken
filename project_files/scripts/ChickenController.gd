extends CharacterBody2D


@export var SPEED = 500.0;
@export var DASH_SPEED = 1000;
@export var CURRENT_HEALTH = 100;
@export var MAX_HEALTH = 100;
@export_range(0.0, 1.5) var SKEW_AMOUNT = 0.0;

@onready var dash_timer = $CharacterAnchor/DashTimer
@onready var can_dash_timer = $CharacterAnchor/CanDashTimer
@onready var character_anchor = $CharacterAnchor
@onready var chicken_sprite = $CharacterAnchor/Chicken
@onready var gun_anchor = $CharacterAnchor/GunAnchor
@onready var front_vector = $CharacterAnchor/frontVector

var dashing = false;
var can_dash = true;

func get_input():
	#Movement input
	#Calculating the unit vector of the direction into which to move and multipling it with speed
	var input_direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown");
	
	#Checking if dash key is pressed
	if Input.is_action_just_pressed("Dash") && !dashing && can_dash:
		dashing = true;
		can_dash = false;
		can_dash_timer.start();
		dash_timer.start();
	#Flipping character horizontally according to the movement key pressed
	if Input.is_action_pressed("MoveLeft"):
		if character_anchor.scale.x > 0:
			character_anchor.scale.x *= -1;
	elif Input.is_action_pressed("MoveRight"):
		if character_anchor.scale.x < 0:
			character_anchor.scale.x *= -1;
	
	#Adding skew to the chicken sprite when moving
	chicken_sprite.skew = SKEW_AMOUNT * velocity.normalized().length();
	
	#Aiming
	#Calculating normalized mouse and forward vector to calculate dot product
	#Using dot product to difference between mouse position and character forward direction
	#using the difference to flip gun so it always looks correct and not flipped
	var mouse_pos_vector = Vector2(get_local_mouse_position().x, get_local_mouse_position().y).normalized();
	var forward_vector = Vector2(front_vector.position.x, front_vector.position.y).normalized();
	if (character_anchor.scale.x > 0):
		if mouse_pos_vector.dot(forward_vector) >= 0:
			if gun_anchor.scale.y < 0:
				gun_anchor.scale.y *= -1;
		elif mouse_pos_vector.dot(forward_vector) < 0:
			if gun_anchor.scale.y > 0:
				gun_anchor.scale.y *= -1;
	else:
		if mouse_pos_vector.dot(forward_vector) >= 0:
			if gun_anchor.scale.y > 0:
				gun_anchor.scale.y *= -1;
		elif mouse_pos_vector.dot(forward_vector) < 0:
			if gun_anchor.scale.y < 0:
				gun_anchor.scale.y *= -1;
	
	gun_anchor.look_at(get_global_mouse_position());
	print("Character Anchor Scale: ", character_anchor.scale);
	print("Dot Product: ", mouse_pos_vector.dot(forward_vector), " ; Gun Ancor Scale: ", gun_anchor.scale);
	
	if dashing:
		velocity = input_direction * DASH_SPEED;
	else:
		velocity = input_direction * SPEED;
	

func _physics_process(delta):
	get_input();
	move_and_slide();


func _on_dash_timer_timeout():
	dashing = false;


func _on_can_dash_timer_timeout():
	can_dash = true;
