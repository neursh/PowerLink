import qrcode, pyautogui, json, socket, threading, random, time
from tkinter import *
from PIL import ImageTk

root = Tk()

root.geometry("410x410")
root.title("PowerLink Server")

def get_ip() -> str:
    try:
        with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as soc:
            soc.connect(("1.1.1.1", 1))
            return soc.getsockname()[0]
    except:
        return "no_internet"

def runner(conn, addr, password):
    try:
        verify = conn.recv(1024).decode()
        sc = verify == password
        if sc:
            conn.send(b"accept")
            print("Signed in by:", addr)
        else:
            root.deiconify()
            conn.send(b"denied")
            conn.close()
            return
        while "interacting":
            print("Awaiting income")
            data = conn.recv(1024).decode()
            print(data)
            if data == "": break
            if data not in ["left", "right", "shift+f5", "f5", "esc"]: continue
            pyautogui.press(data) if data != "shift+f5" else pyautogui.hotkey("shift", "f5")
    finally:
        print("Signed out:", addr)
        root.deiconify()

def service(port, password):
    soc = socket.socket()
    soc.bind(("0.0.0.0", int(port)))
    try:
        soc.listen(5)
        print('Server started.')

        while 'connected':
            conn, addr = soc.accept()
            conn.ioctl(socket.SIO_KEEPALIVE_VALS, (1, 1000, 1000))
            root.withdraw()
            threading.Thread(target=runner, args=(conn, addr, password,)).start()
    finally:
        soc.close()

with socket.socket() as tmp:
    tmp.bind(("",0))
    port = tmp.getsockname()[1]

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