extends Node

# Online database -> POSTGRESQL @ elephantsql.com
onready var database_online = PostgreSQLClient.new()
var user = "knlvkgbo"
var password = "GQqJsVbHl2mU-glaBROQfVFr5tn_NQhu"
var host = "isilo.db.elephantsql.com"
var port = 5432
var database_connection = "knlvkgbo"

func _ready():
	# Connecting to online database
	database_online.connect("connection_established", self, "on_connection_established")
	database_online.connect("connection_error", self, "on_connection_error")
	database_online.connect("connection_closed", self, "on_connection_closed")
	var error = database_online.connect_to_host(get_connection_string())


func _physics_process(delta):
	database_online.poll()


func query_online(statement):
	var datas = database_online.execute(statement)
	return data_to_dictionary(datas)

func query_online_single(statement):
	var datas = database_online.execute(statement)
	if datas.size() > 0:
		var datas_dict = data_to_dictionary(datas)
		if datas_dict.size() > 0:
			return datas_dict[0]
	return {}


func data_to_dictionary(datas):
	var result = []
	# If nothing was returned
	if datas.size() == 0:
		return {}
	for data in datas[0].data_row:
		var dictionary = {}
		for i in data.size():
			dictionary[datas[0].row_description[i]["field_name"]] = data[i]
		result.push_back(dictionary)
	return result

func get_connection_string():
	return "postgres://%s:%s@%s:%d/%s" % [user, password, host, port, database_connection]

func on_connection_established():
	print("Connection succeeded.")
	query_online("Select * from recipes;")

func on_connection_error(error_object: Dictionary):
	Global.print_message(str(error_object))

func on_connection_closed(clean_closure := true):
	print("Connection failed")

func _exit_tree():
	database_online.close()
