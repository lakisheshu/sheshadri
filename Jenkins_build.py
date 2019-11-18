import jenkins 
import subprocess
import sys
import os
import requests
import json
import re

class Jenkins:
        def __init__(self,job_name):
                self.server = jenkins.Jenkins('http://13.235.153.134:8080',username = 'admin', password = 'polylogyx123')
                self.jobname=job_name
                self.last_build_number = self.server.get_job_info(self.jobname)
                self.lbn=self.last_build_number['lastBuild']['number']
                self.build_obj= self.server.get_build_info(self.jobname,self.lbn)
                self.build_info=self.build_obj['changeSet']
                self.build_action=self.build_obj['actions'][0]

        def Validate_user(self):
                commit_id=self.get_commit_Id()
		print commit_id
                cause=self.build_action['causes'][0]
		if commit_id==None:
			userId=cause['userId']
		else:
			url='https://api.bitbucket.org/2.0/repositories/polylogyx/plgx-osq-server/commits'+'/'+commit_id
		        response=requests.get(url, auth=('karthic.asmltd@polylogyx.com', 'Jithisha9077@'))
		        if response.status_code==200:
		                commit_data=json.loads(response.text)
		                commit_data=commit_data['values'][0]
		                userId=str(commit_data['author']['raw'])
                        else:
                            userId=''
                if userId=='admin' or  re.search('moulik@polylogyx.com',userId):
                        print cause['shortDescription']
                        subprocess.call('robot --variable WORKSPACE:$WORKSPACE/branch $WORKSPACE/branch/Endgame_RTA_Alert_Test.robot',shell=True)
                    
                else:
                        print 'Unauthorized Commit'
                        print cause['shortDescription']
                        sys.exit(1)
	
	def get_commit_Id(self):
		cause=self.build_action['causes'][0]
		if cause['shortDescription']=='Started by user PolyLogyx Admin':
			commit_id=None
                elif  len(self.build_info['items'])!=0:
                        data=self.build_info['items'][-1]
                        commit_id=data['commitId']
                else:
                        try:commit_id=self.build_obj['actions'][4]['lastBuiltRevision']['SHA1']
			except Exception:commit_id=None
                return commit_id

if  __name__ == '__main__':
    job_name=os.environ.get('JOB_NAME')
    j=Jenkins(job_name)
    j.Validate_user()
