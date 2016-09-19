from string import split

def file_lines(filename):
	f = open(filename, 'r')
	nb = 0
	for line in f:
		nb += 1
	return nb


NB_USERS = file_lines("users.txt")
NB_PRODUCTS = file_lines("themes.txt")

matrix_file = open("matrix.txt", 'r')

matrix = []

for line in matrix_file:
	elements = split(line.replace("\n", ""), ";")
	elements.pop()
	matrix.append(elements)

matrix_file.close()

sum_products = []

for y in range(len(matrix[0])):
	cpt = 0
	for x in range(len(matrix)):
		cpt += int(matrix[x][y])
	sum_products.append(cpt)

matrix_product = []

for i in range(len(sum_products)):
	line_matrix_product = []
	for j in range(len(sum_products)):
		line_matrix_product.append(sum_products[i] + sum_products[j])
	matrix_product.append(line_matrix_product)

print matrix_product