# This demo is extracted from the amazing:
# https://github.com/aristocratos/bpytop

import os, sys, io, threading, signal, re, subprocess, logging, logging.handlers, argparse
from select import select
from time import time, sleep, strftime, localtime
from typing import List, Set, Dict, Tuple, Optional, Union, Any, Callable, ContextManager, Iterable, Type, NamedTuple

errors: List[str] = []
try: import fcntl, termios, tty, pwd
except Exception as e: 
	print(f'ERROR: {e}')
	exit(1)

class Nonblocking(object):
	"""Set nonblocking mode for device"""
	def __init__(self, stream):
		self.stream = stream
		self.fd = self.stream.fileno()
	def __enter__(self):
		self.orig_fl = fcntl.fcntl(self.fd, fcntl.F_GETFL)
		fcntl.fcntl(self.fd, fcntl.F_SETFL, self.orig_fl | os.O_NONBLOCK)
	def __exit__(self, *args):
		fcntl.fcntl(self.fd, fcntl.F_SETFL, self.orig_fl)

class Raw(object):
	"""Set raw input mode for device"""
	def __init__(self, stream):
		self.stream = stream
		self.fd = self.stream.fileno()
	def __enter__(self):
		self.original_stty = termios.tcgetattr(self.stream)
		tty.setcbreak(self.stream)
	def __exit__(self, type, value, traceback):
		termios.tcsetattr(self.stream, termios.TCSANOW, self.original_stty)


def set_echo(on: bool):
	"""Toggle input echo"""
	(iflag, oflag, cflag, lflag, ispeed, ospeed, cc) = termios.tcgetattr(sys.stdin.fileno())
	if on:
		lflag |= termios.ECHO # type: ignore
	else:
		lflag &= ~termios.ECHO # type: ignore
	new_attr = [iflag, oflag, cflag, lflag, ispeed, ospeed, cc]
	termios.tcsetattr(sys.stdin.fileno(), termios.TCSANOW, new_attr)

def push(*args):
	try:
		print(*args, sep="", end="", flush=True)
	except BlockingIOError:
		pass
		print(*args, sep="", end="", flush=True)

def get_key():
	"""Get a key or escape sequence from stdin, convert to readable format and save to keys list. Meant to be run in it's own thread."""
	input_key: str = ""
	try:
		while not False:
			with Raw(sys.stdin):
				if not select([sys.stdin], [], [], 0.1)[0]:			#* Wait 100ms for input on stdin then restart loop to check for stop flag
					continue
				input_key += sys.stdin.read(1)						#* Read 1 key safely with blocking on
				if input_key == "\033":								#* If first character is a escape sequence keep reading
					with Nonblocking(sys.stdin): 					#* Set non blocking to prevent read stall
						input_key += sys.stdin.read(20)
						if input_key.startswith("\033[<"):
							_ = sys.stdin.read(1000)
				print("INPUT: "+input_key.replace("\033","<ESC>"))
				if input_key == "\033" or input_key == "q":	#* Key is "escape" key if only containing \033
					break
				elif input_key.startswith(("\033[<0;", "\033[<35;", "\033[<64;", "\033[<65;")): #* Detected mouse event
					try:
						print((int(input_key.split(";")[1]), int(input_key.split(";")[2].rstrip("mM"))))
					except:
						pass
					else:
						if input_key.startswith("\033[<35;"):		#* Detected mouse move in mouse direct mode
							print("mouse Move")
						elif input_key.startswith("\033[<64;"):		#* Detected mouse scroll up
							print("mouse Scroll UP")
						elif input_key.startswith("\033[<65;"):		#* Detected mouse scroll down
							print("mouse Scroll DOWN")
						elif input_key.startswith("\033[<0;") and input_key.endswith("m"): #* Detected mouse click release
							print("mouse Click Release")
				input_key = ""
	except Exception as e:
		print(f'EXCEPTION: Input thread failed with exception: {e}')


print("Retrieve Keyboard, Mouse press/drag/wheel Events")
print("Press q or <ESC> to exit")

mouse_on			= "\033[?1002h\033[?1015h\033[?1006h" 	#* Enable reporting of mouse position on click and release
mouse_off			= "\033[?1002l" 						#* Disable mouse reporting
mouse_direct_on		= "\033[?1003h"							#* Enable reporting of mouse position at any movement
mouse_direct_off	= "\033[?1003l"							#* Disable direct mouse reporting

push(mouse_on)
set_echo(False)
get_key()
push(mouse_off, mouse_direct_off)
set_echo(True)
