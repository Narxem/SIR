from sets import Set
from string import split

logs = open("Log-clients-themes.txt", 'r')

users = Set()
themes = Set()

for line in logs:
	elements = split(line.replace("\n", ""), ';')
	if (len(elements) == 3):
		users.add(elements[1])
		themes.add(elements[2])


# Create MUT
matrix = {}
themes_matrix = {}
for i in themes:
	themes_matrix[i] = 0
for i in users:
	matrix[i] = dict(themes_matrix)

logs.seek(0, 0)
for line in logs:
	elements = split(line.replace("\n", ""), ';')
	if (len(elements) == 3):

		matrix[elements[1]][elements[2]] += 1
logs.close()

mat_file = open("matrix.txt", "w")
users_file = open("users.txt", "w")
themes_file = open("themes.txt", "w")

for i in matrix.keys():
	users_file.write(i)
	users_file.write("\n")
for i in themes_matrix.keys():
	themes_file.write(i)
	themes_file.write("\n")
users_file.close()
themes_file.close()


for i in matrix:
	for j in matrix[i]:
		mat_file.write(str(matrix[i][j]))
		mat_file.write(";")
	mat_file.write("\n")


mat_file.close()