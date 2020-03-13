#!/usr/bin/env python

from json import loads
from os import popen
from sys import argv

def ipc_query(msg=None, ipc_type='command'):
    ans = popen("i3-msg -t %s '%s'" % ( ipc_type, msg)).readlines()[0]
    return loads(ans)

def window_finder(node, label=None):
    node_id = False
    try: 
        if node['name'] and label in node['name']:
            node_id = node['id']
        else:
            for child in node['nodes']:
                this_node = window_finder(child, label)
                if this_node:
                    node_id = this_node
    except TypeError:
        pass
    return node_id

if __name__ == "__main__":
       tree = ipc_query(ipc_type='get_tree')
       tmux_window_id = window_finder(tree, 'attach-session')
       focus_msg = '[con_id="%s"] focus' % tmux_window_id
       rc = ipc_query(focus_msg)
       popen("logger -p info '%s'" % rc)


