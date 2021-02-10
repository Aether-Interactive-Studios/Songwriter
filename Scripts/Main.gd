extends Control

var verse = "Verse"
var prechorus = "Pre-Chorus"
var chorus = "Chorus"
var verse2 = "Verse 2"
var bridge = "Bridge"
var Master = "Master"
var x
var cn = ":\n"
var n2 = "\n\n"


var space = "\n"
var location = "res://Lyrics.json"


var data = {
	"Verse" : "",
	"Pre-Chorus" : "",
	"Chorus" : "",
	"Verse 2" : "",
	"Bridge": "",
	"Master": ""
	}
func read():
	var lyrics = File.new()
	lyrics.open(location, File.READ)
	data = parse_json(lyrics.get_as_text())


	for keys in data.keys():
		if not keys == Master:
			print(data[keys])
			var node = get_node("TabContainer/"+keys)
			node.text = data[keys]
			

	lyrics.close()
func _ready():

	var lyrics = File.new()

	if not lyrics.file_exists(location):

		lyrics.open(location, File.WRITE)
		lyrics.store_string(to_json(data))
		lyrics.close()
		read()

	else:
		read()
		
	_master_()
	
func main(part):
	var node = get_node("TabContainer/"+part)
	var text = node.text
	data[part] = text
	var lyrics = File.new()
	lyrics.open(location, File.WRITE)
	lyrics.store_string(to_json(data))
	_master_()


func _master_():
	

	$"TabContainer/Master".text = (
		verse + cn + data[verse] + n2 +
		prechorus + cn + data[prechorus] + n2 +
		chorus + cn + data[chorus] + n2 +
		verse2 + cn + data[verse2] + n2 +
		prechorus + cn + data[prechorus] + n2 +
		chorus + cn + data[chorus] + n2 +
		bridge + cn + data[bridge] + n2+
		chorus + cn + data[chorus]
		
	)




func _on_Verse_text_changed():
	main(verse)
	pass # Replace with function body.
func _on_PreChorus_text_changed():
	main(prechorus)
	pass # Replace with function body.
func _on_Chorus_text_changed():
	main(chorus)
	pass # Replace with function body.
func _on_Verse_2_text_changed():
	main(verse2)
	pass # Replace with function body.
func _on_Bridge_text_changed():
	main(bridge)
	pass # Replace with function body.
func _on_Master_text_changed():
	
	pass # Replace with function body.

