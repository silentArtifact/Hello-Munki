#!/usr/bin/env bash
#finds printers that are currently disabled and clears the queue on them
cancel -a `lpstat -t | grep disabled | awk '{print $2}'`
#re-enable stopped print queues
cupsenable `lpstat -t | grep disabled | awk '{print $2}'`