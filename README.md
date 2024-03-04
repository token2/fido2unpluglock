# FIDO2 Unplug Lock
A tool to lock a Windows10/11 workstation when a FIDO2 key is unplugged

Securing company assets is vital in the contemporary digital sphere. A potent method to achieve this goal is by deploying automatic computer lockout upon the removal of a FIDO2 key. 
Although this functionality is inherent in Microsoft environments for smart cards, this project will provide a solution to broaden this safeguard to FIDO2 security keys for systems that have implemented Passwordless access to Windows workstations.
### An open-source solution
According to our research, such solutions exist, but they are either vendor-locked or require payment and are proprietary. Our goal is to offer a free and open-source solution that will be compatible with any FIDO2 security key, not limited to the ones provided by Token2.

### About Token2
Token2 is a cybersecurity company specialized in the area of multifactor authentication. Founded by a team of researchers and graduates from the University of Geneva with years of experience in the field of strong security and multifactor authentication, Token2 has invented, designed and developed various hardware and software solutions for user-friendly and secure authentication. Token2 is headquartered in Geneva, Switzerland. 

Token2 is a member of FIDO Alliance, and implements the FIDO protocols (UAF, U2F, WebAuthN and CTAP) on its hardware security keys as well as its software solutions.


## Compiling and using the PowerShell version

The first option is the simple script (`t2lock.ps1`) created with PowerShell. It is ready to be used as is, however, as the principle of the solution is to constantly monitor the devices that have been unplugged, the best way would be to create an exe file out of it.

This can be done by using the [`ps2exe`](https://github.com/MScholtes/PS2EXE) module. Install the module and simply run:

```powershell
Invoke-ps2exe .\t2lock.ps1 .\t2lock.exe
```

This will give you an executable that you can deploy to your machine and make sure it is run at startup. Quitting the app will be possible only by killing it in the Task Manager.

## TO-DO

- A feature (or separate 'management' app) that will create a systray icon context menu allowing to see if the t2lock.exe is running and allowing to quit it more conveniently.
- Make sure the exe cannot be launched twice
