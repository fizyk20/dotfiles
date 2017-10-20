#!/usr/bin/env python

import sys
import subprocess
import json

BAR_H = 110

def open_window(width, height, x, y, *args):
    arguments = [
        "yad",
        "--width=%d" % width,
        "--height=%d" % height,
        "--posx=%d" % x,
        "--posy=%d" % (y - height/2 - BAR_H),
        "--class=YADWIN", 
    ]
    arguments = arguments + [*args]
    return subprocess.Popen(arguments,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL)

def handle(data):
    name = data["name"]
    button = data["button"]
    x = data["x"]
    y = data["y"]
    if name == "time":
        width = 200
        height = 120
        p = open_window(width, height, x-100, y, "--calendar", "--no-buttons")
        return p, None

def poll_processes(processes):
    toremove = []
    for process, callback in processes:
        returncode = process.poll()
        if returncode is not None:
            toremove.append((process, callback))
            if callback is not None:
                callback(returncode)
    for x in toremove:
        processes.remove(x)

def main():
    print('{ "version": 1, "click_events": true }')
    print("[\n[],")
    subprocess.Popen(["conky", "-c", "/home/bartek/dotfiles/.conkyrc.i3"])
    processes = set()
    while True:
        poll_processes(processes)
        line = input()
        try:
            if line[0] == ',':
                line = line[1:]
            data = json.loads(line)
            process, callback = handle(data)
            if process is not None:
                processes.add((process, callback))
        except json.JSONDecodeError:
            pass

if __name__ == "__main__":
    try:
        main()
    except BaseException as e:
        print('[{ "full_text": "%s", "color": "\\#ff0000" }]' % repr(e))
