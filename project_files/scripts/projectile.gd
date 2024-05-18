extends Area2D

@export var speed = 1200;
@export var damage = 3.0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	position += transform.x * speed * delta;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_bullet_lifetime_timeout():
	queue_free();


func _on_body_entered(body):
	#TODO: Implement when player or AI collides with it, reduce thier health by damage amount
	#TODO: Emit signal when hit?
	queue_free();
