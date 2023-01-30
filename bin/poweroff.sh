#!/bin/bash

ssh 192.168.10.10 poweroff
sleep 3
ssh 192.168.10.30 poweroff
sleep 3
ssh 192.168.10.20 poweroff
