#!/usr/bin/env python

from Crypto.Cipher import AES
import base64
import os
import sys

passphrase = file('passphrase', 'r')

BLOCK_SIZE = 32
PADDING = '{'

pad = lambda s: s + (BLOCK_SIZE - len(s) % BLOCK_SIZE) * PADDING

DecodeAES = lambda c, e: c.decrypt(base64.b64decode(e)).rstrip(PADDING)

secret = passphrase.readline().rstrip('\n')
cipher = AES.new(secret)

text = raw_input("Enter the hash-text you want to decrypt:\n")

decoded = DecodeAES(cipher, text)
print '\n\nDecrypted text:\n\n', decoded.rstrip('\n')
