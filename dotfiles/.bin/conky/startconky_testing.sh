#!/bin/bash

sleep 1
conky -c ~/.Conky/cpu &
sleep 1
conky -c ~/.Conky/mem &
sleep 1
conky -c ~/.Conky/rings &
sleep 1
conky -c ~/.Conky/rss &
sleep 1
conky -c ~/.Conky/net &
sleep 1
conky -c ~/.Conky/weather2 &
sleep 1
conky -c ~/.Conky/mail &
sleep 1
conky -c ~/.Conky/forum &