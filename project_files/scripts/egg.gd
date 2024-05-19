extends StaticBody2D

signal egg_destroyed_signal;

@export var MAX_HEALTH = 9;

@onready var destroyed_egg_lifetime = $DestroyedEggLifetime
@onready var egg_healthy = $Sprites/EggHealthy
@onready var egg_hit = $Sprites/EggHit
@onready var egg_destroyed_1 = $Sprites/EggDestroyed1
@onready var egg_destroyed_2 = $Sprites/EggDestroyed2
@onready var egg_destroyed_anim_timer = $Sprites/EggDestroyedAnimTimer
@onready var collision_shape_2d = $CollisionShape2D

var CURRENT_HEALTH = 100;
var egg_destroyed = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	CURRENT_HEALTH = MAX_HEALTH;
	egg_healthy.visible = true;
	egg_hit.visible = false;
	egg_destroyed_1.visible = false;
	egg_destroyed_2.visible = false;
	egg_destroyed = false;
	collision_shape_2d.disabled = false;

func take_damage(damage):
	if !egg_destroyed:
		CURRENT_HEALTH -= damage;
		if CURRENT_HEALTH < 0:
			CURRENT_HEALTH = 0;
		
		var health_percent = CURRENT_HEALTH / MAX_HEALTH;
		if health_percent > 0.5:
			egg_healthy.visible = true;
			egg_hit.visible = false;
			egg_destroyed_1.visible = false;
			egg_destroyed_2.visible = false;
		elif health_percent <= 0.5 && health_percent > 0.0:
			egg_healthy.visible = false;
			egg_hit.visible = true;
			egg_destroyed_1.visible = false;
			egg_destroyed_2.visible = false;
		if health_percent <= 0.0:
			egg_healthy.visible = false;
			egg_hit.visible = false;
			egg_destroyed_1.visible = true;
			egg_destroyed_2.visible = false;
			egg_destroyed_anim_timer.start();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_egg_destroyed_anim_timer_timeout():
	egg_healthy.visible = false;
	egg_hit.visible = false;
	egg_destroyed_1.visible = false;
	egg_destroyed_2.visible = true;
	egg_destroyed = true;
	collision_shape_2d.disabled = true;
	destroyed_egg_lifetime.start();


func _on_destroyed_egg_lifetime_timeout():
	egg_destroyed_signal.emit();
	queue_free();
