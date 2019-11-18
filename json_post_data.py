import re

def Create_a_new_config():
    data = {
"name": "Config-add",
"config": {
"schedule": {
"win_file_events": {
"query": "select * from win_file_events;",
"interval": 10,
"description": "win file events"
}
},
"win_include_paths": {
"user_folders": [
"C:\\Users\\*\\Downloads\\"
]
},
"win_exclude_paths": {
"temp_folders": [
"C:\\Users\\*\\Downloads\\exclude\\"
]
}
}
}
    return data


def Updating_a_config():
    data = {
"config": {
"schedule": {
"processes": {
"description": "program",
"interval": 10,
"query": "select * from processes;"
}
},
"win_exclude_paths": {
"temp_folders": [
"C:\\Users\\*\\Downloads\\exclude\\"
]
},
"win_include_paths": {
"user_folders": [
"C:\\Users\\*\\Downloads\\"
]
}
},
"name": "poly-confignew"
}
    return data

def Assign_a_Config_to_a_node(host_id):
    data = {
"host_identifier": host_id,
"config_id": 1,
}
    return data


def Remove_a_Config_from_a_node(host_id):
    data = {
"host_identifier": host_id
}
    return data

# Scheduled Queries

def Scheduled_Query_Results_for_an_Endpoint_Node(host_id):
    data = {
"host_identifier": host_id,
"query_name": "win_file_events",
"start": 0,
"limit": 100
}
    return data

#Distributed (Ad-Hoc) Queries

def Add_a_Distributed_Query(host_id):
    data = {
"query": "select * from system_info;",
"tags": [
""
],
"nodes": [host_id]
}
    return data


def Add_a_query():
    data = {
"name": "new_process_query",
"query": "select * from processes;",
"interval": 5,
"platform": "ubuntu",
"version": "2.9.0",
"description": "Processes",
"value": "Processes"
,
"tags":["finance","sales"]
}
    return data


def Upload_a_pack():
    data = {
"name": "process_query_pack",
"queries": {
"win_file_events": {
"query": "select * from processes;",
"interval": 5,
"platform": "windows",
"version": "2.9.0",
"description": "Processes",
"value": "Processes"
}
},
"tags":["finance","sales"]
}
    return data


def Add_new_tags():
    data = {
"tags":["finance","sales"]
}
    return data

def Modify_tags_on_a_node(host_id):
    data = {
"host_identifier":host_id,
"add_tags":["finance","sales"],
"remove_tags":["demo"]
}
    return data

def Modify_tags_on_a_query():
    data = {
"query_id":1,
"add_tags":["finance","sales"],
"remove_tags":["demo"]
}
    return data

def Modify_tags_on_a_pack():
    data ={
"pack_id":1,
"add_tags":["finance","sales"],
"remove_tags":["demo"]
}
    return data

def Add_a_rule():
    data = {
"alerters": [
"email","splunk"
],
"name":"Adult website test_1",
"description":"Rule for finding adult websites",
"conditions": {
"condition": "AND",
"rules": [
{
"id": "column",
"type": "string",
"field": "column",
"input": "text",
"value": [
"issuer_name",
"Polylogyx.com(Test)"
],
"operator": "column_contains"
}
],
"valid": True
}
}
    return data

def Modify_rule():
    data = {
"alerters": [
"email",
"debug"
],
"conditions": {
"condition": "AND",
"rules": [
{
"field": "column",
"id": "column",
"input": "text",
"operator": "column_contains",
"type": "string",
"value": [
"domain_names",
"89.com"
]
}
],
"valid": True
},
"description": "Adult websites test",
"name": "Adult websites test_1",
"status": "ACTIVE"
}
    return data

def Alerts(host_id):
    data = {
"host_identifier": host_id,
}
    return data

def Configure_email_sender_and_recipients_for_alerts():
    data={
"emalRecipients": ["mehtamouli1k@gmail.com", "moulik1@polylogyx.com" ],
"email": "mehtamoulik13@gmail.com",
"smtpAddress": "smtp2.gmail.com",
"password": "a",
"smtpPort": 445
}
    return data

#Response
def Response_add(host_names):
    for host_name in host_names:
        if not re.search('.*ip',host_name):
            name=host_name
            break

    data = {
"action": "delete",
"actuator": {
"endpoint": "polylogyx_vasp"
},
"target": {
"file": {
"device": {
"hostname":name
},
"hashes": {},
"name": "C:\\Users\\Administrator\\Desktop\\Malware.txt"
}
}
}
    return data

def Kill_Process_on_Endpoint(host_names,pid):
    for host_name in host_names:
        if not re.search('.*ip',host_name):
            name=host_name
            break

    data = {
"action": "stop",
"target": {
"process": {
"name": "cmd.exe",
"pid": pid,
"device": {
"hostname":name
}
}
},
"actuator": {
"endpoint": "polylogyx_vasp"
}
}
    return data

def Carves(host_id):
    data = {
"host_identifier": host_id,
}
    return data
