import json
import os
import random
import time

from slackclient import SlackClient

BOT_TOKEN = os.environ.get('SLACK_BOT_TOKEN')
RTM_READ_DELAY = 1   # 1 second delay between reading from RTM
VALID_COMMANDS = ['start', 'A', 'a', 'b', 'left', 'right', 'up', 'down', 'left a', 'left A', 'right a', 'right A']

# instantiate slack client
slack_client = SlackClient(BOT_TOKEN)


def parse_commands(slack_events):
    '''
        Parses a list of events coming from the Slack RTM API to find bot commands.

        If a command directed @memebot is found, this function returns a tuple of the commands and channel.
        If it's not found, then this function returns None, None.
    ''' 

    for event in slack_events:
        # if found a message
        if event["type"] == "message" and not "subtype" in event:
            # get user commands
            commands = event['text'].split()

            return commands, event["channel"]

    return None, None


def handle_command(command, channel):
    '''
        Send command keystroke
    '''

    # Finds and executes the given command, filling in response
    user_command_str = ' '.join(command)

    print(user_command_str)
    
    if user_command_str not in VALID_COMMANDS:
        response = '\"{}\" is an invalid command. \n List of valid commands {}'.format(user_command_str, VALID_COMMANDS)
        # Send some help messages
        slack_client.api_call(
                "chat.postMessage",
                channel = channel,
                text = response
                )
    else:
        with open('commands.txt', 'w') as command_file:
            command_file.write('{}'.format(user_command_str))
            print('wrote "{}" to command file'.format(user_command_str))


def listen():
    '''
        Infinitely loops, listening to Slack for events every RTM_READ_DELAY interval.
    '''

    if slack_client.rtm_connect(with_team_state=False):

        while True:
            command, channel = parse_commands(slack_client.rtm_read())
            if command:
                handle_command(command, channel)
            
            #  time.sleep(RTM_READ_DELAY)
    else:
        print("Connection failed. Exception traceback printed above.")


if __name__ == "__main__":
    print('nesbot started')
    listen()
