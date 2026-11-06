#!/bin/vbash

# The boot/commit hooks restore cached sets; only this task downloads feeds.
set system task-scheduler task spamhaus-drop executable path '/config/scripts/spamhaus-drop.py'
set system task-scheduler task spamhaus-drop executable arguments '--update'
set system task-scheduler task spamhaus-drop crontab-spec '17 4 * * *'
