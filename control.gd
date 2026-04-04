extends Control

@onready var terminal = $Terminal
@onready var user = $"/root/User"

var cmdBuffer = ""
var cmd = {}
var ERR = "[1;31m"
var BAG = "[34m"
var CARDS = "[33m"
var PLAYER = "[1;35m"
var NORM = "[0m"
var ESC = char(27)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_initCommands()
	terminal.write(ESC + PLAYER + "Player > " + ESC + NORM)
	terminal.data_sent.connect(_onTerminalDataSent)
	terminal.bell.connect(_onTerminalBell)
	terminal.size_changed.connect(_onTerminalSizeChanged)

func _onTerminalDataSent(data: PackedByteArray) -> void:
	var strData = data.get_string_from_ascii()
	var intData = strData.unicode_at(0)
	match intData:
		13:
			_checkCommand(cmdBuffer)
			cmdBuffer = ""
			terminal.write(ESC + PLAYER + "\n\rPlayer > " + ESC + NORM)
		127:
			terminal.write("\b \b")
			cmdBuffer = cmdBuffer.substr(0, len(cmdBuffer)-1)
			#terminal.clear()
		
			
		_:
			cmdBuffer += strData
			terminal.write(strData)

func _onTerminalBell() -> void:
	pass

func _onTerminalSizeChanged(newSize: Vector2i) -> void:
	print(newSize)

func _checkCommand(input: String) -> void:
	print("Checked: ", input)
	if(cmd.has(input.strip_edges().to_lower())):
		cmd[input.strip_edges().to_lower()].call()
	else:
		terminal.write(ESC + ERR + "\n\rInvalid Command. Try 'help'" + ESC + NORM)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _initCommands() -> void:
	cmd["help"] = _runHelp
	cmd["summon"] = _runSummon
	cmd["bag"] = _runBag
	cmd["run"] = _runRun
	cmd["attack"] = _runAttack

func _runHelp() -> void:
	for c in cmd:
		terminal.write("\n\r" + c)

func _runSummon() -> void:
	user._getCards()

func _runBag() -> void:
	var bag = user._getBag()
	for item in bag:
		terminal.write("\n\r" + ESC + BAG + item + " -- " + bag[item] + ESC + NORM)

func _runRun() -> void:
	print("Run!")

func _runAttack() -> void:
	print("Attack!")
	
