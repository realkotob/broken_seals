tool
extends "res://addons/world_generator/resources/world_gen_base_resource.gd"
class_name Continent

export(Array) var zones : Array

func get_content() -> Array:
	return zones

func set_content(arr : Array) -> void:
	zones = arr

func add_content(item_name : String = "") -> void:
	var zone : Zone = Zone.new()
	zone.resource_name = item_name
	
	zones.append(zone)
	
	emit_changed()

func setup_property_inspector(inspector) -> void:
	.setup_property_inspector(inspector)
