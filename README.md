# dockerize-tcpp
Attempt at creating an easy to use and customizable dockerizeation method for TCPP ( https://github.com/The-Cataclysm-Preservation-Project ) codebases (or forks thereof)


This doesnt work
git clone -c core.autocrlf=false https://github.com/The-Cataclysm-Preservation-Project/TrinityCore.git tcpp-repo <-- does not work
git init tcpp-repo && cd tcpp-repo && git config core.autocrlf false && git remote add origin https://github.com/The-Cataclysm-Preservation-Project/TrinityCore.git && git pull origin master

MAKE SURE YOU CHECK OUT EVERYTHING WHILE MAINTAINING THE CORRECT LINE ENDINGS (windows fill screw you on this by converting everything to CRLF....)


set trinity core db user to root (or make it so that it can create the required databases)
^ No longer required


run server

change database
in character update table 2021_07_29_00_characters.sql.sql -> 2021_07_29_00_characters.sql and change the checksum to BCD64CE7EB34E6054D14A6C7F33B2ADC0678092C (sha1)
^ No longer required

# How do I attach to my world server so I can acctually get to the console?
`docker attach $(docker ps -f name=tcpp-worldserver --quiet)`

# How do I deattach without closing the server?
`Ctrl^z+Ctrl^c`

# TODO:
- Enable telnet and make it accessable
- Make shutdown gracefuller (fix SIGTERM passthrough in worldserver and see if adding a saveall is possible before halting)
- See if we need to store the acctual repo in a named volume (to prevent accidantel loss of unsaved data)
- Document more
- Look into starting everything in a tmux session
- Maybe simplify the Docker image into a single image (with multiple starting options)
- See if we can make it so that the realmlist settings are set correctly for connections from the host
- Optimize DockerFile's
- Improve the way configs are processed
- See if we can make it so custom sql's can be added (and will be applied on server boot)
- Make integration with vscode better (predefined the required plugin's before attaching and stuff)
- Might be nice to add a simple signup page/webserver (dust off the old SOAP project)?