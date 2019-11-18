import paramiko
from time import sleep
import boto3
import re

def windows_ssh_object(host_ip, server_ip=None,password=None,command=None):
    obj =windows_ssh_login(host_ip, server_ip,password,command)
    return obj

class windows_ssh_login:

    def __init__(self, host_ip, server_ip = None,password=None,command=None):
        self.host_ip = host_ip
        self.server_ip = server_ip
        self.command=command
        self.ssh = paramiko.SSHClient()
        self.ssh.load_system_host_keys()
        self.ssh.set_missing_host_key_policy(paramiko.WarningPolicy())
        if password == None:
            self.password='pflZF$4sXh@@PhJYx2a9a?UAzcKhe6Tz'
        else:
            self.password='NK@wtynrsmfDU4pC$X$?rT?Ne2k-m%=p'
        try:
            self.ssh.connect(hostname = self.host_ip, port = 22, password=self.password, username = 'Administrator')
            print('Sucessfully Established connection')
        except Exception as e:
            print("SSH login failed",e)


    def windows_cpt_install(self):
        stdin, stdout, stderr = self.ssh.exec_command("curl -k https://"+self.server_ip+":5000/manage/downloads/certificate.crt -o C:\Users\Administrator/certificate.crt")
        print('Please wait certificate Downloading....')
        sleep(10)
        status = stdout.read()
        print(status)
        stdin, stdout, stderr = self.ssh.exec_command("curl -k https://"+self.server_ip+":5000/manage/downloads/plgx_cpt.exe -o C:\Users\Administrator/plgx_cpt.exe")
        print('Please wait Plgx_cpt.exe Downloading....')
        sleep(10)
        status = stdout.read()
        print(status)
        stdin, stdout, stderr = self.ssh.exec_command(r"C:\Users\Administrator\plgx_cpt.exe -i "+self.server_ip+" -k C:\Users\Administrator\certificate.crt -p 9000")
        print('please wait CPT is installing')
        sleep(20)
        status = stdout.read()
        print(status)
        return 'success'

    def windows_cpt_uninstall(self):
        stdin,stdout,stderr = self.ssh.exec_command("C:\Users\Administrator\plgx_cpt.exe -u d")
        sleep(10)
        print('CPT is uninstalled')
        status = stdout.read()
        print(status)
        stdin,stdout,stderr = self.ssh.exec_command("cmd /c del C:\Users\Administrator\plgx_cpt.exe")
        sleep(2)
        stdin,stdout,stderr = self.ssh.exec_command("cmd /c del C:\Users\Administrator\certificate.crt")
        sleep(2)
        print ("Uninstall CPT and delete CPT files Successful")

    def windows_create_file(self):
	stdin,stdout,stderr = self.ssh.exec_command("cmd /c C:\Users\Administrator\AppData\Local\Programs\Python\Python37-32\python.exe C:\Users\Administrator\Desktop\create_file.py")
	sleep(2)
	print(stdout.read())
	
    def get_pid(self):
        channel=self.ssh.invoke_shell()
        channel.send('start calc \n')
	stdin,stdout,stderr = self.ssh.exec_command("tasklist")
	tasklist=stdout.read()
        print(tasklist)
	tasklist=tasklist.split('\n')
	for task in tasklist:
	    if re.search('cmd',task):
		task=re.sub('\s+',' ',task)
	        task=task.split()
                print(task[1])
                return task[1] 
    
    def alerts(self):
    
        if not  re.search('remote',self.command):
            command=r"cmd /c python  C:\Users\Administrator\master\RTA-master\red_ttp"+"\\"+self.command
        else:
            command='cmd /c python C:\Users\Administrator\Desktop'+'\\'+self.command
        print command
        try:
            stdin,stdout,stderr = self.ssh.exec_command(command,timeout=60)
            err=stderr.read()
            print(stdout.read())
            sleep(2)
        except Exception:pass
        return 'sucess'

    def close_connection(self):
        self.ssh.close()
        print('SSH connection closed')


def start_stop_instance(action):
    ec2 = boto3.resource('ec2',region_name="ap-south-1")
    instance_id = 'i-0b14ce1a58f33a47c'
    instance = ec2.Instance(instance_id)
    if action == 'start':
        instance.start()
        print("PolyLogyx_Windows_Agent_Base Started\nInitilizing system wait for 5min.....")
        sleep(300)
        client=boto3.client('ec2',region_name="ap-south-1")
        response = client.describe_instances()
        for reservation in response["Reservations"]:
            for instance in reservation["Instances"]:
                for tag in instance['Tags']:
                    if tag['Value']== 'PolyLogyx_Windows_Agent_Base':
                        windows_agent_ip=instance['PublicIpAddress']
                        print('windows_agent_ip-->', windows_agent_ip)
                        return windows_agent_ip
    elif action == 'stop':
        instance.stop()
        sleep(100)
        return 'PolyLogyx_Windows_Agent_Base instance stoped'


if  __name__ == '__main__':

    #windows_agent_ip = start_stop_instance('start')
    windows_agent_ip='13.235.42.218'
    obj = windows_ssh_login(windows_agent_ip,server_ip=None,password='pass')
    #print obj.windows_cpt_install()
    print("waiting for 30 sec")
    #sleep(30)
    #bj.windows_cpt_uninstall()
   # obj.windows_create_file()
   #obj.get_pid()
    obj.alerts(command='\certutil_webrequest.py')
    obj.close_connection()
    #print(start_stop_instance('stop'))
