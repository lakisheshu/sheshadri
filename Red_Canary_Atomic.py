import paramiko, time, re
from time import sleep
import requests,json
import datetime
from requests.packages.urllib3.exceptions import InsecureRequestWarning
requests.packages.urllib3.disable_warnings(InsecureRequestWarning)

def get_alerts_data(baseurl,token,host_identifier):
    url = baseurl+'/alerts'
    data = {"host_identifier":host_identifier}
    r=requests.post(url,data = json.dumps(data),headers={"Content-Type":"application/json","x-access-token":token},verify=False)
    print(r.status_code)
    if r.status_code == 200:
        texts = json.loads(r.text)
	print(texts)
        return texts
    else:
        texts = {}
        texts['status']='failure'
        return texts

def last_two_min_data(text):
	print(text)
	result=[]
	std_diff=datetime.datetime.strptime('00:02:00.00', '%H:%M:%S.%f')-datetime.datetime.strptime("00:00:00.0",'%H:%M:%S.%f')
	time=datetime.datetime.utcnow()
	alerts=[]
	if text['status'] == 'success':
		for alert in text['data']:
			time_data=alert['created_at']
			print(time_data)
			time_data=time_data.replace('/',' ')
			time_data=time_data.split()
			time_data=time_data[2]+"-"+time_data[0]+"-"+time_data[1]+" "+time_data[3]+":"+time_data[4]+":"+time_data[5]+"."+"0"
			time_data = datetime.datetime.strptime(time_data, '%Y-%m-%d %H:%M:%S.%f')
			diff=time-time_data
			print(diff)
			if diff<std_diff:
				result.append(alert)
	else:
		result =[]
	return result

def validate(result,target_n):
   
	for data in result:
		for key in data['message']:
			if key == 'target_name':
				target_name=data['message']['target_name']
				print(target_name)
				if re.search(target_n,target_name):
					return 'success'
			elif key == 'cmdline':
				cmdline = data['message']['cmdline']
				print(cmdline)
				if re.search(target_n,cmdline):
					return 'success'
			elif key == 'path':
				path = data['message']['path']
				print(path)
				if re.search(target_n,path):
					return 'success'
			elif key =='action':
				action=data['message']['action']
				print(action)
				if re.search(target_n,action):
					return 'success'
		
	return 'failure'

def do_ssh(host_ip, password=None, command=None):
    client = paramiko.SSHClient()
    client.load_system_host_keys()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    if password == None:
        pwd='pflZF$4sXh@@PhJYx2a9a?UAzcKhe6Tz'
    else:
        pwd='NK@wtynrsmfDU4pC$X$?rT?Ne2k-m%=p'
    client.connect(hostname=host_ip, port = 22, username="administrator", password= pwd )
    print(datetime.datetime.utcnow())
    cmd = command
    try: 
	    print("clslla;klfsdl;jf;")
	    stdin,stdout,stderr = client.exec_command(cmd,timeout=60)
	    solo_line = stdout.channel.recv(1024)
	    print(solo_line)
	    if re.search('Yes/No',solo_line):
		stdin.write('Yes\n')
   	    elif re.search('ALL',solo_line):
		stdin.write('ALL\n')
	    status = stderr.read()
	    print(status)
	    status = stdout.read()
	    print(status)
    except Exception as e:
	    print(e)
	    pass   	
    finally:
    	   client.close()
    
	
'''
if __name__ == '__main__':				
	baseurl = "https://13.127.198.209:5000/services/api/v0/"
	host_identifiers = 'EC20ECBF-83DF-014A-3212-A10805A94CFE'
	status=''
	cmd_name = 'reg save HKLM\\System system.hive'
	do_ssh('13.233.198.117','pass',cmd_name)
	
	cmd_names = {'reg add "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Image File Execution Options\\osk.exe" /v "Debugger" /t REG_SZ /d "C:\\windows\\system32\\cmd.exe" /f':'\\REGISTRY\\MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Image File Execution Options\\osk.exe\\Debugger'}
	for cmd_name in cmd_names:
		#do_ssh(cmd_name)
		token = get_token()
		#host_identifiers = 'EC20ECBF-83DF-014A-3212-A10805A94CFE'
		for i in range(0,10):
			text1 = get_alerts_data(baseurl, token, host_identifiers)
			#print(text1)
			alerts_data = last_two_min_data(text1)
			if alerts_data !=None:
				status = validate(alerts_data,cmd_names[cmd_name])
				#print (status)
				if status == 'success':break
				else:
					sleep(10)
					continue
		print (status)	
		
		
		#if cmd == 'reg save HKLM\\Security security.hive':
    #    stdin,stdout,stderr = client.exec_command(cmd)
    #    stdin.write('yes\n')
    #elif cmd == 'reg save HKLM\\System system.hive':
    #    stdin,stdout,stderr = client.exec_command(cmd)
    #    stdin.write('yes\n')
    #elif cmd == 'reg save HKLM\\SAM sam.hive':
    #    stdin,stdout,stderr = client.exec_command(cmd)
    #    stdin.write('yes\n')
    #elif cmd == 'REG ADD "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Image File Execution Options\\winwoed.exe" /v Debugger /d "cmd.exe"':
    #    stdin,stdout,stderr = client.exec_command(cmd)
    #    stdin.write('yes\n')
    #else:
    #    stdin,stdout,stderr = client.exec_command(cmd)
	
    #status = stdout.read()
    #print(status)
    #status = stderr .read()
    #print(status)
    #sleep(5)
    '''

