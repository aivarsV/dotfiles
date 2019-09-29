import requests
import subprocess
import sys
from base64 import b64encode

CLIENT_CREDENTIALS = 'misc/xoauth-client-credentials'
PAYLOAD_BASE = {
        'client_id' : None,
        'client_secret' : None,
        'grant_type' : 'refresh_token'
        }

def getClientCredentials():
    print("getting client credentials")
    lines = subprocess.run(['gopass', 'show', CLIENT_CREDENTIALS],
                encoding=sys.stdout.encoding, capture_output=True).stdout.split('\n')
    PAYLOAD_BASE['client_secret'] = lines[0]
    PAYLOAD_BASE['client_id'] = lines[1].split(':')[-1].strip()

def RefreshToken(username, refresh_token):
    if None in PAYLOAD_BASE.values():
        getClientCredentials()

    params = {}
    params['refresh_token'] = refresh_token
    params.update(PAYLOAD_BASE)
    request_url = 'https://accounts.google.com/o/oauth2/token'

    response = requests.post(request_url, params=params)
    return response.json()['access_token']
    authStr = 'user=%s\1auth=Bearer %s\1\1' % (username, response.json()['access_token'])
    return '"{}"'.format(authStr)
    #return str(b64encode(bytes(authStr, sys.stdout.encoding)), sys.stdout.encoding)
