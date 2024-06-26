package main

import "fmt"

func rotateAndPrint(arr []int) {
	n := 3 // ukuran matriks 3x3

	// Create the 3x3 matrix from the input array
	matrix := make([][]int, n)
	for i := range matrix {
		matrix[i] = make([]int, n)
	}
	for i := 0; i < n*n; i++ {
		matrix[i/n][i%n] = arr[i]
	}

	// Rotate the matrix clockwise
	rotatedMatrix := make([][]int, n)
	for i := range rotatedMatrix {
		rotatedMatrix[i] = make([]int, n)
	}
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			rotatedMatrix[j][n-i-1] = matrix[i][j]
		}
	}

	// Print the rotated matrix
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			fmt.Printf("%d", rotatedMatrix[i][j])
		}
		fmt.Println()
	}
}

func main() {
	arr := []int{1, 2, 3, 4, 5, 6, 7, 8, 9}
	rotateAndPrint(arr)
}
