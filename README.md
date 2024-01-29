# AckReminder
The script notifies if there are open alerts without acknowledgment for a minimum of 2 minutes (sound is played every 10 seconds) and alerts from HOD lasting over 30 minutes. In the case of HOD alerts, the sound is played only once. If the priority of an HOD alert changes, the sound will be played again.

1. Download all files or clone repo.
2. Enter the API key in line 3 and Team ID from Opsgenie.
3. Run AckReminder.bat or execute it from the Terminal (powershell.exe -ExecutionPolicy Bypass -File ".\AckReminder.ps1").


* You can change the time after which the script notifies us on line 47. Just change the number of minutes at the end.
      ![image](https://github.com/CMRLD/AckReminder/assets/145223486/0a402676-866b-4e35-b4be-b19556b08c1a)
* You can change the time after which the script notifies us for HOD alerts on line 53. image.
      ![image](https://github.com/CMRLD/AckReminder/assets/145223486/af34a745-8bd2-4b55-8d8f-fca5ef4ba2d1)
* You can change the sound file path for HOD alerts in line 55 and for other alerts in line 62. image
      ![image](https://github.com/CMRLD/AckReminder/assets/145223486/08e7586b-89d8-4a80-ba3e-52b8c506a0d2)
