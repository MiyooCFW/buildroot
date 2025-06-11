import subprocess
import sys
import termios
import tty
import signal

if len(sys.argv) < 2:
    print("Usage: python3 p.py <filename>")
    sys.exit(1)

filename = sys.argv[1]

cmd = ['gst-launch-1.0', 'filesrc', 'location=' + filename, '!', 'qtdemux', 'name=demux',
       'demux.audio_0', '!', 'queue', '!', 'decodebin', '!', 'audioconvert', '!', 'alsasink',
       'demux.video_0', '!', 'queue', '!', 'decodebin', '!', 'autovideoconvert', '!', 'fbdevsink']

proc = subprocess.Popen(cmd)

def get_key():
    fd = sys.stdin.fileno()
    old = termios.tcgetattr(fd)
    try:
        tty.setraw(fd)
        ch = sys.stdin.read(1)
    finally:
        termios.tcsetattr(fd, termios.TCSADRAIN, old)
    return ch

_ = get_key()
print("Key pressed, terminating gst-launch...")
proc.terminate()

proc.wait()
print("gst-launch stopped.")

