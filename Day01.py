with open("Input/Day01.txt", "r") as file:
    instructions = [(1 if line[0] == 'R' else -1, int(line[1:])) for line in file]

pos = 50
counter = 0
for i in instructions:
    pos = (pos + i[0] * i[1]) % 100
    if pos == 0: counter += 1

print(counter)

pos = 50
counter = 0
for i in instructions:
    start_nonzero = pos != 0
    pos = (pos + i[0] * i[1])
    if pos == 0: counter += 1
    elif pos > 99: counter += (pos // 100)
    elif pos < 0: counter += (pos // -100) + start_nonzero
    pos %= 100

print(counter)