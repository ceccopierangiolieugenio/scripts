#!/usr/bin/env python3
# Example from:
#   https://stackoverflow.com/questions/55648031/how-to-intercept-ctrl-c-command-in-python-running-in-cygwin

import signal
import sys
def signal_handler(sig, frame):
    print('You pressed Ctrl+C!')
    sys.exit(0)

signal.signal(signal.SIGINT,  signal_handler)
signal.signal(signal.SIGTERM, signal_handler)
# signal.signal(signal.SIGSTOP, signal_handler)
# signal.signal(signal.SIGBREAK, signal_handler)


print('Press Ctrl+C')
input()
