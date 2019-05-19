# CrimeIsDown.com's Trunk-Player Fork

## Installation

**Here's how to install my custom version of Trunk-Player:**

*NOTE: This assumes the system it's being installed onto is running some Linux variant and has [Docker Compose](https://docs.docker.com/compose/install/) installed.*

1. Clone this repo https://github.com/CrimeIsDown/trunk-player and checkout the docker-compose branch

```sh
git clone https://github.com/CrimeIsDown/trunk-player.git
cd trunk-player
git checkout docker-compose
```

2. In the repo, run the install script. This script will setup a new instance of trunk-player with Docker. If you don't have Docker or docker-compose installed, there is a link to install instructions in the error message that shows when the script is run.

```sh
./docker-install.sh
```

3. We need to make a new token for adding transmissions. In the `trunk_player/settings_local.py` file, add the following line. You want to change `7cf5857c61284` to a random alphanumeric string.

```python
ADD_TRANS_AUTH_TOKEN = '7cf5857c61284' # Token to allow adding transmissions
```

4. Back in your trunk-recorder directory, update the `config.json` file to ensure it has the `apiKey` and `uploadServer` set like so (replacing with the appropriate values):

```json
{
    "sources": [...],
    "systems": [{
        ...,
        "shortName": "{my_shortname}",
        "apiKey": "{value of ADD_TRANS_AUTH_TOKEN}"
    }],
    ...,
    "uploadServer": "http://localhost:8080"
}
```

5. Go to trunk-player (running on http://localhost:8080/) and login, then go to the Admin panel (click the navbar link).

6. Once in the Admin panel, find the Systems link and click Add to add a new system. On this page, enter your desired system name, and then make sure the system ID matches with the system's `shortName` in your trunk-recorder config.

![screenshot from 2018-12-04 23-29-28](https://user-images.githubusercontent.com/498525/49492091-7b86ba80-f81c-11e8-8085-dfdef2dc5227.png)

7. Finally, start up trunk-recorder and verify that recordings are getting sent to trunk-player. You can see the new recordings by going to the homepage of trunk-player and clicking the Main Scan List link.

8. At this point you may want to stop trunk-recorder and add talkgroups and scan lists into trunk-player, but things should be working enough to listen to new calls.
