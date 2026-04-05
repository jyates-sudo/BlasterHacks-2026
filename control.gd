extends Control

@onready var terminal = $Terminal
@onready var user = $"/root/User"
@onready var spawn_zone = $"/root/Main/SpawnZone"

var cmd_buffer := ""
var cmd := {}

var summon_mode := false
var attack_mode := false

var summoned_sprites: Array[Node2D] = []
var active_summon_count := 0
var remaining_attacks := 0

var ERR = "[1;31m"
var BAG = "[34m"
var CARDS = "[33m"
var PLAYER = "[1;35m"
var NORM = "[0m"
var ESC = char(27)

var monsters := {}

func _ready() -> void:
	# Adjust these paths to match the real node names in your tree.
	monsters["monster1"] = get_node("../1")
	monsters["monster2"] = get_node("../2")
	monsters["monster3"] = get_node("../3")
	monsters["monster4"] = get_node("../4")
	monsters["monster5"] = get_node("../5")
	monsters["monster6"] = get_node("../6")
	monsters["monster7"] = get_node("../7")

	terminal.visible = true
	_init_commands()

	terminal.write(ESC + PLAYER + "Player > " + ESC + NORM)
	terminal.data_sent.connect(_on_terminal_data_sent)
	terminal.bell.connect(_on_terminal_bell)
	terminal.size_changed.connect(_on_terminal_size_changed)

func _on_terminal_data_sent(data: PackedByteArray) -> void:
	var str_data = data.get_string_from_ascii()
	if str_data.is_empty():
		return

	var int_data = str_data.unicode_at(0)

	match int_data:
		13:
			var input = cmd_buffer.strip_edges()
			cmd_buffer = ""

			if summon_mode:
				_check_summon_input(input)
				if summon_mode:
					terminal.write(ESC + PLAYER + "\n\rSummon > " + ESC + NORM)
				else:
					terminal.write(ESC + PLAYER + "\n\rPlayer > " + ESC + NORM)

			elif attack_mode:
				_check_attack_input(input)
				if attack_mode:
					terminal.write(ESC + PLAYER + "\n\rAttack > " + ESC + NORM)
				else:
					terminal.write(ESC + PLAYER + "\n\rPlayer > " + ESC + NORM)

			else:
				_check_command(input)
				terminal.write(ESC + PLAYER + "\n\rPlayer > " + ESC + NORM)

		127:
			if cmd_buffer.length() > 0:
				terminal.write("\b \b")
				cmd_buffer = cmd_buffer.substr(0, cmd_buffer.length() - 1)

		_:
			cmd_buffer += str_data
			terminal.write(str_data)

func _on_terminal_bell() -> void:
	pass

func _on_terminal_size_changed(new_size: Vector2i) -> void:
	print(new_size)

func _process(_delta: float) -> void:
	pass

func _init_commands() -> void:
	cmd["help"] = _run_help
	cmd["summon"] = _enter_summon_mode
	cmd["run"] = _run_run
	cmd["attack"] = _enter_attack_mode
	cmd["exit"] = _run_exit

func _check_command(input: String) -> void:
	var lowered = input.to_lower()

	if cmd.has(lowered):
		cmd[lowered].call()
	else:
		terminal.write(ESC + ERR + "\n\rInvalid Command. Try 'help'" + ESC + NORM)

func _check_summon_input(input: String) -> void:
	var lowered = input.to_lower()

	if lowered == "exit" or lowered == "back":
		summon_mode = false
		terminal.write("\n\rLeaving summon menu.")
		return

	var cards = user.cards_owned
	var matched_card_name := ""

	for card in cards:
		if String(card.item_name).to_lower() == lowered:
			matched_card_name = card.item_name
			break

	if matched_card_name == "":
		terminal.write(ESC + ERR + "\n\rNot in your cards. Type a listed name or 'exit'." + ESC + NORM)
		return

	_summon_existing_monster(matched_card_name)

func _check_attack_input(input: String) -> void:
	var lowered = input.to_lower()

	if lowered == "exit" or lowered == "back":
		attack_mode = false
		terminal.write("\n\rLeaving attack menu.")
		return

	if remaining_attacks <= 0:
		attack_mode = false
		terminal.write(ESC + ERR + "\n\rNo attacks remaining." + ESC + NORM)
		return

	_do_attack()

func _run_help() -> void:
	for c in cmd:
		if c != "help":
			terminal.write("\n\r" + c)

func _enter_summon_mode() -> void:
	if attack_mode:
		attack_mode = false

	summon_mode = true
	terminal.write("\n\r" + ESC + CARDS + "Summon Menu" + ESC + NORM)
	terminal.write("\n\rType a card name to summon it.")
	terminal.write("\n\rType 'exit' to leave.")

	var cards = user.cards_owned
	for card in cards:
		terminal.write("\n\r" + ESC + CARDS + str(card.item_name) + ESC + NORM)

func _enter_attack_mode() -> void:
	if summon_mode:
		summon_mode = false

	if active_summon_count <= 0:
		terminal.write(ESC + ERR + "\n\rNo summoned creatures can attack." + ESC + NORM)
		return

	remaining_attacks = active_summon_count
	attack_mode = true

	terminal.write("\n\r" + ESC + CARDS + "Attack Menu" + ESC + NORM)
	terminal.write("\n\rPress Enter to attack.")
	terminal.write("\n\rType 'exit' to leave.")
	terminal.write("\n\rAttacks available: " + str(remaining_attacks))

func _summon_existing_monster(name: String) -> void:
	if not monsters.has(name):
		terminal.write(ESC + ERR + "\n\rInvalid monster." + ESC + NORM)
		return

	var monster = monsters[name]

	if monster.visible:
		terminal.write(ESC + ERR + "\n\r" + name + " is already summoned." + ESC + NORM)
		return

	var active = _get_active_monsters()
	monster.visible = true

	active_summon_count += 1
	summoned_sprites.append(monster)

	terminal.write("\n\rSummoned " + ESC + CARDS + name + ESC + NORM)
	terminal.write("\n\rCreatures ready to attack: " + str(active_summon_count))

func _get_active_monsters() -> Array[Node2D]:
	var active: Array[Node2D] = []

	for m in monsters.values():
		if is_instance_valid(m) and m.visible and m is Node2D:
			active.append(m)

	return active

func _do_attack() -> void:
	remaining_attacks -= 1
	randomize()
	var hit = get_node("AudioStreamPlayer")
	
	# Replace this with your real enemy damage logic.
	var enemy_hp = get_node("../enemy")
	var dmg = 15 * randi_range(1, 3)
	enemy_hp.value -= dmg
	if enemy_hp.value <= 0:
		_on_enemy_defeated()
		return
	hit.play(0)
	terminal.write("\n\rA summoned creature attacks the enemy for " + str(dmg) + " damage!")
	terminal.write("\n\rAttacks remaining: " + str(remaining_attacks))

	if remaining_attacks <= 0:
		attack_mode = false
		terminal.write("\n\rAll summoned creatures have attacked.")
		var enemyDmg = 10 * randi_range(1,3)
		terminal.write("\n\rEnemy Attacks for" + str(enemyDmg) + " damage!")


func _run_run() -> void:
	terminal.write("\n\rNo!")

func _run_exit() -> void:
	if summon_mode:
		summon_mode = false
		terminal.write("\n\rLeaving summon menu.")
	elif attack_mode:
		attack_mode = false
		terminal.write("\n\rLeaving attack menu.")
	else:
		terminal.write("\n\rNothing to exit from here.")

func _on_enemy_defeated() -> void:
	terminal.write("\n\rEnemy defeated!")
	get_tree().change_scene_to_file("res://Entities and Sprites/Maps/starting_room.tscn")
