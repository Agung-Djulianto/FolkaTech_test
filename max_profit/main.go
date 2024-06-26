package main

import (
	"fmt"
)

func maxProfit(prices []int, k int) (int, [][]int) {
	n := len(prices)
	if n < 2 || k <= 0 {
		return 0, nil
	}

	dp := make([][]int, k+1)
	trans := make([][][]int, k+1)
	for j := range dp {
		dp[j] = make([]int, n)
		trans[j] = make([][]int, n)
	}

	max := func(x, y int) int {
		if x > y {
			return x
		}
		return y
	}

	for j := 1; j <= k; j++ {
		maxDiff := -prices[0]
		for day := 1; day < n; day++ {
			dp[j][day] = dp[j][day-1]
			for m := 0; m < day; m++ {
				profit := prices[day] - prices[m] + dp[j-1][m]
				if profit > dp[j][day] {
					dp[j][day] = profit
					trans[j][day] = []int{m, day, prices[day] - prices[m]}
				}
			}
			maxDiff = max(maxDiff, dp[j-1][day]-prices[day])
		}
	}

	maxProfit := dp[k][n-1]
	var transactions [][]int
	j, day := k, n-1
	for j > 0 && day > 0 {
		if len(trans[j][day]) > 0 {
			transactions = append([][]int{trans[j][day]}, transactions...)
			j--
			if trans[j][day] != nil && len(trans[j][day]) > 0 {
				day = trans[j][day][0]
			}
		} else {
			day--
		}
	}

	return maxProfit, transactions
}

func main() {
	prices := []int{4, 11, 2, 20, 59, 80}
	k := 2
	maxProfit, transactions := maxProfit(prices, k)
	fmt.Println("Max Profit:", maxProfit)
	fmt.Println("Transactions:")
	for _, t := range transactions {
		buyDay := t[0]
		sellDay := t[1]
		fmt.Printf("  Buy on day %d at price %d, sell on day %d at price %d\n", buyDay+1, prices[buyDay], sellDay+1, prices[sellDay])
	}
}
