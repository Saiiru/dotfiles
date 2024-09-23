#!/bin/bash
tasks=$(task overdue | grep -c -E "^[0-9]")
echo "$tasks pendentes"
