file = open("vstup10", "r").read()
file = file.replace("noop", "0")
file = file.replace("addx", "0\n0\n", 1)
file = file.replace("addx", "0\n")
file = file.replace(" ", "")
file = file.replace("\n", " ")
file = file.split(sep=" ")
del file[-1]

cycle = 0
x_register = 1
indices = [0, 1, 2]
crt = []

for i in file:
    x_register = x_register + int(i)
    cycle += 1

    if cycle > 40:
        cycle = cycle - 40

    if int(i) != 0:
        indices = [x_register - 1, x_register, x_register + 1]

    if cycle - 1 in indices:
        crt.append("@")
    else:
        crt.append(" ")

for j in range(6):
    for i in range(40):
        print(crt[j*40+i], end="")

    print()














