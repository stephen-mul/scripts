#!/usr/bin/env python3
### script for constructing agenda.md file ###

import sys
import re
from pathlib import Path

def search_days(content):
    days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    dates = []
    for day in days:
        day_search = re.search(rf'\b({day})\b', content)
        if day_search:
            day_start = day_search.start()
            date = content[day_start: day_start+10]
            print(date)
            dates.append(date)
    day_content = []
    ### grab content after each date but before following, shoudl not contain dates themselves ###
    for i in range(len(dates)):
        if i == len(dates) - 1:
            day_content.append(content[content.find(dates[i]):])
        else:
            day_content.append(content[content.find(dates[i]):content.find(dates[i+1])])
    for date in dates:
        for day in day_content:
            if date in day:
                ### update day content to remove date ###
                day_content[day_content.index(day)] = day.replace(date, '')
    return dates, day_content

def combine_agenda(todo_dates, todo_content, agenda_content):
    ### place schedule between /*** and ***/ ###
    schedule_list = []
    schedule_list.append('/***')
    schedule_list.append('\n')
    schedule_list.append('### Schedule ###')
    schedule_list.append('\n')
    for i in range(len(todo_dates)):
        schedule_list.append(todo_dates[i])
        schedule_list.append('\n')
        schedule_list.append(todo_content[i])
        schedule_list.append('\n')
    schedule_list.append('***/')
    schedule = ''.join(schedule_list)
    agenda_content = re.sub(r'/\*\*\*.*\*\*\*/', schedule, agenda_content, flags=re.DOTALL)
    return agenda_content


### load output of gcalcli - must be piped to script ###
def main():
    todo = sys.stdin.read()

    print(f'Agenda in python: {todo}')

    agenda_path = '/home/stephen/Documents/vault/Agenda.md'

    days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

    months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", 
            "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

    agenda = open(agenda_path, 'r')
    agenda_content = agenda.read()
    ### clean agenda - remove schedule section between /*** and ***/, on different lines ###
    #agenda_content = re.sub(r'/\*\*\*.*\*\*\*/', '', agenda_content, flags=re.DOTALL)
    print(f'agenda content: {agenda_content}')
    todo_dates, todo_content = search_days(todo)
    print(f'todo dates: {todo_dates}')
    print(f'todo content: {todo_content}') 
    agenda_content = combine_agenda(todo_dates, todo_content, agenda_content)
    print(f'agenda content: {agenda_content}')
    agenda = open(agenda_path, 'w')
    agenda.write(agenda_content)

    agenda.close()

if __name__ == '__main__':
    main()