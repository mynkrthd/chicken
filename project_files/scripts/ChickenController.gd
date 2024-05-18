extends CharacterBody2D


@export var SPEED = 500.0;
@export var DASH_SPEED = 900;
@export_range(0.0, 1.5) var SKEW_AMOUNT = 0.0;

@onready var dash_timer = $CharacterAnchor/DashTimer
@onready var character_anchor = $CharacterAnchor
@onready var chicken_sprite = $CharacterAnchor/Chicken
@onready var gun_anchor = $CharacterAnchor/GunAnchor
@onready var front_vector = $CharacterAnchor/frontVector

func get_input():
	var movement_speed = SPEED;
	#Movement input
	#Calculating the unit vector of the direction into which to move and multipling it with speed
	var input_direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown");
	#TODO: Implement Dash and Shooting
	#Checking if dash key is pressed
	#if Input.is_action_pressed("Dash"):
		#movement_speed = DASH_SPEED;
		#dash_timer.start();
	#Flipping character horizontally according to the movement key pressed
	if Input.is_action_pressed("MoveLeft"):
		if character_anchor.scale.x > 0:
			character_anchor.scale.x *= -1;
	elif Input.is_action_pressed("MoveRight"):
		if character_anchor.scale.x < 0:
			character_anchor.scale.x *= -1;
	
	#Adding skew to the chicken sprite when moving
	chicken_sprite.skew = SKEW_AMOUNT * input_direction.length();
	
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
	velocity = input_direction * movement_speed;

func _physics_process(delta):
	get_input();
	move_and_slide();
