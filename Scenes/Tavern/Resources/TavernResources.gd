extends Control

onready var game_data = get_node("/root/World/GameData")
onready var gold_label = find_node("GoldLabel")
onready var xp_label = find_node("XpLabel")

func _ready():
	game_data.connect("gold_changed", self, "_on_Gold_changed")
	game_data.connect("xp_changed", self, "_on_Xp_changed")
	update_gold_label()
	update_xp_label()

func _on_Gold_changed():
	update_gold_label()
	
func _on_Xp_changed():
	update_xp_label()
	
func update_gold_label():
	gold_label.text = str("Zloto: ", game_data.gold) 
	
func update_xp_label():
	xp_label.text = str("Doswiadczenie: ", game_data.xp)
	
func _on_Tavern_entered():
	visible = true
	
func _on_Tavern_exited():
	visible = false