#!/usr/bin/env python

from Crypto.Cipher import AES
import base64
import os
import sys

passphrase = file('passphrase', 'r')

BLOCK_SIZE = 32
PADDING = '{'

pad = lambda s: s + (BLOCK_SIZE - len(s) % BLOCK_SIZE) * PADDING

EncodeAES = lambda c, s: base64.b64encode(c.encrypt(pad(s)))

secret = passphrase.readline().rstrip('\n')
cipher = AES.new(secret)

print "Enter the text you want to encrypt.\nAfter you finish, enter a new line and press Ctrl+D to generate the hash."

text = sys.stdin.readlines()
text = ''.join(text)

encoded = EncodeAES(cipher, text)
print 'Encrypted text:', encoded


