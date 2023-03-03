import qrcode, pyautogui, json, socket, threading, random
from tkinter import *
from PIL import ImageTk

root = Tk()

root.geometry("410x410")
root.title("PowerLink Server")

def runner(conn, password):
    verify = conn.recv(1024).decode()
    sc = verify == password
    if sc: conn.send(b"accept")
    else:
        conn.send(b"denied")
        conn.close()
        return
    while "interacting":
        data = conn.recv(1024).decode()
        if data == "": break
        if data not in ["left", "right", "shift+f5", "f5", "esc"]: continue
        pyautogui.press(data) if data != "shift+f5" else pyautogui.hotkey("shift", "f5")

def service(port, password):
    soc = socket.socket()
    soc.bind(("0.0.0.0", int(port)))
    try:
        soc.listen(5)
        print('Server started.')

        while 'connected':
            conn, addr = soc.accept()
            print('Client connected IP:', addr)
            threading.Thread(target=runner, args=(conn, password,)).start()
    finally:
        soc.close()

def get_ip() -> str:
    try:
        with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as soc:
            soc.connect(("1.1.1.1", 1))
            return soc.getsockname()[0]
    except:
        return "no_internet"

while True:
    port = random.randrange(49152, 65535)
    try:
        with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as check:
            check.connect(("0.0.0.0", port))
            check.settimeout(1)
    except:
        break
password = "".join(random.choices("qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890", k=5))

threading.Thread(target=service, args=(port, password,), daemon=True).start()

qr = ImageTk.PhotoImage(qrcode.make(json.dumps({
        "ip": get_ip(),
        "port": str(port),
        "pass": password
    })))

qr_dis = Label(root, image=qr)
qr_dis.place(x=0, y=0)

Label(root, text=f"IP: {get_ip()}\nPort: {port}\nPassword: {password}").pack()

print({
        "ip": get_ip(),
        "port": port,
        "pass": password
    })
root.mainloop()