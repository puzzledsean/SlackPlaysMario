# SlackPlaysMario
Fun side project where Open Web members used our Slack to play a game of NES Mario 

## How it works
1. Users on Slack send messages @nesbot
2. `app.py` accepts incoming messages, writes them to a file buffer `commands.txt`
3. `nesms_multicommand.lua` continuously reads from the file buffer and if there's a new command, it'll execute the command on the emulator

## Resources
- Sam Agnew's ROM Hacking tutorial <br>
https://www.twilio.com/blog/2015/08/romram-hacking-building-an-sms-powered-game-genie-with-lua-and-python.html
- FCEUX <br>
http://www.fceux.com/web/home.html
- FCEUX Lua scripting docs <br>
http://www.fceux.com/web/help/fceux.html?LuaScripting.html
- Mario NES ROM <br>
http://www.completeroms.com/dl/nintendo/super-mario-bros-e/4388
