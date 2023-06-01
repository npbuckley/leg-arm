# Problems
#   How to test?
#   Take input as argument
#   Take output as argument
#
#

import re

def construct_line(array):
    finished = ""

    finished += array[0] + " "

    for t in array[1:-1]:
        finished += t + ", "

    finished += array[-1]

    return finished

# Check immediate conversions
def i_check(s):
    if s[-1][0] == "X":
        raise Exception("Line \"" + construct_line(s) + "\" is not valid LEG")

# Check floating-point number conversions
def f_check(s):
    if s[1][0] != "D":
        raise Exception("Line \"" + construct_line(s) + "\" is not valid LEG")

def convert_line(line):
    label = ""
    comment = ""

    # If there's a label, seperate it
    if line.find(":") > 0:
        colon = line.index(":")
        label = line[:colon+1]
        line = line[colon+1:]

    # If there's a comment, seperate it
    if line.find("//") > 0:
        start = line.index("//")
        comment = line[start:]
        line = line[:start]

    # split the rest of the string along spaces and ',' and remove empty strings
    tokens = [s for s in re.split(',| ', line) if s]

    # Check snytax and convert
    if tokens[0] == "ADDI" or tokens[0] == "ANDI" \
    or tokens[0] == "EORI" or tokens[0] == "ORRI" \
    or tokens[0] == "SUBI" or tokens[0] == "CMPI":
        i_check(tokens)
        tokens[0] = tokens[0][:-1]

    elif tokens[0] == "ADDIS" or tokens[0] == "ANDIS" \
    or tokens[0] == "SUBIS":
        i_check(tokens)
        tokens[0] = tokens[0][:-2] + tokens[0][-1]

    elif tokens[0] == "LDURS" or tokens[0] == "LDURD":
        f_check(tokens)
        tokens[0] = "LDUR"

    elif tokens[0] == "STURW":
        tokens[0] = "STUR"
    
    elif tokens[0] == "STURS" or tokens[0] == "STURD":
        f_check(tokens)
        tokens[0] = "STUR"

    elif tokens[0] == "FADDS" or tokens[0] == "FADDD" \
    or tokens[0] == "FCMPS" or tokens[0] == "FCMPD" \
    or tokens[0] == "FDIVS" or tokens[0] == "FDIVD" \
    or tokens[0] == "FMULS" or tokens[0] == "FMULD" \
    or tokens[0] == "FSUBS" or tokens[0] == "FSUBD":
        tokens[0] = tokens[0][:-1]

    elif tokens[0] == "LDA":
        tokens[0] = "ADR"

    else: #If not recognized, return original line
        return label + line + comment


    print(tokens) # For debugging

    return label + construct_line(tokens) + comment

def main():
    in_file = open("points.s", "r")
    out_file = open("output.s", "w")
    lines = in_file.readlines()

    for l in lines:
        out_file.write(convert_line(l))

if __name__ == "__main__":
    main()

    