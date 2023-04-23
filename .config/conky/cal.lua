#!/usr/bin/env lua

local conky_color = "${color1}%2d${color}"
local t = os.date('*t', os.time())
local year, month, currentday = t.year, t.month, t.day
local daystart = os.date("*t",os.time{year=year,month=month,day=02}).wday
local days_in_month = {
    31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
}

local function LeapYear(currentYear)
    return currentYear % 4 == 0 and (currentYear % 100 ~= 0 or currentYear % 400 == 0)
end

if LeapYear(year) then
    days_in_month[2] = 29
end

local title = "${color1}" .. ("Sa Sun Mo Tu We Th Fr\n") .. "$color"
io.write(title)

local function seq(a,b)
    if a > b then
        return
    else
       return a, seq(a+1,b)
    end
end

local function addEmptySpaceAfter(day)
  if day < 10 then
    return " %2d "
  else
    return " %2d"
  end
end

local days = days_in_month[month]

io.write(
    string.format(
        string.rep(" ", daystart-2) ..
        string.rep(" %2d", days), seq(1,days)
    ):gsub(string.rep(".",21),"%0\n")
     :gsub(("%2d"):format(currentday),
           (conky_color):format(currentday),
           1
     ) .. "\n"
)
