#!/usr/bin/env python
# -*- coding: utf-8 -

import re
import sys
import os.path
import glob

# reline = re.compile(r'(\d+)\s+((?=(\d+\.amr)))+(.*)')
reline = re.compile(r'(\d+)\s+((?:(?:\d+\.amr)\s+)+)(.*)')
reamrs = re.compile(r'(\d+)\.amr')

# line = "004 001.amr 004.amr	 Тревога! Сработал датчик перемещения"
#

# Максимальная длина голосовой программы
MAX_PROGRAM = 8

programs = {}
max_program = 0

# print "sys.argv[1]=", sys.argv[1]

# sys.exit()

wfile = open(sys.argv[2], 'w')

# amr_files = []
# for amr_file in glob.glob("AMR/*.amr"):
#     print(amr_file)

for line in file(sys.argv[1]):
    (voice_num, amr_list, comment) = reline.findall(line)[0]

    # print "     line: ", line
    # print "voice_num: ", voice_num
    # print " amr_list: ", amr_list
    # print "  comment: ", comment

    amr_nums = reamrs.findall(amr_list)
    # print " amr_nums: ", amr_nums

    ivoice_num = int(voice_num)
    max_program = max(max_program, ivoice_num)

    if ivoice_num in programs:
        print " Error! Duplicate program %d" % ivoice_num
    else:
        programs[ivoice_num] = amr_nums

    # os.remove()

for p in range(0, max_program+1):
    program = []
    if p in programs:
        program = programs[p]

    wline = "AMR(%03d):" % p
    for amr in program:
        if not os.path.isfile("AMR/%s.amr" % amr):
            print "  Warning!: AMR-file AMR/%s.amr is not exist " % amr
        wline += " " + amr
        # try:
        #     os.remove("wav/AMR/%s.amr" % amr)
        # except:
        #     None

    for i in range(len(program), MAX_PROGRAM):
        wline += " ---"

    wfile.write("%s\r" % wline)

print "programs = ", max_program

wfile.close()
