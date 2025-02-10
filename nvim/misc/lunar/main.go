package main

import (
	"bytes"
	"container/list"
	"fmt"
	"strings"
	"time"
	"unicode"
	"unicode/utf8"

	"github.com/6tail/lunar-go/calendar"
)

type String struct {
	v     string
	l     int
	align string
}

func NewString(v string, align string) String {
	return String{
		v:     v,
		l:     DisplayWidth(v),
		align: align,
	}
}

type Strings struct {
	s []String
}

func NewStrings(v ...string) *Strings {
	s := &Strings{
		s: make([]String, 0, len(v)),
	}

	for _, v := range v {
		s.s = append(s.s, NewString(v, ""))
	}

	return s
}

func (s *Strings) Add(v ...string) {
	for _, v := range v {
		s.s = append(s.s, NewString(v, ""))
	}
}

func (s *Strings) AddL(v ...string) {
	for _, v := range v {
		s.s = append(s.s, NewString(v, "left"))
	}
}

func (s *Strings) Fprintf(buf *bytes.Buffer, format string) {
	var maxLen int

	for _, v := range s.s {
		if v.l > maxLen {
			maxLen = v.l
		}
	}

	for _, v := range s.s {
		vv := v.v

		if vv != "" && v.align == "left" {
			vv = fmt.Sprintf("%s%s", v.v, strings.Repeat(" ", maxLen-v.l))
		}

		if vv == "" {
			vv = strings.Repeat("-", maxLen-v.l)
		}

		fmt.Fprintf(buf, format, vv)
	}
}

func main() {
	solar := calendar.NewSolarFromDate(time.Now().Local())
	lunar := solar.GetLunar()

	s := NewStrings()

	s.Add(solar.ToFullString())
	s.Add("")
	s.Add(fmt.Sprintf("农历%s月%s", lunar.GetMonthInChinese(), lunar.GetDayInChinese()))

	{
		var festivals []string

		festivals = append(festivals, toList(lunar.GetFestivals())...)
		festivals = append(festivals, toList(lunar.GetOtherFestivals())...)

		jieQi := lunar.GetJieQi()
		if jieQi != "" {
			festivals = append(festivals, jieQi)
		}

		var prefix string

		if len(festivals) > 0 {
			prefix = fmt.Sprintf("%s | ", strings.Join(festivals, " "))
		}

		s.Add(fmt.Sprintf(
			"%s%s%s年 %s%s月 %s%s日 %s%s时",
			prefix,
			lunar.GetYearInGanZhi(),
			lunar.GetYearShengXiao(),
			lunar.GetMonthInGanZhi(),
			lunar.GetMonthShengXiao(),
			lunar.GetDayInGanZhi(),
			lunar.GetDayShengXiao(),
			lunar.GetTimeZhi(),
			lunar.GetTimeShengXiao(),
		))
	}

	{
		tai := strings.Split(lunar.GetDayPositionTai(), " ")

		s.AddL(
			"",
			fmt.Sprintf("[胎神] %s        [五行] %s", tai[0], lunar.GetDayNaYin()),
			fmt.Sprintf("       %s               %s执位", tai[1], lunar.GetZhiXing()),
			"",
			fmt.Sprintf("[星宿] %s%s        [冲煞] %s日冲%s(%s%s)", lunar.GetGong(), lunar.GetShou(), lunar.GetDayShengXiao(), lunar.GetDayChongShengXiao(), lunar.GetDayChongGan(), lunar.GetDayChong()),
			fmt.Sprintf("       %s%s%s(%s)           煞%s", lunar.GetXiu(), lunar.GetZheng(), lunar.GetAnimal(), lunar.GetXiuLuck(), lunar.GetDaySha()),
			"",
		)

		s.Add(
			"[彭祖百忌]",
			lunar.GetPengZuGan(),
			lunar.GetPengZuZhi(),
			"",
		)
	}

	{
		for i, yis := range Chunk(toList(lunar.GetDayYi()), 6) {
			prefix := "[宜] "
			if i > 0 {
				prefix = "     "
			}

			v := fmt.Sprintf("%s%s", prefix, strings.Join(yis, " "))

			s.AddL(v)
		}

		for i, jis := range Chunk(toList(lunar.GetDayJi()), 6) {
			prefix := "[忌] "
			if i > 0 {
				prefix = "     "
			}

			v := fmt.Sprintf("%s%s", prefix, strings.Join(jis, " "))

			s.AddL(v)
		}
	}

	buf := bytes.NewBuffer(nil)
	s.Fprintf(buf, "%s\n")

	fmt.Print(buf.String())
}

func toList(l *list.List) []string {
	var s []string

	for e := l.Front(); e != nil; e = e.Next() {
		v := e.Value.(string)

		s = append(s, v)
	}

	return s
}

func DisplayWidth(s string) int {
	width := 0

	for i := 0; i < len(s); {
		r, size := utf8.DecodeRuneInString(s[i:])
		if r == utf8.RuneError {
			width++
		} else if unicode.Is(unicode.Han, r) {
			width += 2
		} else {
			width++
		}
		i += size
	}

	return width
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
