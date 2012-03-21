#!/bin/bash

netstat -e -p -t | grep ESTABLISHED | cut -c45-68,107-140
