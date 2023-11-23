import sys
import keyboard

## usb hid codes: https://www.usb.org/sites/default/files/documents/hut1_12v2.pdf 
hidCodeDict = {
103:82, #up
108:81, #down
105:80, #left
106:79, #right
29:1, #b mapped to l_ctrl
56:44, #a mapped to space
57:2, #y mapped to l_shift
42:27, #x mapped to x
1:42, #select mapped to backspace
28:40, #start mapped to enter
15:4, #lpad1 mapped to l_alt
14:43, #rpad1 mapped to tab
104:75, #lpad2 mapped to pg_up
109:78, #rpad2 mapped to pg_down
97:0, #reset not mapped, used to quit
}

NULL_CHAR = chr(0)
SPECIAL_KEY_CODES=[1,2,4,8,16,32,64,128]
def write_report(report):
    with open('/dev/hidg0', 'rb+') as fd:
        fd.write(report.encode())

def translate(code, dictonary):
    if code in dictonary:
        return dictonary[code]
    return 0

def write_pressed_keys(e):
    print('\r', end='')
    all_keys=[translate(code,hidCodeDict) for code in keyboard._pressed_events]
    if not len(all_keys):
        write_report(NULL_CHAR*8)
        return
        
    special_keys=0
    for s_key in SPECIAL_KEY_CODES:
        if s_key in all_keys:
            all_keys.remove(s_key)
            special_keys += s_key
  
    if not len(all_keys):
        write_report(chr(special_keys)+NULL_CHAR*7)
        return

    keys =''.join(chr(key) for key in all_keys)            
    write_report(chr(special_keys)+NULL_CHAR+keys+NULL_CHAR*5)
    
    
print("Press RESET button to quit")
keyboard.hook(write_pressed_keys)
keyboard.wait(97)