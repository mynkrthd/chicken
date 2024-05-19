extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$CPUParticles2D.restart();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_lifetime_timeout():
	queue_free();
