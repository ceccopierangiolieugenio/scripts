# Reference: https://gist.github.com/sylt/93d3f7b77e7f3a881603

import curses

stdscr = curses.initscr()
curses.cbreak()
curses.noecho()

# Enables keypad mode. This makes (at least for me) mouse events getting
# reported as KEY_MOUSE, instead as of random letters.
stdscr.keypad(True)

# Don't mask any mouse events
curses.mousemask(curses.ALL_MOUSE_EVENTS | curses.REPORT_MOUSE_POSITION)

print("\033[?1003h\n") # Makes the terminal report mouse movement events

while True:
    c = stdscr.getch()

    # Exit the program on new line fed
    if c == 10:
        break

    buffer = ""

    if c == -1: continue

    if c == curses.ERR:
        print("Nothing happened.")
        break
    elif c == curses.KEY_MOUSE:
        idm, x, y, z, bstate = curses.getmouse()
        buffer = "  mouse evt: " + str((idm, x, y, z, bstate))
    else:
        buffer = f"Pressed key {c} ({chr(c)})"

    stdscr.move(0, 0)
    stdscr.insertln()
    stdscr.addstr(buffer)
    stdscr.clrtoeol()
    stdscr.move(0, 0)

print("\033[?1003l\n") # Disable mouse movement events, as l = low

curses.endwin()