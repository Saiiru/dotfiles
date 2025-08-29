#!/usr/bin/env python3
# Example: parse tasks-db.csv and print Taskwarrior commands for review.
import csv

with open('99 - Meta/tasks-db.csv') as f:
    reader = csv.DictReader(f)
    for r in reader:
        tags = r['tags'].replace(';', ' +').strip()
        cmd = f"task add "{r['description']}" project:{r['project']} due:{r['due']} +{tags}"
        print(cmd)
