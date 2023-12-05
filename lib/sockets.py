try:
    from flask import Flask, render_template
    from flask_socketio import SocketIO
    from flask_socketio import emit

    import os
    import sys
    import json
except Exception as e:
    print("Some Module are Missing: {}".format(e))

app = Flask(__name__)
app.config['SECRET_KEY'] = 'secret!'
socketio= SocketIO(app)

@socketio.on('connect')
def ws_connect():
    try:
        f = open("test.txt", "r")
        data = f.read()
        tem = {"counter" : int(json.loads(data).get("counter")) + 1}
        f.close()
        emit('user', tem, broadcast=True)
    except Exception as e:
        fw = open('test.txt', 'w', encoding='utf-8')
        fw.write(json.dumps({"counter":0}))
        fw.close()
        emit('user', {"counter":0}, broadcast=True)


@app.route('/', method =["GET","POST"])
def home():
    f = open("test.txt", "r")
    data=f.read()
    data ={"counter" : int(json.load(data).get("counter"))}
    return render_template("index.html", data=data)


if __name__ == '__main__':
    socketio.run(app)