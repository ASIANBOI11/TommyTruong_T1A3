height = int(input("Enter height of triangle: "))
character = input("Enter character: ")

if height <= 0:
    height = 3

character = character.replace(" ", "")

if character == "":
    character = "*"
if len(character) > 1:
    character = character[0]


base = int(height + height - 1)
row = 0
side_count = height - row
side_typing = 0
mid_count = row + row - 1
mid_typing = 0
base_char = 0

if row == 0:
    while side_typing < side_count:
        print(' ', end='')
        side_typing += 1
    side_typing = 0
    print(character, end='')
    while side_typing < side_count - 1:
        print(' ', end='')
        side_typing += 1
    print(' ')
    row += 1
    side_typing = 0
    side_count = height - row
    mid_count = row + row - 1

while row < height - 1:
    while side_typing < side_count:
        print(' ', end='')
        side_typing += 1
    side_typing = 0
    print(character, end='')
    while mid_typing < mid_count:
        print(' ', end='')
        mid_typing += 1
    mid_typing = 0
    print(character, end='')
    while side_typing < side_count - 1:
        print(' ', end='')
        side_typing += 1
    print(' ')
    row += 1
    side_typing = 0
    side_count = height - row
    mid_count = row + row - 1

if row == height - 1:
    print(' ', end='')
    while base_char < base:
        print(character, end='')
        base_char += 1
    print(' ')
