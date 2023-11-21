import sys
import keyboard

## usb hid codes: https://www.usb.org/sites/default/files/documents/hut1_12v2.pdf 
hidCodeDict = {
103:82, #up
108:81, #down
105:80, #left
106:79, #right
29:29, #b mapped to z
56:27, #a mapped to x
57:4, #y mapped to a
42:22, #x mapped to s
1:42, #select mapped to backspace
28:40, #start mapped to enter
15:20, #lpad1 mapped to q
14:26, #rpad1 mapped to w
104:75, #lpad2 mapped to pg_up
109:78, #rpad2 mapped to pg_down
97:0, #reset not mapped, used to quit
}

NULL_CHAR = chr(0)
def write_report(report):
    with open('/dev/hidg0', 'rb+') as fd:
        fd.write(report.encode())

def translate(code, dictonary):
    if code in dictonary:
        return dictonary[code]
    return 0

def write_pressed_keys(e):
    line = ''.join(chr(translate(code,hidCodeDict)) for code in keyboard._pressed_events)
    if line == '':
        write_report(NULL_CHAR*8)
        return
    print('\r', end='')    
    write_report(NULL_CHAR*2+line+NULL_CHAR*5)
    
print("Press RESET button to quit")
keyboard.hook(write_pressed_keys)
keyboard.wait(97)