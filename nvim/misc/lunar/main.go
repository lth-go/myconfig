package main

import (
	"container/list"
	"fmt"
	"strings"
	"time"

	"github.com/6tail/lunar-go/calendar"
)

func main() {
	solar := calendar.NewSolarFromDate(time.Now().Local())
	lunar := solar.GetLunar()

	fmt.Printf("%s\n", solar.ToFullString())

	fmt.Println()

	fmt.Printf("农历%v\n", lunar.GetMonthInChinese()+"月"+lunar.GetDayInChinese())

	fmt.Printf("%s%s年 %s月 %s日\n", lunar.GetYearInGanZhi(), lunar.GetYearShengXiao(), lunar.GetMonthInGanZhi(), lunar.GetDayInGanZhi())

	fmt.Println()

	for i, yis := range toList(lunar.GetDayYi()) {
		if i == 0 {
			fmt.Printf("[宜] %s\n", strings.Join(yis, " "))
		} else {
			fmt.Printf("     %s\n", strings.Join(yis, " "))
		}
	}

	for i, jis := range toList(lunar.GetDayJi()) {
		if i == 0 {
			fmt.Printf("[忌] %s\n", strings.Join(jis, " "))
		} else {
			fmt.Printf("     %s\n", strings.Join(jis, " "))
		}
	}
}

func toList(l *list.List) [][]string {
	var s []string

	for e := l.Front(); e != nil; e = e.Next() {
		v := e.Value.(string)

		s = append(s, v)
	}

	return Chunk(s, 8)
}

func Chunk[T any, Slice ~[]T](collection Slice, size int) []Slice {
	chunksNum := len(collection) / size
	if len(collection)%size != 0 {
		chunksNum += 1
	}

	result := make([]Slice, 0, chunksNum)

	for i := 0; i < chunksNum; i++ {
		last := (i + 1) * size
		if last > len(collection) {
			last = len(collection)
		}
		result = append(result, collection[i*size:last:last])
	}

	return result
}
