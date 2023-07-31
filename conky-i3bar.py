#!/usr/bin/env python

import sys
import subprocess
import json
import re
from threading import Thread
import time

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
    name = data.get("name", "")
    button = data.get("button", -1)
    x = data.get("x", -1)
    y = data.get("y", -1)
    if name == "time":
        width = 200
        height = 120
        p = open_window(width, height, x-100, y, "--calendar", "--no-buttons")
        return p, None
    else:
        return None, None

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

HOME_REGEX = re.compile('/home')
RW_REGEX = re.compile('rw,')
RO_REGEX = re.compile('ro,')

def filter_output(line):
    decoded = line.decode('utf-8')
    if HOME_REGEX.search(decoded) is not None:
        home_line = None
        with open('/proc/mounts', 'r') as mounts:
            for mount_line in mounts:
                if HOME_REGEX.search(mount_line) is not None:
                    home_line = mount_line
        if home_line is not None:
            if RW_REGEX.search(home_line) is not None:
                return decoded.replace('#ffffff', '#c0ffc0')
            elif RO_REGEX.search(home_line) is not None:
                return decoded.replace('#ffffff', '#ff0000')
    return decoded

class ConkyRunner(Thread):
    def run(self):
        conky = subprocess.Popen(["conky", "-c", "/home/bartek/dotfiles/.conkyrc.i3"], stdout=subprocess.PIPE)
        while True:
            for line in conky.stdout:
                print(filter_output(line))
                sys.stdout.flush()
            if conky.poll():
                conky = subprocess.Popen(["conky", "-c", "/home/bartek/dotfiles/.conkyrc.i3"], stdout=subprocess.PIPE)

def main():
    print('{ "version": 1, "click_events": true }')
    print("[\n[],")
    conky = ConkyRunner()
    conky.start()
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
