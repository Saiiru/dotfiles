╔══════════════════════════════════════════════════════════════════════════╗
║ SOLO LEVELING LIFE OS - COMPLETE CONFIGURATION ║
║ Modular Plugin Architecture & Automation ║
╚══════════════════════════════════════════════════════════════════════════╝

# MASTER DEPLOYMENT SPECIFICATION

## 🧬 SYSTEM ARCHITECTURE OVERVIEW

```
┌─────────────────────────────────────────────────────────────────────────┐
│ OBSIDIAN VAULT (Neural Core)                                           │
├─────────────────────────────────────────────────────────────────────────┤
│ ├── CORE PLUGINS                 │ ├── INTEGRATION LAYER              │
│ │   ├── Dataview                │ │   ├── Taskwarrior Sync           │
│ │   ├── Templater               │ │   ├── Khal Calendar              │
│ │   ├── Tasks Plugin            │ │   ├── Google Calendar API        │
│ │   └── Calendar                │ │   └── Bi-directional Sync       │
│ ├── VISUAL ENHANCEMENT          │ ├── AUTOMATION LAYER               │
│ │   ├── Style Settings          │ │   ├── XP Auto-calculation        │
│ │   ├── Icon Folder             │ │   ├── Quest Generation           │
│ │   ├── File Color              │ │   ├── Progress Tracking          │
│ │   └── Multi-column            │ │   └── Notification System        │
└─────────────────────────────────────────────────────────────────────────┘
           │                        │                        │
           ▼                        ▼                        ▼
    TASKWARRIOR CLI          GOOGLE CALENDAR           KHAL TERMINAL
    (Task Management)         (Cloud Calendar)        (Local Calendar)
```

---

# 📁 MODULE 01: VAULT STRUCTURE CREATION

```bash
#!/bin/bash
# File: setup-vault-structure.sh
# Purpose: Create complete Solo Leveling vault structure

VAULT_ROOT="$HOME/obsidian-vault-solo-leveling"

echo "╔══════════════════════════════════════════════════╗"
echo "║     CREATING SOLO LEVELING VAULT STRUCTURE      ║"
echo "╚══════════════════════════════════════════════════╝"

# Create main directories
mkdir -p "$VAULT_ROOT"/{00-SYSTEM,01-SKILLS,02-QUESTS,03-DAILY,04-COURSES,05-PROJECTS,99-META}

# Create subdirectories
mkdir -p "$VAULT_ROOT/99-META"/{TEMPLATES,CSS,SCRIPTS,AUTOMATION}
mkdir -p "$VAULT_ROOT/99-META/OBSIDIAN-CONFIG"/{plugins,snippets,themes}

# Create .obsidian configuration directory
mkdir -p "$VAULT_ROOT/.obsidian"/{plugins,snippets,themes,workspace}

echo "✅ Vault structure created at: $VAULT_ROOT"
```

---

# 🔧 MODULE 02: OBSIDIAN PLUGIN CONFIGURATION MATRIX

## 📊 CORE GAMIFICATION PLUGINS

### ┌─ PLUGIN 01: DATAVIEW ─┐

```json
{
  "name": "dataview",
  "priority": "CRITICAL",
  "purpose": "Dynamic data aggregation for XP/Quest tracking",
  "configuration": {
    "enableDataviewJS": true,
    "enableInlineDataview": true,
    "enableInlineDataviewJS": true,
    "prettyRenderInlineFields": true,
    "tableGroupColumnName": "Group",
    "tableIdColumnName": "ID",
    "defaultDateFormat": "YYYY-MM-DD",
    "defaultDateTimeFormat": "YYYY-MM-DD HH:mm:ss"
  }
}
```

**Configuration Steps:**

1. Install via Community Plugins → Search "Dataview"
2. Enable JavaScript queries for complex XP calculations
3. Configure date formats for quest deadlines
4. Test with sample query: `TABLE level, xp FROM "01-SKILLS"`

### ┌─ PLUGIN 02: TEMPLATER ─┐

```json
{
  "name": "templater-obsidian",
  "priority": "CRITICAL",
  "purpose": "Automated file creation and XP logging",
  "configuration": {
    "template_folder": "99-META/TEMPLATES",
    "trigger_on_file_creation": true,
    "auto_jump_to_cursor": true,
    "enable_system_commands": true,
    "startup_templates": ["Daily-Note-Template"],
    "user_scripts_folder": "99-META/SCRIPTS"
  }
}
```

**Configuration Steps:**

1. Set template folder to `99-META/TEMPLATES`
2. Enable system commands for Taskwarrior integration
3. Configure hotkeys: Ctrl+T for template insertion
4. Create user script folder for custom functions

### ┌─ PLUGIN 03: TASKS PLUGIN ─┐

```json
{
  "name": "obsidian-tasks-plugin",
  "priority": "HIGH",
  "purpose": "Advanced task management with XP tracking",
  "configuration": {
    "globalFilter": "#task",
    "removeGlobalFilter": false,
    "setCreatedDate": true,
    "setDoneDate": true,
    "useFilenameAsScheduledDate": false,
    "debugSettings": false,
    "prioritySymbols": {
      "High": "🔺",
      "Medium": "🔶",
      "Low": "🔽"
    }
  }
}
```

**Configuration Steps:**

1. Enable creation and completion date tracking
2. Configure priority symbols for visual hierarchy
3. Set global filter for quest tasks
4. Create custom task queries for XP calculation

### ┌─ PLUGIN 04: CALENDAR ─┐

```json
{
  "name": "calendar",
  "priority": "HIGH",
  "purpose": "Visual timeline for quest tracking",
  "configuration": {
    "shouldConfirmBeforeCreate": false,
    "weekStart": "monday",
    "wordsPerDot": 250,
    "showWeeklyNote": false,
    "localeOverride": "system-default"
  }
}
```

**Configuration Steps:**

1. Set week start to Monday for consistency
2. Disable creation confirmation for rapid logging
3. Configure words per dot for visual density
4. Link with daily note creation

---

## 🎨 VISUAL ENHANCEMENT PLUGINS

### ┌─ PLUGIN 05: STYLE SETTINGS ─┐

```json
{
  "name": "obsidian-style-settings",
  "priority": "MEDIUM",
  "purpose": "Customizable HUD interface styling",
  "configuration": {
    "settingsVersion": "1.0.0",
    "preset": "solo-leveling-hud",
    "enableCSSVariables": true,
    "showStyleSettings": true
  }
}
```

**Configuration Steps:**

1. Install and enable style customization
2. Load Solo Leveling HUD preset
3. Configure color scheme: Matrix green (#00ff00)
4. Set font family: Courier New (monospace)

### ┌─ PLUGIN 06: ICON FOLDER ─┐

```json
{
  "name": "obsidian-icon-folder",
  "priority": "LOW",
  "purpose": "Visual organization with RPG-style icons",
  "configuration": {
    "migrated": 3,
    "iconPacksPath": ".obsidian/icons",
    "fontSize": 16,
    "emojiStyle": "native",
    "iconColor": null,
    "recentlyUsedSize": 20
  }
}
```

**Folder Icon Mapping:**

```yaml
folder_icons:
  "00-SYSTEM": "⚙️"
  "01-SKILLS": "⚡"
  "02-QUESTS": "🎯"
  "03-DAILY": "📅"
  "04-COURSES": "📚"
  "05-PROJECTS": "🔧"
  "99-META": "🧬"
```

### ┌─ PLUGIN 07: FILE COLOR ─┐

```json
{
  "name": "obsidian-file-color",
  "priority": "LOW",
  "purpose": "Color-coded file organization by type",
  "configuration": {
    "colorMapping": {
      "skills": "#00ff00",
      "quests": "#ffff00",
      "daily": "#0080ff",
      "courses": "#ff8000",
      "system": "#ff0080"
    }
  }
}
```

### ┌─ PLUGIN 08: MULTI-COLUMN MARKDOWN ─┐

```json
{
  "name": "multi-column-markdown",
  "priority": "MEDIUM",
  "purpose": "Dashboard layout optimization",
  "configuration": {
    "enableDefaultSyntax": true,
    "parseOnLoad": true,
    "livePreview": true,
    "removeExtraMargins": true
  }
}
```

---

## 📈 TRACKING & ANALYTICS PLUGINS

### ┌─ PLUGIN 09: OBSIDIAN TRACKER ─┐

```json
{
  "name": "obsidian-tracker",
  "priority": "HIGH",
  "purpose": "XP and habit tracking visualization",
  "configuration": {
    "defaultFolder": "03-DAILY",
    "dateFormat": "YYYY-MM-DD",
    "graphType": "line",
    "colors": ["#00ff00", "#ffff00", "#0080ff"]
  }
}
```

**Tracking Templates:**

```markdown
# XP Tracking

- xp_programming:: 0
- xp_fitness:: 0
- xp_study:: 0
- total_xp:: 0
- level:: 1
- streak_days:: 0
```

### ┌─ PLUGIN 10: HEATMAP CALENDAR ─┐

```json
{
  "name": "heatmap-calendar",
  "priority": "MEDIUM",
  "purpose": "Visual activity tracking for consistency",
  "configuration": {
    "showCurrentStreaks": true,
    "defaultEntryIntensity": 4,
    "intensityScaleStart": 1,
    "intensityScaleEnd": 5,
    "colors": {
      "1": "#0d1117",
      "2": "#0e4429",
      "3": "#006d32",
      "4": "#26a641",
      "5": "#39d353"
    }
  }
}
```

---

## 🔗 INTEGRATION & AUTOMATION PLUGINS

### ┌─ PLUGIN 11: META BIND ─┐

```json
{
  "name": "obsidian-meta-bind-plugin",
  "priority": "HIGH",
  "purpose": "Interactive UI elements for quest management",
  "configuration": {
    "devMode": false,
    "ignoreCodeBlockRestrictions": false,
    "syncMetaEdit": true,
    "useBuiltInMetaEditAPI": true
  }
}
```

**Interactive Elements Example:**

```markdown
`INPUT[slider(addLabels, minValue(1), maxValue(100)):xp_value]`
`INPUT[progressBar(addLabels):quest_progress]`
`INPUT[button(class(success), title(Complete Quest)):complete_button]`
```

### ┌─ PLUGIN 12: DBFOLDER ─┐

```json
{
  "name": "dbfolder",
  "priority": "MEDIUM",
  "purpose": "Database-like folder management",
  "configuration": {
    "enable_show_state": true,
    "enable_add_button": true,
    "enable_export": true,
    "columns_config": {
      "skills": ["name", "level", "xp", "next_level"],
      "quests": ["name", "status", "xp_reward", "deadline"]
    }
  }
}
```

---

# 🔄 MODULE 03: TASKWARRIOR INTEGRATION SYSTEM

## 📋 Taskwarrior Installation & Configuration

```bash
#!/bin/bash
# File: setup-taskwarrior.sh
# Purpose: Complete Taskwarrior setup for Solo Leveling integration

echo "╔══════════════════════════════════════════════════╗"
echo "║          TASKWARRIOR CONFIGURATION SYSTEM       ║"
echo "╚══════════════════════════════════════════════════╝"

# Install Taskwarrior (Ubuntu/Debian)
sudo apt update && sudo apt install taskwarrior -y

# Create configuration directory
mkdir -p ~/.task/hooks

# Configure Taskwarrior
cat > ~/.taskrc << 'EOF'
# Solo Leveling Life OS - Taskwarrior Configuration

# Data location
data.location=~/.task

# Default command
alias.burndown=burndown.weekly
alias.ghistory=ghistory.monthly

# UDA (User Defined Attributes) for gamification
uda.xp.type=numeric
uda.xp.label=XP Reward
uda.xp.default=1

uda.skill.type=string
uda.skill.label=Skill Type
uda.skill.values=programming,fitness,study,projects,system

uda.difficulty.type=string
uda.difficulty.label=Difficulty
uda.difficulty.values=easy,medium,hard,extreme

uda.quest_type.type=string
uda.quest_type.label=Quest Type
uda.quest_type.values=main,sub,daily

# Custom reports for gamification
report.xp.description=Tasks by XP reward
report.xp.columns=id,project,description,xp,skill,status
report.xp.sort=xp-,entry+
report.xp.filter=status:pending

report.skills.description=Tasks by skill type
report.skills.columns=id,skill,description,xp,due,status
report.skills.sort=skill+,xp-
report.skills.filter=status:pending

report.daily.description=Today's quests
report.daily.columns=id,description,xp,skill,urgency
report.daily.sort=urgency-,xp-
report.daily.filter=due:today or +daily

# Color scheme (Matrix/Solo Leveling theme)
color.due.today=color255 on_rgb013
color.active=rgb030 on_rgb001
color.project.programming=rgb030
color.project.fitness=rgb300
color.project.education=rgb003
color.tag.xp=color220
color.uda.xp=color046

# Urgency configuration
urgency.user.project.education.coefficient=15.0
urgency.user.project.skills.coefficient=10.0
urgency.user.tag.programming.coefficient=8.0
urgency.user.tag.xp.coefficient=5.0

# Sync configuration (if using Taskserver)
# taskd.certificate=~/.task/private.certificate.pem
# taskd.key=~/.task/private.key.pem
# taskd.ca=~/.task/ca.cert.pem
# taskd.server=taskwarrior.example.com:53589
# taskd.credentials=Org/User/Key

EOF

echo "✅ Taskwarrior configured with gamification support"
```

## 🔗 Obsidian-Taskwarrior Sync Hook

```bash
#!/bin/bash
# File: ~/.task/hooks/on-modify.obsidian-sync
# Purpose: Sync task changes back to Obsidian vault

VAULT_PATH="$HOME/obsidian-vault-solo-leveling"
LOG_FILE="$VAULT_PATH/03-DAILY/$(date +%Y-%m-%d).md"

# Make hook executable
chmod +x ~/.task/hooks/on-modify.obsidian-sync

# Task modification hook
cat > ~/.task/hooks/on-modify.obsidian-sync << 'EOF'
#!/bin/bash
# Obsidian sync hook for task modifications

VAULT_PATH="$HOME/obsidian-vault-solo-leveling"
TASK_LOG="$VAULT_PATH/99-META/AUTOMATION/task-sync.log"

# Get task data from stdin
read input

# Parse task JSON (requires jq)
if command -v jq >/dev/null 2>&1; then
    TASK_UUID=$(echo "$input" | jq -r '.uuid // empty')
    TASK_STATUS=$(echo "$input" | jq -r '.status // empty')
    TASK_XP=$(echo "$input" | jq -r '.xp // empty')
    TASK_DESCRIPTION=$(echo "$input" | jq -r '.description // empty')

    # Log completion to Obsidian daily note
    if [ "$TASK_STATUS" = "completed" ] && [ -n "$TASK_XP" ]; then
        TODAY_FILE="$VAULT_PATH/03-DAILY/$(date +%Y-%m-%d).md"

        # Create daily file if it doesn't exist
        if [ ! -f "$TODAY_FILE" ]; then
            cat > "$TODAY_FILE" << EOL
---
date: $(date +%Y-%m-%d)
tags: [daily, auto-generated]
---

# $(date +%Y-%m-%d)

## Completed Tasks (Auto-synced from Taskwarrior)
EOL
        fi

        # Append completed task with XP
        echo "- [x] $TASK_DESCRIPTION [+${TASK_XP} XP] (Completed: $(date '+%H:%M'))" >> "$TODAY_FILE"

        # Log to sync file
        echo "$(date): Synced completed task '$TASK_DESCRIPTION' (+${TASK_XP} XP)" >> "$TASK_LOG"
    fi
fi

# Pass through the input unchanged
echo "$input"
EOF

chmod +x ~/.task/hooks/on-modify.obsidian-sync
```

---

# 📅 MODULE 04: KHAL + GOOGLE CALENDAR INTEGRATION

## 🗓️ Khal Configuration

```bash
#!/bin/bash
# File: setup-khal-integration.sh
# Purpose: Configure Khal for calendar integration

echo "╔══════════════════════════════════════════════════╗"
echo "║           KHAL CALENDAR INTEGRATION              ║"
echo "╚══════════════════════════════════════════════════╝"

# Install Khal and dependencies
pip3 install khal vdirsyncer

# Create configuration directories
mkdir -p ~/.config/khal ~/.local/share/khal/calendars

# Khal configuration
cat > ~/.config/khal/config << 'EOF'
[calendars]

[[solo_leveling]]
path = ~/.local/share/khal/calendars/solo_leveling
type = discover
color = green

[[google_calendar]]
path = ~/.local/share/khal/calendars/google
type = discover
color = blue

[locale]
timeformat = %H:%M
dateformat = %Y-%m-%d
longdateformat = %Y-%m-%d
datetimeformat = %Y-%m-%d %H:%M
longdatetimeformat = %Y-%m-%d %H:%M

[default]
default_calendar = solo_leveling
highlight_event_days = True

[view]
agenda_event_format = {calendar-color}{start-end-time-style} {title}{repeat-symbol}{reset}
frame = color
theme = dark

# Solo Leveling specific settings
[keybindings]
new = n
duplicate = d
delete = D
edit = e
export = x
import = i
quit = q
EOF

echo "✅ Khal configured"
```

## 🔄 Vdirsyncer Configuration (Google Calendar Sync)

```ini
# File: ~/.config/vdirsyncer/config
# Purpose: Bidirectional sync with Google Calendar

[general]
status_path = "~/.local/share/vdirsyncer/status/"

# Solo Leveling local calendar
[pair solo_leveling_sync]
a = "solo_leveling_local"
b = "solo_leveling_google"
collections = ["from a", "from b"]
metadata = ["displayname", "color"]

[storage solo_leveling_local]
type = "filesystem"
path = "~/.local/share/khal/calendars/solo_leveling"
fileext = ".ics"

[storage solo_leveling_google]
type = "google_calendar"
token_file = "~/.local/share/vdirsyncer/google_token"
client_id = "YOUR_GOOGLE_CLIENT_ID"
client_secret = "YOUR_GOOGLE_CLIENT_SECRET"
```

## 📊 Obsidian-Khal Sync Script

```python
#!/usr/bin/env python3
# File: ~/.local/bin/obsidian-khal-sync.py
# Purpose: Bidirectional sync between Obsidian and Khal

import os
import re
import subprocess
from datetime import datetime, timedelta
from pathlib import Path
import yaml
import json

class ObsidianKhalSync:
    def __init__(self):
        self.vault_path = Path.home() / "obsidian-vault-solo-leveling"
        self.courses_path = self.vault_path / "04-COURSES"
        self.daily_path = self.vault_path / "03-DAILY"

    def parse_course_events(self, file_path):
        """Extract events from course files"""
        events = []

        with open(file_path, 'r') as f:
            content = f.read()

        # Parse frontmatter
        if content.startswith('---'):
            _, frontmatter, content = content.split('---', 2)
            metadata = yaml.safe_load(frontmatter)

        # Extract class schedule from tables
        table_pattern = r'\|\s*(\d+)\s*\|\s*([^|]+)\s*\|\s*([^|]+)\s*\|'
        matches = re.findall(table_pattern, content)

        for match in matches:
            class_num, date_str, time_str = match
            # Parse date and time
            try:
                date_obj = datetime.strptime(date_str.strip(), '%Y-%m-%d')
                start_time, end_time = time_str.strip().split('-')

                events.append({
                    'title': f"{metadata.get('course_name', 'Course')} - Class {class_num}",
                    'date': date_obj.strftime('%Y-%m-%d'),
                    'start_time': start_time.strip(),
                    'end_time': end_time.strip(),
                    'description': f"XP Reward: {metadata.get('xp_per_class', 30)} XP"
                })
            except ValueError as e:
                print(f"Error parsing date/time: {e}")

        return events

    def sync_to_khal(self):
        """Export Obsidian events to Khal"""
        print("🔄 Syncing Obsidian events to Khal...")

        for course_file in self.courses_path.glob("*.md"):
            events = self.parse_course_events(course_file)

            for event in events:
                # Create Khal event
                cmd = [
                    'khal', 'new',
                    f"{event['date']} {event['start_time']}",
                    '3h',  # 3 hour duration
                    event['title'],
                    '-d', event['description'],
                    '-c', 'solo_leveling'
                ]

                try:
                    result = subprocess.run(cmd, capture_output=True, text=True)
                    if result.returncode == 0:
                        print(f"✅ Added: {event['title']}")
                    else:
                        print(f"❌ Error adding {event['title']}: {result.stderr}")
                except Exception as e:
                    print(f"❌ Exception: {e}")

    def sync_from_khal(self):
        """Import Khal events to Obsidian daily notes"""
        print("🔄 Syncing Khal events to Obsidian...")

        # Get today's events from Khal
        today = datetime.now().strftime('%Y-%m-%d')
        cmd = ['khal', 'list', 'today', '--format', '{title}|{start}|{end}|{description}']

        try:
            result = subprocess.run(cmd, capture_output=True, text=True)

            if result.returncode == 0:
                today_file = self.daily_path / f"{today}.md"

                # Create daily file if it doesn't exist
                if not today_file.exists():
                    self.create_daily_file(today_file, today)

                # Parse events and add to daily file
                events = result.stdout.strip().split('\n')
                scheduled_events = []

                for event_line in events:
                    if '|' in event_line:
                        parts = event_line.split('|')
                        title, start, end = parts[0], parts[1], parts[2]
                        scheduled_events.append(f"- {start}: {title}")

                # Update daily file with events
                self.update_daily_file(today_file, scheduled_events)

        except Exception as e:
            print(f"❌ Error syncing from Khal: {e}")

    def create_skill_file(self, skill_name, xp_amount):
        """Create new skill file with template"""
        current_level = self.calculate_level(xp_amount)
        next_level_xp = current_level * 150

        skill_content = f"""---
skill_name: {skill_name.title()}
level: {current_level}
current_xp: {xp_amount}
next_level_xp: {next_level_xp}
total_xp: {xp_amount}
skill_type: auto_detected
created: {datetime.now().strftime('%Y-%m-%d')}
updated: {datetime.now().strftime('%Y-%m-%d')}
tags: [skill, {skill_name}]
---

# ⚡ {skill_name.title()} Skill

## Current Status
- **Level**: {current_level}
- **Current XP**: {xp_amount}
- **Next Level**: {next_level_xp} XP
- **Progress**: {(xp_amount % 150) / 150 * 100:.1f}%

## XP Sources
- Various tasks and activities related to {skill_name}

## Level Milestones
- **Level 2**: Basic proficiency achieved
- **Level 3**: Intermediate skills developed
- **Level 5**: Advanced mastery unlocked

## Progress History
- {datetime.now().strftime('%Y-%m-%d')}: Skill created with {xp_amount} XP
"""

        skill_file = self.skills_path / f"Skill-{skill_name.title()}.md"
        with open(skill_file, 'w') as f:
            f.write(skill_content)

    def sync_with_taskwarrior(self, xp_data):
        """Sync XP progress with Taskwarrior"""
        try:
            # Get completed tasks from Taskwarrior
            cmd = ['task', 'export', 'status:completed', 'end.after:today-7days']
            result = subprocess.run(cmd, capture_output=True, text=True)

            if result.returncode == 0 and result.stdout.strip():
                tasks = json.loads(result.stdout)

                for task in tasks:
                    if 'xp' in task and 'skill' in task:
                        skill = task['skill']
                        xp_reward = int(task.get('xp', 1))

                        # Add to our XP tracking
                        if skill not in xp_data:
                            xp_data[skill] = 0
                        xp_data[skill] += xp_reward

        except Exception as e:
            print(f"⚠️ Taskwarrior sync error: {e}")

    def generate_report(self, xp_data):
        """Generate comprehensive XP report"""
        total_xp = sum(xp_data.values())
        overall_level = self.calculate_level(total_xp)

        report = f"""
╔══════════════════════════════════════════════════╗
║               XP PROGRESS REPORT                 ║
║              {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}              ║
╚══════════════════════════════════════════════════╝

🎮 OVERALL STATS:
   Total XP: {total_xp}
   Level: {overall_level}
   Next Level: {self.xp_to_next_level(total_xp)} XP needed

⚡ SKILL BREAKDOWN:
"""

        for skill, xp in sorted(xp_data.items(), key=lambda x: x[1], reverse=True):
            level = self.calculate_level(xp)
            next_xp = self.xp_to_next_level(xp)
            progress = (xp % 150) / 150 * 100

            bar_filled = int(progress // 5)
            bar_empty = 20 - bar_filled
            progress_bar = "█" * bar_filled + "░" * bar_empty

            report += f"   {skill.title():<12} | L{level:>2} | {xp:>4} XP | [{progress_bar}] {progress:5.1f}%\n"

        return report

    def update_dashboard(self, xp_data):
        """Update main dashboard with current stats"""
        if not self.dashboard_path.exists():
            return

        total_xp = sum(xp_data.values())
        overall_level = self.calculate_level(total_xp)
        next_level_xp = self.xp_to_next_level(total_xp)

        with open(self.dashboard_path, 'r') as f:
            content = f.read()

        # Update XP values in dashboard
        content = re.sub(r'Level: \d+', f'Level: {overall_level}', content)
        content = re.sub(r'XP: \d+/\d+', f'XP: {total_xp % 150}/150', content)

        with open(self.dashboard_path, 'w') as f:
            f.write(content)

    def run_full_calculation(self):
        """Execute complete XP calculation process"""
        print("🎮 Starting XP calculation...")

        # Scan completed tasks
        xp_data = self.scan_completed_tasks()

        # Sync with Taskwarrior
        self.sync_with_taskwarrior(xp_data)

        # Update skill files
        self.update_skill_files(xp_data)

        # Update dashboard
        self.update_dashboard(xp_data)

        # Generate and display report
        report = self.generate_report(xp_data)
        print(report)

        # Save report to file
        report_file = self.vault_path / "99-META" / "AUTOMATION" / "xp-report.txt"
        report_file.parent.mkdir(exist_ok=True)

        with open(report_file, 'w') as f:
            f.write(report)

        return xp_data

if __name__ == "__main__":
    calculator = XPCalculator()
    calculator.run_full_calculation()
```

---

# 🔧 MODULE 06: QUEST AUTOMATION SYSTEM

## 🎯 Quest Generator Script

````python
#!/usr/bin/env python3
# File: ~/.local/bin/quest-generator.py
# Purpose: Automated quest creation and management

import os
import yaml
from pathlib import Path
from datetime import datetime, timedelta
import subprocess
import json

class QuestGenerator:
    def __init__(self):
        self.vault_path = Path.home() / "obsidian-vault-solo-leveling"
        self.quests_path = self.vault_path / "02-QUESTS"
        self.templates_path = self.vault_path / "99-META" / "TEMPLATES"

        self.difficulty_matrix = {
            'easy': {'duration_days': 7, 'xp_range': (10, 25)},
            'medium': {'duration_days': 30, 'xp_range': (25, 75)},
            'hard': {'duration_days': 90, 'xp_range': (75, 200)},
            'extreme': {'duration_days': 365, 'xp_range': (200, 1000)}
        }

    def create_programming_module_quest(self, module_data):
        """Create quest for programming module with classes"""

        quest_name = f"Quest-{module_data['course_name'].replace(' ', '-')}.md"
        quest_file = self.quests_path / quest_name

        # Calculate total XP reward
        total_xp = module_data['total_classes'] * module_data.get('xp_per_class', 30)

        quest_content = f"""---
quest_name: "{module_data['course_name']}"
quest_type: "sub"
difficulty: "medium"
xp_reward: {total_xp}
status: "active"
deadline: "{module_data['end_date']}"
priority: "high"
created: "{datetime.now().strftime('%Y-%m-%d')}"
updated: "{datetime.now().strftime('%Y-%m-%d')}"
tags: [quest, programming, course, {module_data.get('module_number', 1)}]
course_integration: true
---

# 🎯 {module_data['course_name']}

## Quest Overview
**Objective**: Complete all {module_data['total_classes']} classes with perfect attendance
**Reward**: {total_xp} XP ({module_data.get('xp_per_class', 30)} XP per class)
**Deadline**: {module_data['end_date']}
**Progress**: {module_data.get('attended_classes', 0)}/{module_data['total_classes']} classes

## Success Criteria
- [ ] Attend all {module_data['total_classes']} classes (19:00-22:00)
- [ ] Complete class exercises and assignments
- [ ] Take comprehensive notes for each session
- [ ] Apply learned concepts in practical projects

## Sub-Objectives (Classes)
"""

        # Add individual class objectives
        for i in range(1, module_data['total_classes'] + 1):
            status = "✅ COMPLETED" if i <= module_data.get('attended_classes', 0) else "⏳ PENDING"
            quest_content += f"- [{('x' if i <= module_data.get('attended_classes', 0) else ' ')}] Class {i} - Logic & OO Fundamentals [+{module_data.get('xp_per_class', 30)} XP] {status}\n"

        quest_content += f"""
## Penalty Contract
**Commitment**: Attend all scheduled classes
**Penalties**:
- Missing 1 class: Extra 4 hours study session
- Missing 2 classes: $50 charity donation
- Missing 3+ classes: Retake entire module

**Current Streak**: {module_data.get('attended_classes', 0)} classes

## Progress Tracking
```dataview
TABLE status, date, time, xp_earned
FROM "04-COURSES"
WHERE contains(file.name, "{module_data.get('module_number', 1)}")
````

## Taskwarrior Integration

```bash
# Export remaining classes to Taskwarrior
{self.generate_taskwarrior_commands(module_data)}
```

## Related Links

- [[04-COURSES/Module-{module_data.get('module_number', 1):02d}-Logic-Programming|Course Details]]
- [[01-SKILLS/Skill-Programming|Programming Skill]]
- [[00-SYSTEM/00-Dashboard|Dashboard]]
  """
          with open(quest_file, 'w') as f:
              f.write(quest_content)

          return quest_file

      def generate_taskwarrior_commands(self, module_data):
          """Generate Taskwarrior commands for remaining classes"""
          commands = []

          # This would be populated with actual class dates
          class_dates = [
              "2025-08-13", "2025-08-15", "2025-08-18",
              "2025-08-20", "2025-08-22", "2025-08-25",
              "2025-08-27", "2025-08-29"
          ]

          for i, date in enumerate(class_dates, 2):  # Starting from class 2
              if i > module_data.get('attended_classes', 1):  # Only future classes
                  cmd = f'task add "Programming Class {i} - Logic & OO" project:education priority:H due:{date}T19:00 xp:30 skill:programming +course'
                  commands.append(cmd)

          return '\n'.join(commands)

      def create_daily_quest_set(self):
          """Generate daily recurring quests"""

          daily_quests = [
              {
                  'name': 'Programming Deep Work',
                  'description': 'Complete focused programming session (100 minutes minimum)',
                  'xp': 1,
                  'skill': 'programming',
                  'priority': 'high'
              },
              {
                  'name': 'Physical Training',
                  'description': 'Complete physical exercise routine (100 reps or equivalent)',
                  'xp': 1,
                  'skill': 'fitness',
                  'priority': 'medium'
              },
              {
                  'name': 'OSSU Course Progress',
                  'description': 'Work on OSSU curriculum (100 minutes minimum)',
                  'xp': 1,
                  'skill': 'study',
                  'priority': 'medium'
              },
              {
                  'name': 'DAEDALUS Development',
                  'description': 'Work on KORA DAEDALUS project (100 minutes minimum)',
                  'xp': 1,
                  'skill': 'projects',
                  'priority': 'medium'
              }
          ]

          # Export to Taskwarrior as recurring tasks
          for quest in daily_quests:
              cmd = [
                  'task', 'add', quest['description'],
                  f"project:daily-quests",
                  f"priority:{quest['priority'][0].upper()}",
                  f"xp:{quest['xp']}",
                  f"skill:{quest['skill']}",
                  '+daily',
                  'recur:daily'
              ]

              try:
                  subprocess.run(cmd, check=True)
                  print(f"✅ Created daily quest: {quest['name']}")
              except subprocess.CalledProcessError as e:
                  print(f"❌ Error creating quest {quest['name']}: {e}")

      def create_ossu_quest_chain(self):
          """Create quest chain for OSSU Computer Science curriculum"""

          ossu_tracks = [
              {
                  'name': 'Core Programming',
                  'courses': ['Python for Everybody', 'Intro to Computer Science', 'How to Code'],
                  'estimated_weeks': 12,
                  'xp_reward': 300
              },
              {
                  'name': 'Core Math',
                  'courses': ['Calculus 1A', 'Linear Algebra', 'Discrete Math'],
                  'estimated_weeks': 16,
                  'xp_reward': 400
              },
              {
                  'name': 'Core Systems',
                  'courses': ['Nand2Tetris', 'Computer Systems', 'Computer Networks'],
                  'estimated_weeks': 20,
                  'xp_reward': 500
              }
          ]

          for track in ossu_tracks:
              quest_file = self.quests_path / f"Quest-OSSU-{track['name'].replace(' ', '-')}.md"

              quest_content = f"""---
  quest_name: "OSSU {track['name']}"
  quest_type: "main"
  difficulty: "hard"
  xp_reward: {track['xp_reward']}
  status: "planning"
  deadline: "{(datetime.now() + timedelta(weeks=track['estimated_weeks'])).strftime('%Y-%m-%d')}"
  priority: "high"
  created: "{datetime.now().strftime('%Y-%m-%d')}"
  tags: [quest, ossu, {track['name'].lower().replace(' ', '-')}]

---

# 🎯 OSSU {track['name']} Track

## Quest Overview

**Objective**: Complete all courses in the {track['name']} track
**Reward**: {track['xp_reward']} XP
**Estimated Duration**: {track['estimated_weeks']} weeks
**Difficulty**: Hard (requires sustained effort and discipline)

## Course Sequence

"""

            for i, course in enumerate(track['courses'], 1):
                quest_content += f"- [ ] {course} [+{track['xp_reward'] // len(track['courses'])} XP]\n"

            quest_content += f"""

## Success Criteria

- Complete all course lectures and materials
- Submit all required assignments
- Pass all quizzes and exams (minimum 80%)
- Complete capstone project if applicable

## Progress Tracking

Track progress in individual course files under `04-COURSES/`

## Prerequisites

- Completed: Basic programming knowledge
- Required: 10+ hours per week commitment
- Tools: Development environment setup

## Related Quests

- Links to individual course quests
- Dependencies on other OSSU tracks
  """
              with open(quest_file, 'w') as f:
                  f.write(quest_content)

          print(f"✅ Created {len(ossu_tracks)} OSSU quest chains")

if **name** == "**main**":
generator = QuestGenerator()

    # Example: Create quest for Module 01
    module_data = {
        'course_name': 'Nivelamento de Lógica de Programação e OO',
        'module_number': 1,
        'total_classes': 9,
        'attended_classes': 1,
        'end_date': '2025-08-29',
        'xp_per_class': 30
    }

    generator.create_programming_module_quest(module_data)
    generator.create_daily_quest_set()
    generator.create_ossu_quest_chain()

    print("✅ Quest generation completed!")

````

---

# 📦 MODULE 07: COMPREHENSIVE SETUP SCRIPT

## 🚀 Master Installation Script

```bash
#!/bin/bash
# File: setup-solo-leveling-system.sh
# Purpose: Complete automated setup of Solo Leveling Life OS

set -e  # Exit on any error

echo "
╔══════════════════════════════════════════════════════════════════════════╗
║                        SOLO LEVELING LIFE OS                            ║
║                     AUTOMATED SYSTEM DEPLOYMENT                         ║
║                                                                          ║
║  This script will set up the complete gamification system including:    ║
║  • Obsidian vault with all plugins and configurations                   ║
║  • Taskwarrior integration with XP tracking                            ║
║  • Khal + Google Calendar synchronization                              ║
║  • Automated scripts and cron jobs                                     ║
║                                                                          ║
╚══════════════════════════════════════════════════════════════════════════╝
"

# Configuration variables
VAULT_NAME="obsidian-vault-solo-leveling"
VAULT_PATH="$HOME/$VAULT_NAME"
SCRIPT_DIR="$HOME/.local/bin"
CONFIG_DIR="$HOME/.config/solo-leveling"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on supported system
check_system() {
    log_info "Checking system compatibility..."

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        log_success "Linux system detected"
        PACKAGE_MANAGER=""

        if command -v apt >/dev/null 2>&1; then
            PACKAGE_MANAGER="apt"
        elif command -v yum >/dev/null 2>&1; then
            PACKAGE_MANAGER="yum"
        elif command -v pacman >/dev/null 2>&1; then
            PACKAGE_MANAGER="pacman"
        else
            log_error "No supported package manager found"
            exit 1
        fi

        log_info "Package manager: $PACKAGE_MANAGER"
    else
        log_error "Unsupported operating system: $OSTYPE"
        exit 1
    fi
}

# Install required system packages
install_system_dependencies() {
    log_info "Installing system dependencies..."

    case $PACKAGE_MANAGER in
        "apt")
            sudo apt update
            sudo apt install -y \
                python3 python3-pip \
                taskwarrior \
                jq curl wget \
                git vim \
                build-essential
            ;;
        "yum")
            sudo yum install -y \
                python3 python3-pip \
                task \
                jq curl wget \
                git vim \
                gcc gcc-c++
            ;;
        "pacman")
            sudo pacman -S --needed \
                python python-pip \
                task \
                jq curl wget \
                git vim \
                base-devel
            ;;
    esac

    log_success "System dependencies installed"
}

# Install Python packages
install_python_dependencies() {
    log_info "Installing Python dependencies..."

    pip3 install --user \
        khal \
        vdirsyncer \
        pyyaml \
        requests \
        click \
        rich

    log_success "Python dependencies installed"
}

# Create vault structure
create_vault_structure() {
    log_info "Creating Obsidian vault structure..."

    if [ -d "$VAULT_PATH" ]; then
        log_warning "Vault directory already exists. Backing up..."
        mv "$VAULT_PATH" "${VAULT_PATH}.backup.$(date +%s)"
    fi

    # Create main directories
    mkdir -p "$VAULT_PATH"/{00-SYSTEM,01-SKILLS,02-QUESTS,03-DAILY,04-COURSES,05-PROJECTS,99-META}

    # Create subdirectories
    mkdir -p "$VAULT_PATH/99-META"/{TEMPLATES,CSS,SCRIPTS,AUTOMATION}
    mkdir -p "$VAULT_PATH/.obsidian"/{plugins,snippets,themes}

    log_success "Vault structure created at $VAULT_PATH"
}

# Setup Obsidian configuration
setup_obsidian_config() {
    log_info "Setting up Obsidian configuration..."

    # Create workspace configuration
    cat > "$VAULT_PATH/.obsidian/workspace.json" << 'EOF'
{
  "main": {
    "id": "main-workspace",
    "type": "split",
    "children": [
      {
        "id": "main-leaf",
        "type": "leaf",
        "state": {
          "type": "markdown",
          "state": {
            "file": "00-SYSTEM/00-Dashboard.md",
            "mode": "preview"
          }
        }
      }
    ],
    "direction": "vertical"
  },
  "left": {
    "id": "left-sidebar",
    "type": "split",
    "children": [
      {
        "id": "file-explorer",
        "type": "leaf",
        "state": {
          "type": "file-explorer",
          "state": {}
        }
      }
    ],
    "direction": "vertical",
    "width": 250
  },
  "right": {
    "id": "right-sidebar",
    "type": "split",
    "children": [
      {
        "id": "calendar-leaf",
        "type": "leaf",
        "state": {
          "type": "calendar",
          "state": {}
        }
      }
    ],
    "direction": "vertical",
    "width": 300
  },
  "active": "main-leaf",
  "lastOpenFiles": [
    "00-SYSTEM/00-Dashboard.md"
  ]
}
EOF

    # Create app configuration
    cat > "$VAULT_PATH/.obsidian/app.json" << 'EOF'
{
  "legacyEditor": false,
  "livePreview": true,
  "readableLineLength": false,
  "showFrontmatter": true,
  "spellcheck": false,
  "strictLineBreaks": false,
  "tabSize": 2,
  "useMarkdownLinks": false,
  "vim": false,
  "theme": "obsidian",
  "cssTheme": "solo-leveling-theme"
}
EOF

    # Create community plugins list
    cat > "$VAULT_PATH/.obsidian/community-plugins.json" << 'EOF'
[
  "dataview",
  "templater-obsidian",
  "obsidian-tasks-plugin",
  "calendar",
  "obsidian-style-settings",
  "obsidian-icon-folder",
  "obsidian-tracker",
  "heatmap-calendar",
  "obsidian-meta-bind-plugin",
  "multi-column-markdown"
]
EOF

    log_success "Obsidian configuration created"
}

# Setup Taskwarrior
setup_taskwarrior() {
    log_info "Configuring Taskwarrior..."

    # Create Taskwarrior configuration directory
    mkdir -p ~/.task/hooks

    # Copy Taskwarrior config
    cat > ~/.taskrc << 'EOF'
# Solo Leveling Life OS - Taskwarrior Configuration
data.location=~/.task
alias.burndown=burndown.weekly
alias.ghistory=ghistory.monthly

# Gamification UDAs
uda.xp.type=numeric
uda.xp.label=XP Reward
uda.xp.default=1

uda.skill.type=string
uda.skill.label=Skill Type
uda.skill.values=programming,fitness,study,projects,system

uda.difficulty.type=string
uda.difficulty.label=Difficulty
uda.difficulty.values=easy,medium,hard,extreme

uda.quest_type.type=string
uda.quest_type.label=Quest Type
uda.quest_type.values=main,sub,daily

# Custom reports
report.xp.description=Tasks by XP reward
report.xp.columns=id,project,description,xp,skill,status
report.xp.sort=xp-,entry+
report.xp.filter=status:pending

report.skills.description=Tasks by skill type
report.skills.columns=id,skill,description,xp,due,status
report.skills.sort=skill+,xp-
report.skills.filter=status:pending

report.daily.description=Today's quests
report.daily.columns=id,description,xp,skill,urgency
report.daily.sort=urgency-,xp-
report.daily.filter=due:today or +daily

# Matrix color scheme
color.due.today=color255 on_rgb013
color.active=rgb030 on_rgb001
color.project.programming=rgb030
color.project.fitness=rgb300
color.project.education=rgb003
color.tag.xp=color220
color.uda.xp=color046

# Urgency coefficients
urgency.user.project.education.coefficient=15.0
urgency.user.project.skills.coefficient=10.0
urgency.user.tag.programming.coefficient=8.0
urgency.user.tag.xp.coefficient=5.0
EOF

    log_success "Taskwarrior configured"
}

# Setup Khal calendar
setup_khal() {
    log_info "Configuring Khal calendar..."

    mkdir -p ~/.config/khal ~/.local/share/khal/calendars

    cat > ~/.config/khal/config << 'EOF'
[calendars]

[[solo_leveling]]
path = ~/.local/share/khal/calendars/solo_leveling
type = discover
color = green

[locale]
timeformat = %H:%M
dateformat = %Y-%m-%d
longdateformat = %Y-%m-%d
datetimeformat = %Y-%m-%d %H:%M
longdatetimeformat = %Y-%m-%d %H:%M

[default]
default_calendar = solo_leveling
highlight_event_days = True

[view]
agenda_event_format = {calendar-color}{start-end-time-style} {title}{repeat-symbol}{reset}
frame = color
theme = dark

[keybindings]
new = n
duplicate = d
delete = D
edit = e
export = x
import = i
quit = q
EOF

    log_success "Khal configured"
}

# Install automation scripts
install_automation_scripts() {
    log_info "Installing automation scripts..."

    mkdir -p "$SCRIPT_DIR"

    # Copy all Python scripts to user bin
    cp "$VAULT_PATH/99-META/SCRIPTS/"*.py "$SCRIPT_DIR/" 2>/dev/null || true
    chmod +x "$SCRIPT_DIR"/*.py

    # Create wrapper scripts
    cat > "$SCRIPT_DIR/solo-leveling" << EOF
#!/bin/bash
# Solo Leveling Life OS - Master Control Script

case "\$1" in
    "xp")
        python3 "$SCRIPT_DIR/xp-auto-calculator.py"
        ;;
    "sync")
        python3 "$SCRIPT_DIR/obsidian-khal-sync.py"
        "$SCRIPT_DIR/export-taskwarrior.sh"
        ;;
    "quest")
        python3 "$SCRIPT_DIR/quest-generator.py"
        ;;
    "dashboard")
        obsidian://$VAULT_NAME/00-SYSTEM/00-Dashboard.md
        ;;
    *)
        echo "Usage: solo-leveling [xp|sync|quest|dashboard]"
        echo ""
        echo "Commands:"
        echo "  xp        - Calculate and update XP across all systems"
        echo "  sync      - Synchronize between Obsidian, Taskwarrior, and Khal"
        echo "  quest     - Generate new quests and update existing ones"
        echo "  dashboard - Open main dashboard in Obsidian"
        ;;
esac
EOF

    chmod +x "$SCRIPT_DIR/solo-leveling"

    log_success "Automation scripts installed"
}

# Setup cron jobs
setup_automation() {
    log_info "Setting up automated synchronization..."

    # Add cron jobs for automation
    (crontab -l 2>/dev/null; echo "# Solo Leveling Life OS Automation") | crontab -
    (crontab -l 2>/dev/null; echo "*/30 * * * * $SCRIPT_DIR/xp-auto-calculator.py >/dev/null 2>&1") | crontab -
    (crontab -l 2>/dev/null; echo "0 */4 * * * $SCRIPT_DIR/obsidian-khal-sync.py >/dev/null 2>&1") | crontab -
    (crontab -l 2>/dev/null; echo "0 0 * * * $SCRIPT_DIR/daily-quest-generator.py >/dev/null 2>&1") | crontab -

    log_success "Automation scheduled"
}

# Create initial content
create_initial_content() {
    log_info "Creating initial content..."

    # Create main dashboard
    cat > "$VAULT_PATH/00-SYSTEM/00-Dashboard.md" << 'EOF'
---
cssclasses: [solo-hud, dashboard]
tags: [system, dashboard]
---

    cat > "$VAULT_PATH/00-SYSTEM/00-Dashboard.md" << 'EOF'
---
cssclasses: [solo-hud, dashboard]
tags: [system, dashboard]
---

<div class="hud-container">
<div class="hud-header">
<h1>🎮 SOLO LEVELING LIFE OS</h1>
<div class="level-indicator">Level: 1 | XP: 0/150</div>
</div>

<div class="hud-grid">
<div class="stat-card">
<h3>📊 CURRENT STATS</h3>

**Total XP**: 0
**Current Level**: 1
**Next Level**: 150 XP
**Active Skills**: 0
**Active Quests**: 0
**Completed Today**: 0
</div>

<div class="quest-card">
<h3>🎯 ACTIVE QUESTS</h3>

```dataview
TABLE status as Status, xp_reward as "XP Reward", deadline as Due
FROM "02-QUESTS"
WHERE status != "completed"
SORT priority DESC, deadline ASC
LIMIT 5
````

</div>

<div class="skill-card">
<h3>⚡ SKILL PROGRESSION</h3>

```dataview
TABLE level as Level, current_xp as "Current XP", next_level_xp as "Next Level"
FROM "01-SKILLS"
SORT level DESC
LIMIT 5
```

</div>
</div>

<div class="quick-actions">
<h3>⚡ QUICK ACTIONS</h3>

- [[01-XP-Logger|🎯 Log XP]]
- [[02-Skills-DB|⚡ View Skills]]
- [[03-Quests-DB|📋 Manage Quests]]
- [[99-System-Manual|📖 System Manual]]
  </div>
  </div>
  EOF

      # Create XP Logger
      cat > "$VAULT_PATH/00-SYSTEM/01-XP-Logger.md" << 'EOF'

---

## tags: [system, xp, tracking]

# 📈 XP LOGGING SYSTEM

## XP CONVERSION RULES

- Programming: 100 minutes = 1 XP
- Exercise: 100 reps = 1 XP
- Study: 100 minutes = 1 XP
- Projects: 100 minutes = 1 XP
- Reading: 100 pages = 1 XP

## TODAY'S XP LOG

### Programming

- [ ] Deep work session 1 (100min) [+1 XP] #programming
- [ ] Deep work session 2 (100min) [+1 XP] #programming
- [ ] Deep work session 3 (100min) [+1 XP] #programming

### Physical Training

- [ ] Push-ups (100 reps) [+1 XP] #fitness
- [ ] Squats (100 reps) [+1 XP] #fitness
- [ ] Cardio (100 minutes) [+1 XP] #fitness

### Study & Research

- [ ] OSSU Math (100 minutes) [+1 XP] #mathematics
- [ ] Technical Reading (100 pages) [+1 XP] #knowledge

### Projects

- [ ] KORA DAEDALUS (100 minutes) [+1 XP] #projects
- [ ] Hyprland Config (100 minutes) [+1 XP] #system
      EOF

      # Create Skills Database
      cat > "$VAULT_PATH/00-SYSTEM/02-Skills-DB.md" << 'EOF'

---

## tags: [system, skills, database]

# ⚡ SKILLS DATABASE

## SKILL TREE OVERVIEW

```dataview
TABLE level as Level, current_xp as "Current XP", next_level_xp as "Next Level", total_xp as "Total XP"
FROM "01-SKILLS"
SORT level DESC, current_xp DESC
```

## SKILL PROGRESSION FORMULAS

- **Level 1→2**: 150 XP
- **Level 2→3**: 300 XP
- **Level 3→4**: 450 XP
- **Level N→N+1**: N × 150 XP
  EOF

      # Create initial programming skill
      cat > "$VAULT_PATH/01-SKILLS/Skill-Programming.md" << 'EOF'

---

skill_name: Programming
level: 1
current_xp: 0
next_level_xp: 150
total_xp: 0
skill_type: technical
created: 2025-08-13
updated: 2025-08-13
tags: [skill, programming]

---

# ⚡ Programming Skill

## Current Status

- **Level**: 1
- **Current XP**: 0
- **Next Level**: 150 XP
- **Progress**: 0.0%

## XP Sources

- Deep work programming sessions (100 minutes = 1 XP)
- Completing programming assignments
- Building projects and applications
- Code reviews and debugging

## Level Milestones

- **Level 2**: Basic programming competency
- **Level 3**: Intermediate problem solving
- **Level 5**: Advanced development skills
- **Level 10**: Expert-level mastery
  EOF

      # Create Module 01 course
      cat > "$VAULT_PATH/04-COURSES/Module-01-Logic-Programming.md" << 'EOF'

---

course_name: "Nivelamento de Lógica de Programação e OO"
module_number: 1
status: active
progress: 11.11
total_classes: 9
attended_classes: 1
start_date: 2025-08-11
end_date: 2025-08-29
schedule: "19:00-22:00"
xp_per_class: 30
tags: [programming, logic, oo, active-course]

---

# 💻 Module 01 - Logic Programming

## CLASS SCHEDULE

| Class | Date       | Time        | Status       | XP Earned | Notes        |
| ----- | ---------- | ----------- | ------------ | --------- | ------------ |
| 1     | 2025-08-11 | 19:00-22:00 | ✅ COMPLETED | 30 XP     | Introduction |
| 2     | 2025-08-13 | 19:00-22:00 | 🔄 TODAY     | 0 XP      | -            |
| 3     | 2025-08-15 | 19:00-22:00 | ⏳ PENDING   | 0 XP      | -            |
| 4     | 2025-08-18 | 19:00-22:00 | ⏳ PENDING   | 0 XP      | -            |
| 5     | 2025-08-20 | 19:00-22:00 | ⏳ PENDING   | 0 XP      | -            |
| 6     | 2025-08-22 | 19:00-22:00 | ⏳ PENDING   | 0 XP      | -            |
| 7     | 2025-08-25 | 19:00-22:00 | ⏳ PENDING   | 0 XP      | -            |
| 8     | 2025-08-27 | 19:00-22:00 | ⏳ PENDING   | 0 XP      | -            |
| 9     | 2025-08-29 | 19:00-22:00 | ⏳ PENDING   | 0 XP      | Final        |

## Progress Metrics

- **Attendance Rate**: 11.11% (1/9)
- **Total XP Earned**: 30 XP
- **Projected Total XP**: 270 XP
  EOF

      # Create KORA DAEDALUS project
      cat > "$VAULT_PATH/05-PROJECTS/KORA-DAEDALUS-System.md" << 'EOF'

---

title: KORA DAEDALUS System
tags: [project, daedalus, ai, hardware, active]
status: active
priority: high
progress: 15
started: 2025-08-10
updated: 2025-08-13
deadline: 2025-12-31
estimated_hours: 120

---

# 🧠 KORA DAEDALUS — Neural Framework Core Project

## PROJECT OVERVIEW

**Mission**: Develop autonomous experimental assistance framework
**Status**: Active Development - Foundation Phase
**Progress**: 15%

## ACTIVE TASKS

- [ ] Implement Pico HUD prototype (ESP32 + OLED) [+50 XP] #hardware
- [ ] Create Taskwarrior synchronization script [+25 XP] #programming
- [ ] Set up Raspberry Pi development environment [+30 XP] #system
- [ ] Design API specification for inter-module communication [+30 XP] #programming

## XP TRACKING

- Hardware development: 100 minutes = 1 XP
- Programming tasks: 100 minutes = 1 XP
- System configuration: 100 minutes = 1 XP
  EOF

      log_success "Initial content created"

  }

# Create CSS styling

create_css_styling() {
log_info "Creating CSS styling..."

    cat > "$VAULT_PATH/.obsidian/snippets/solo-leveling-hud.css" << 'EOF'

/_ Solo Leveling Life OS - HUD Styling _/

.solo-hud {
font-family: 'Courier New', monospace;
background: linear-gradient(135deg, #0a0a0a, #1a1a2e);
color: #00ff00;
}

.hud-container {
max-width: 1400px;
margin: 0 auto;
padding: 20px;
}

.hud-header {
text-align: center;
margin-bottom: 30px;
border-bottom: 2px solid #00ff00;
padding-bottom: 15px;
}

.hud-header h1 {
color: #00ff00;
text-shadow: 0 0 10px #00ff00;
font-size: 2.5em;
margin: 0;
}

.level-indicator {
font-size: 1.2em;
color: #ffff00;
margin-top: 10px;
}

.hud-grid {
display: grid;
grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
gap: 20px;
margin-bottom: 30px;
}

.stat-card, .quest-card, .skill-card, .course-card, .penalty-card, .routine-card {
background: rgba(0, 255, 0, 0.1);
border: 1px solid #00ff00;
border-radius: 8px;
padding: 20px;
box-shadow: 0 0 15px rgba(0, 255, 0, 0.3);
}

.stat-card h3, .quest-card h3, .skill-card h3, .course-card h3, .penalty-card h3, .routine-card h3 {
color: #00ff00;
margin-top: 0;
border-bottom: 1px solid #00ff00;
padding-bottom: 10px;
}

.quick-actions {
background: rgba(255, 255, 0, 0.1);
border: 1px solid #ffff00;
border-radius: 8px;
padding: 20px;
margin-top: 20px;
}

.quick-actions h3 {
color: #ffff00;
margin-top: 0;
}

/_ Quest Status Colors _/
.quest-active { color: #00ff00; }
.quest-completed { color: #ffff00; }
.quest-failed { color: #ff0000; }
.quest-paused { color: #ff8800; }

/_ XP Progress Bars _/
.xp-bar {
width: 100%;
height: 20px;
background: #333;
border-radius: 10px;
overflow: hidden;
margin: 10px 0;
}

.xp-progress {
height: 100%;
background: linear-gradient(90deg, #00ff00, #ffff00);
transition: width 0.3s ease;
box-shadow: 0 0 10px rgba(0, 255, 0, 0.5);
}

/_ Responsive Design _/
@media (max-width: 768px) {
.hud-grid {
grid-template-columns: 1fr;
}

.hud-header h1 {
font-size: 1.8em;
}
}

/_ Animation Effects _/
@keyframes levelUp {
0% { transform: scale(1); }
50% { transform: scale(1.1); }
100% { transform: scale(1); }
}

.level-up {
animation: levelUp 0.5s ease;
}
EOF

    log_success "CSS styling created"

}

# Create templates

create_templates() {
log_info "Creating templates..."

    # Daily note template
    cat > "$VAULT_PATH/99-META/TEMPLATES/Daily-Note-Template.md" << 'EOF'

---

date: {{date}}
day_of_week: {{date:dddd}}
tags: [daily, log]

---

# {datetime.now().strftime('%Y-%m-%d')}

## 🎯 Daily Quest Objectives

- [ ] Programming Deep Work (100min) [+1 XP] #programming
- [ ] Physical Training (100 reps) [+1 XP] #fitness
- [ ] OSSU Course Progress (100min) [+1 XP] #study
- [ ] DAEDALUS Development (100min) [+1 XP] #projects

## 📊 XP Tracking

**XP Earned Today**: 0
**Current Streak**: 0 days

## ✅ Completed Tasks (Auto-synced from Taskwarrior)

## 📝 Notes & Reflections

## 🔗 Quick Links

- [[00-SYSTEM/00-Dashboard|📊 Dashboard]]
  """
          with open(file_path, 'w') as f:
              f.write(template_content)

      def append_to_daily_file(self, file_path, completed_tasks, total_xp):
          """Append completed tasks to daily file"""
          with open(file_path, 'r') as f:
              content = f.read()

          # Update XP tracking
          xp_pattern = r'(\*\*XP Earned Today\*\*:\s*)(\d+)'
          current_xp = int(re.search(xp_pattern, content).group(2)) if re.search(xp_pattern, content) else 0
          new_xp = current_xp + total_xp
          content = re.sub(xp_pattern, f'\\g<1>{new_xp}', content)

          # Add completed tasks
          completed_section = "## ✅ Completed Tasks (Auto-synced from Taskwarrior)\n\n"
          for task in completed_tasks:
              completed_section += task + "\n"
          completed_section += "\n"

          # Replace the completed tasks section
          pattern = r'## ✅ Completed Tasks.*?\n\n(.*?\n\n)?'
          content = re.sub(pattern, completed_section, content, flags=re.DOTALL)

          with open(file_path, 'w') as f:
              f.write(content)

      def extract_and_sync_course_events(self, content):
          """Extract course events and sync with Khal"""
          # Parse course table for dates and times
          table_pattern = r'\|\s*(\d+)\s*\|\s*([^|]+)\s*\|\s*([^|]+)\s*\|'
          matches = re.findall(table_pattern, content)

          for match in matches:
              class_num, date_str, time_str = match
              try:
                  # Parse and create Khal event
                  date_obj = datetime.strptime(date_str.strip(), '%Y-%m-%d')
                  if 'PENDING' in content or 'TODAY' in content:
                      start_time, end_time = time_str.strip().split('-')

                      cmd = [
                          'khal', 'new',
                          f"{date_obj.strftime('%Y-%m-%d')} {start_time.strip()}",
                          '3h',
                          f"Programming Class {class_num}",
                          '-d', 'XP Reward: 30 XP',
                          '-c', 'solo_leveling'
                      ]

                      subprocess.run(cmd, capture_output=True)

              except Exception as e:
                  self.logger.error(f"Error creating calendar event: {e}")

      async def run_full_sync(self):
          """Execute complete bidirectional synchronization"""
          self.logger.info("🚀 Starting complete system synchronization")

          try:
              await self.sync_obsidian_to_taskwarrior()
              await self.sync_taskwarrior_to_obsidian()
              await self.sync_khal_calendar()

              # Update XP calculations
              subprocess.run(['python3', str(Path.home() / '.local' / 'bin' / 'xp-auto-calculator.py')])

              self.logger.info("✅ Complete synchronization finished successfully")

          except Exception as e:
              self.logger.error(f"❌ Synchronization failed: {e}")
              raise

if **name** == "**main**":
import re
sync_manager = CompleteSyncManager()
asyncio.run(sync_manager.run_full_sync())

````

---

# 📋 MODULE 10: STEP-BY-STEP SETUP GUIDE

## 🎯 PHASE 1: SYSTEM PREPARATION (30 minutes)

### Step 1.1: Download and Run Master Setup
```bash
# Download the setup script
curl -fsSL https://raw.githubusercontent.com/your-repo/solo-leveling-setup.sh -o setup-solo-leveling.sh

# Make executable and run
chmod +x setup-solo-leveling.sh
./setup-solo-leveling.sh
````

### Step 1.2: Install Obsidian

```bash
# Ubuntu/Debian
wget -O obsidian.deb https://github.com/obsidianmd/obsidian-releases/releases/download/v1.4.13/obsidian_1.4.13_amd64.deb
sudo dpkg -i obsidian.deb

# Arch Linux
yay -S obsidian

# Flatpak (Universal)
flatpak install flathub md.obsidian.Obsidian
```

### Step 1.3: Verify Installation

```bash
# Check if all tools are installed
task --version
khal --version
python3 -c "import yaml, requests; print('Python deps OK')"
ls -la ~/.local/bin/solo-leveling
```

---

## 🔧 PHASE 2: OBSIDIAN PLUGIN CONFIGURATION (45 minutes)

### Step 2.1: Essential Plugins Setup

#### 1. DATAVIEW Configuration

1. **Install**: Community Plugins → Search "Dataview" → Install → Enable
2. **Settings**:
   - ✅ Enable JavaScript Queries
   - ✅ Enable Inline Queries
   - ✅ Enable Inline JavaScript
   - Date Format: `YYYY-MM-DD`
   - DateTime Format: `YYYY-MM-DD HH:mm`

#### 2. TEMPLATER Configuration

1. **Install**: Community Plugins → Search "Templater" → Install → Enable
2. **Settings**:
   - Template Folder: `99-META/TEMPLATES`
   - ✅ Trigger Templater on new file creation
   - ✅ Enable System Commands
   - Script Files Folder: `99-META/SCRIPTS`
3. **Hotkeys**: Settings → Hotkeys → Templater → Set "Insert Template" to `Ctrl+T`

#### 3. TASKS PLUGIN Configuration

1. **Install**: Community Plugins → Search "Tasks" → Install → Enable
2. **Settings**:
   - ✅ Set created date when a task is created
   - ✅ Set done date when a task is completed
   - Global Task Filter: `#task`
   - Priority Symbols:
     - High: `🔺`
     - Medium: `🔶`
     - Low: `🔽`

#### 4. CALENDAR Configuration

1. **Install**: Community Plugins → Search "Calendar" → Install → Enable
2. **Settings**:
   - Week Start: `Monday`
   - ✅ Confirm before creating
   - Words per dot: `250`

### Step 2.2: Visual Enhancement Plugins

#### 5. STYLE SETTINGS Configuration

1. **Install**: Community Plugins → Search "Style Settings" → Install → Enable
2. **Apply Solo Leveling Theme**:
   - Go to Settings → Style Settings
   - Look for "Solo Leveling Theme" section
   - Configure colors:
     - Primary Accent: `#00ff00`
     - Background: `#0a0a0a`
     - Surface: `#1a1a2e`
   - Enable animations and effects

#### 6. ICON FOLDER Configuration

1. **Install**: Community Plugins → Search "Icon Folder" → Install → Enable
2. **Set Folder Icons**:
   - Right-click folders → Change Icon
   - `00-SYSTEM`: ⚙️
   - `01-SKILLS`: ⚡
   - `02-QUESTS`: 🎯
   - `03-DAILY`: 📅
   - `04-COURSES`: 📚
   - `05-PROJECTS`: 🔧

#### 7. MULTI-COLUMN MARKDOWN Configuration

1. **Install**: Community Plugins → Search "Multi-Column Markdown" → Install → Enable
2. **Settings**:
   - ✅ Enable live preview
   - ✅ Parse on load
   - Column syntax: Default

### Step 2.3: Tracking & Analytics Plugins

#### 8. OBSIDIAN TRACKER Configuration

1. **Install**: Community Plugins → Search "Tracker" → Install → Enable
2. **Settings**:
   - Default Folder: `03-DAILY`
   - Date Format: `YYYY-MM-DD`
   - Default Graph Type: `line`

#### 9. HEATMAP CALENDAR Configuration

1. **Install**: Community Plugins → Search "Heatmap Calendar" → Install → Enable
2. **Settings**:
   - ✅ Show current streaks
   - Intensity Scale: 1-5
   - Colors: Green gradient (GitHub-style)

#### 10. META BIND Configuration

1. **Install**: Community Plugins → Search "Meta Bind" → Install → Enable
2. **Settings**:
   - ✅ Sync with Meta Edit
   - ✅ Enable built-in API

---

## 🔄 PHASE 3: INTEGRATION SETUP (60 minutes)

### Step 3.1: Taskwarrior Integration

#### Configure Taskwarrior Profile

```bash
# Backup existing config
cp ~/.taskrc ~/.taskrc.backup 2>/dev/null || true

# Apply Solo Leveling configuration
cat > ~/.taskrc << 'EOF'
# Solo Leveling Life OS - Taskwarrior Configuration
data.location=~/.task

# Gamification UDAs
uda.xp.type=numeric
uda.xp.label=XP Reward
uda.xp.default=1

uda.skill.type=string
uda.skill.label=Skill Type
uda.skill.values=programming,fitness,study,projects,system

uda.difficulty.type=string
uda.difficulty.label=Difficulty
uda.difficulty.values=easy,medium,hard,extreme

uda.quest_type.type=string
uda.quest_type.label=Quest Type
uda.quest_type.values=main,sub,daily

# XP-focused reports
report.xp.description=Tasks by XP reward
report.xp.columns=id,project,description,xp,skill,status
report.xp.sort=xp-,entry+
report.xp.filter=status:pending

report.daily.description=Today's quests
report.daily.columns=id,description,xp,skill,urgency
report.daily.sort=urgency-,xp-
report.daily.filter=due:today or +daily

# Solo Leveling color scheme
color.due.today=color255 on_rgb013
color.active=rgb030 on_rgb001
color.project.programming=rgb030
color.project.fitness=rgb300
color.project.education=rgb003
color.tag.xp=color220

# Urgency boost for XP tasks
urgency.user.tag.xp.coefficient=5.0
urgency.user.project.education.coefficient=15.0
EOF
```

#### Test Taskwarrior Setup

```bash
# Create test tasks with XP
task add "Programming Deep Work Session" project:skills xp:1 skill:programming +daily
task add "Programming Class 2" project:education xp:30 skill:programming due:2025-08-13T19:00

# Verify XP report works
task xp
task daily
```

### Step 3.2: Khal Calendar Integration

#### Setup Khal Configuration

```bash
mkdir -p ~/.config/khal ~/.local/share/khal/calendars

cat > ~/.config/khal/config << 'EOF'
[calendars]

[[solo_leveling]]
path = ~/.local/share/khal/calendars/solo_leveling
type = discover
color = green

[locale]
timeformat = %H:%M
dateformat = %Y-%m-%d
longdateformat = %Y-%m-%d
datetimeformat = %Y-%m-%d %H:%M

[default]
default_calendar = solo_leveling
highlight_event_days = True

[view]
theme = dark
EOF
```

#### Add Initial Events

```bash
# Create programming class events
khal new 2025-08-13 19:00 3h "Programming Class 2 - Logic & OO" -d "XP Reward: 30 XP" -c solo_leveling
khal new 2025-08-15 19:00 3h "Programming Class 3 - Logic & OO" -d "XP Reward: 30 XP" -c solo_leveling
khal new 2025-08-18 19:00 3h "Programming Class 4 - Logic & OO" -d "XP Reward: 30 XP" -c solo_leveling

# Verify events
khal list today 30d
```

### Step 3.3: Google Calendar Sync (Optional)

#### Setup Google Calendar API

```bash
# Install additional dependencies
pip3 install --user google-auth google-auth-oauthlib google-auth-httplib2 google-api-python-client

# Configure vdirsyncer for Google Calendar
mkdir -p ~/.config/vdirsyncer

cat > ~/.config/vdirsyncer/config << 'EOF'
[general]
status_path = "~/.local/share/vdirsyncer/status/"

[pair solo_leveling_google]
a = "solo_leveling_local"
b = "solo_leveling_google"
collections = ["from a", "from b"]

[storage solo_leveling_local]
type = "filesystem"
path = "~/.local/share/khal/calendars/solo_leveling"
fileext = ".ics"

# Configure this with your Google API credentials
[storage solo_leveling_google]
type = "google_calendar"
token_file = "~/.local/share/vdirsyncer/google_token"
client_id = "YOUR_GOOGLE_CLIENT_ID_HERE"
client_secret = "YOUR_GOOGLE_CLIENT_SECRET_HERE"
EOF

echo "⚠️  Google Calendar sync requires API credentials setup"
echo "📝  Follow: https://developers.google.com/calendar/quickstart/python"
```

---

## 🤖 PHASE 4: AUTOMATION ACTIVATION (30 minutes)

### Step 4.1: Enable CSS Styling

```bash
# Enable the Solo Leveling HUD CSS
cd ~/obsidian-vault-solo-leveling/.obsidian/snippets
echo "✅ CSS snippet created: solo-leveling-hud.css"
echo "📝 Go to Obsidian → Settings → Appearance → CSS Snippets"
echo "🔄 Enable 'solo-leveling-hud' snippet"
```

### Step 4.2: Setup Cron Automation

```bash
# Add automation cron jobs
(crontab -l 2>/dev/null; cat << 'EOF'
# Solo Leveling Life OS Automation
*/30 * * * * ~/.local/bin/xp-auto-calculator.py >/dev/null 2>&1
0 */4 * * * ~/.local/bin/complete-sync-manager.py >/dev/null 2>&1
0 6 * * * ~/.local/bin/daily-quest-generator.py >/dev/null 2>&1
EOF
) | crontab -

echo "✅ Automation scheduled:"
echo "   • XP calculation: Every 30 minutes"
echo "   • Full sync: Every 4 hours"
echo "   • Daily quest generation: 6 AM daily"
```

### Step 4.3: Test Integration

```bash
# Test the complete system
echo "🧪 Testing integration..."

# 1. Test XP calculation
~/.local/bin/xp-auto-calculator.py

# 2. Test sync
~/.local/bin/complete-sync-manager.py

# 3. Test quest generation
~/.local/bin/quest-generator.py

# 4. Test main command
solo-leveling dashboard
```

---

## 🎮 PHASE 5: SYSTEM ACTIVATION (15 minutes)

### Step 5.1: Open Obsidian and Load Vault

1. **Open Obsidian**
2. **Open Folder as Vault** → Select `~/obsidian-vault-solo-leveling`
3. **Trust Author and Enable Plugins** when prompted
4. **Go to Settings → Community Plugins → Enable all installed plugins**

### Step 5.2: Apply CSS Theme

1. **Settings → Appearance → CSS Snippets**
2. **Enable `solo-leveling-hud`**
3. **Refresh** (Ctrl+R) to see styling changes

### Step 5.3: Configure Workspace

1. **Pin Dashboard**: Right-click `00-SYSTEM/00-Dashboard.md` → Pin
2. **Enable Calendar**: Right sidebar → Calendar icon
3. **Configure File Explorer**: Left sidebar → Show folders

### Step 5.4: Test Complete Workflow

```bash
# 1. Complete a test task in Taskwarrior
task add "Test XP Task" xp:5 skill:programming +test
task done 1

# 2. Check if it appears in Obsidian daily log
cat ~/obsidian-vault-solo-leveling/03-DAILY/$(date +%Y-%m-%d).md

# 3. Add a calendar event
khal new tomorrow 14:00 1h "Test Event"

# 4. Run full sync
solo-leveling sync

# 5. Check dashboard for updates
solo-leveling dashboard
```

---

## ✅ VERIFICATION CHECKLIST

### Core System ✓

- [ ] Obsidian vault created with correct folder structure
- [ ] All 10 essential plugins installed and configured
- [ ] CSS styling applied and working
- [ ] Dashboard displays correctly with live data

### Integration ✓

- [ ] Taskwarrior configured with XP tracking
- [ ] Khal calendar working with events
- [ ] Bidirectional sync functioning
- [ ] Automation scripts executable

### Content ✓

- [ ] Programming Module 01 course loaded
- [ ] OSSU curriculum structure created
- [ ] KORA DAEDALUS project integrated
- [ ] Daily note templates working

### Automation ✓

- [ ] Cron jobs scheduled and running
- [ ] XP auto-calculation working
- [ ] Quest generation functional
- [ ] Sync logs being created

---

## 🚨 TROUBLESHOOTING GUIDE

### Common Issues & Solutions

#### "Dataview queries not working"

```bash
# Solution: Check plugin installation
# 1. Settings → Community Plugins → Ensure Dataview is enabled
# 2. Refresh vault (Ctrl+R)
# 3. Check syntax in queries
```

#### "Taskwarrior UDA errors"

```bash
# Solution: Reset Taskwarrior config
cp ~/.taskrc.backup ~/.taskrc  # Restore backup
# Or recreate config using setup script
```

#### "CSS styling not applied"

```bash
# Solution: Enable CSS snippet
# 1. Settings → Appearance → CSS Snippets
# 2. Enable "solo-leveling-hud"
# 3. Refresh (Ctrl+R)
```

#### "Sync scripts failing"

```bash
# Solution: Check permissions and dependencies
chmod +x ~/.local/bin/solo-leveling
pip3 install --user pyyaml requests
```

#### "Calendar events not syncing"

```bash
# Solution: Check Khal configuration
khal configure  # Interactive setup
khal list  # Test calendar access
```

---

## 🎯 NEXT STEPS AFTER SETUP

### Immediate Actions (First Day)

1. **Complete your first XP logging session**
2. **Attend Programming Class 2 (if today is 2025-08-13)**
3. **Create your first custom skill**
4. **Set up a behavioral contract with real penalties**

### Week 1 Goals

1. **Establish daily routine**: Peak hours 19:00-22:00
2. **Complete 5+ XP-earning activities**
3. **Sync all systems successfully**
4. **Customize dashboard to your preferences**

### Month 1 Objectives

1. **Reach Level 2 in Programming skill** (150 XP)
2. **Complete Module 01 course** (9 classes, 270 XP)
3. **Create advanced quest chains**
4. **Optimize your personal XP rates**

### Long-term Vision

1. **Complete OSSU Computer Science curriculum**
2. **Develop KORA DAEDALUS project to completion**
3. **Master your chosen skill areas to Level 10+**
4. **Help others implement similar systems**

---

**CONGRATULATIONS! 🎉**

Your **Solo Leveling Life OS** is now fully operational. You have transformed your life into an engaging RPG where every action contributes to measurable growth. The system will automatically track your progress, sync across platforms, and gamify your journey toward mastery.

## **Remember**: The real power comes from consistent use. Start small, stay consistent, and watch yourself level up! 🚀✨

# 📅 {{title}}

## 🎯 Daily Quest Objectives

- [ ] Programming Deep Work (100min) [+1 XP] #programming
- [ ] Physical Training (100 reps) [+1 XP] #fitness
- [ ] OSSU Course Progress (100min) [+1 XP] #study
- [ ] DAEDALUS Development (100min) [+1 XP] #projects

## 📊 XP Tracking

**XP Earned Today**: 0
**XP Goal**: 4 XP minimum
**Current Streak**: 0 days

## 🕐 Time Blocks

- **06:00-07:00**: Physical Training
- **19:00-22:00**: Peak Focus (Programming/Study)
- **22:00-23:00**: XP Logging & Planning

## 📝 Notes & Reflections

_What went well:_

_What to improve:_

_Tomorrow's priority:_

## 🔗 Links

- [[00-SYSTEM/00-Dashboard|📊 Dashboard]]
- [[{{date:YYYY-MM-DD|date-1d}}|← Yesterday]] | [[{{date:YYYY-MM-DD|date+1d}}|Tomorrow →]]
  EOF

      # Quest template
      cat > "$VAULT_PATH/99-META/TEMPLATES/Quest-Template.md" << 'EOF'

---

quest_name: ""
quest_type: [main/sub/daily]
difficulty: [easy/medium/hard/extreme]
xp_reward: 0
status: [planning/active/paused/completed/failed]
deadline:
priority: [low/medium/high/critical]
created: {{date}}
updated: {{date}}
tags: [quest]

---

# 🎯 {{title}}

## Quest Overview

**Objective**:
**Reward**: {{xp_reward}} XP
**Deadline**: {{deadline}}
**Estimated Time**:

## Success Criteria

- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Sub-Objectives

- [ ] Sub-objective 1 [+XP]
- [ ] Sub-objective 2 [+XP]
- [ ] Sub-objective 3 [+XP]

## Penalty Contract

**Failure Penalty**:
**Accountability**:

## Progress Log

- {{date}}: Quest created

## Related Links

- **Skills**: [[]]
- **Projects**: [[]]
- **Courses**: [[]]
  EOF

      log_success "Templates created"

  }

# Finalize setup

finalize_setup() {
log_info "Finalizing setup..."

    # Add solo-leveling command to PATH
    if ! grep -q "$SCRIPT_DIR" ~/.bashrc; then
        echo "export PATH=\"\$PATH:$SCRIPT_DIR\"" >> ~/.bashrc
    fi

    # Create desktop shortcut
    if [ -d "$HOME/Desktop" ]; then
        cat > "$HOME/Desktop/Solo-Leveling-Dashboard.desktop" << EOF

[Desktop Entry]
Version=1.0
Type=Application
Name=Solo Leveling Dashboard
Comment=Open Solo Leveling Life OS Dashboard
Exec=xdg-open "obsidian://open?vault=$VAULT_NAME&file=00-SYSTEM%2F00-Dashboard.md"
Icon=applications-games
Terminal=false
Categories=Productivity;Office;
EOF
        chmod +x "$HOME/Desktop/Solo-Leveling-Dashboard.desktop"
fi

    log_success "Setup finalized"

}

# Display completion message

show_completion_message() {
echo "
╔══════════════════════════════════════════════════════════════════════════╗
║ SETUP COMPLETED! ║
╚══════════════════════════════════════════════════════════════════════════╝

🎮 SOLO LEVELING LIFE OS has been successfully installed!

📁 Vault Location: $VAULT_PATH
🔧 Scripts Location: $SCRIPT_DIR

🚀 QUICK START:

1. Open Obsidian and add your vault: $VAULT_PATH
2. Install community plugins from the list in .obsidian/community-plugins.json
3. Enable the CSS snippet: solo-leveling-hud.css
4. Run: solo-leveling dashboard (or open 00-SYSTEM/00-Dashboard.md)

⚡ COMMAND LINE TOOLS:
• solo-leveling xp - Calculate XP across all systems
• solo-leveling sync - Synchronize Obsidian ↔ Taskwarrior ↔ Khal  
• solo-leveling quest - Generate and manage quests
• solo-leveling dashboard - Open main dashboard

📅 CALENDAR INTEGRATION:
• Khal: 'khal list' to see your schedule
• Taskwarrior: 'task list' to see active quests
• Google Calendar: Use vdirsyncer to sync (configure API keys)

🔄 AUTOMATION:
• XP calculation runs every 30 minutes
• Calendar sync happens every 4 hours  
• Daily quest generation at midnight

🎯 NEXT STEPS:

1. Configure Google Calendar API (see setup docs)
2. Add your first custom skills and quests
3. Start logging XP by completing tasks!
4. Customize the system to your needs

For detailed configuration of each plugin, refer to the system manual:
$VAULT_PATH/99-META/SYSTEM-MANUAL.md

Happy leveling! 🎮✨
"
}

# Main execution

main() {
log_info "Starting Solo Leveling Life OS installation..."

    check_system
    install_system_dependencies
    install_python_dependencies
    create_vault_structure
    setup_obsidian_config
    setup_taskwarrior
    setup_khal
    install_automation_scripts
    setup_automation
    create_initial_content
    create_css_styling
    create_templates
    finalize_setup
    show_completion_message

}

# Run main function

main "$@"

````

---

# 📚 MODULE 08: PLUGIN-SPECIFIC CONFIGURATION GUIDE

## 🔧 DETAILED PLUGIN CONFIGURATIONS

### ┌─ ADVANCED DATAVIEW CONFIG ─┐
```javascript
// File: 99-META/SCRIPTS/dataview-custom-functions.js
// Advanced Dataview functions for XP calculation

// Calculate total XP from daily logs
function calculateTotalXP(pages) {
    let totalXP = 0;
    for (let page of pages) {
        if (page.file && page.file.tasks) {
            for (let task of page.file.tasks) {
                if (task.completed && task.text.includes('[+')) {
                    const xpMatch = task.text.match(/\[\+(\d+)\s*XP\]/);
                    if (xpMatch) {
                        totalXP += parseInt(xpMatch[1]);
                    }
                }
            }
        }
    }
    return totalXP;
}

// Calculate skill level from XP
function calculateSkillLevel(xp) {
    return Math.floor(xp / 150) + 1;
}

// Generate XP progress bar
function generateXPBar(currentXP, maxXP) {
    const percentage = Math.min((currentXP / maxXP) * 100, 100);
    const filledBars = Math.floor(percentage / 5);
    const emptyBars = 20 - filledBars;

    return "█".repeat(filledBars) + "░".repeat(emptyBars);
}

// Export functions for use in Dataview queries
window.slCustomFunctions = {
    calculateTotalXP,
    calculateSkillLevel,
    generateXPBar
};
````

### ┌─ TEMPLATER ADVANCED CONFIG ─┐

```javascript
// File: 99-META/SCRIPTS/templater-functions.js
// Custom Templater functions

function generateQuestID() {
  return "QUEST-" + Date.now().toString(36).toUpperCase();
}

function calculateQuestXP(difficulty, estimatedHours) {
  const difficultyMultiplier = {
    easy: 1,
    medium: 2,
    hard: 4,
    extreme: 8,
  };

  return Math.round(estimatedHours * difficultyMultiplier[difficulty] * 5);
}

function formatClassSchedule(startDate, endDate, classTimes) {
  const dates = [];
  let currentDate = new Date(startDate);
  const endDateObj = new Date(endDate);

  while (currentDate <= endDateObj) {
    // Only add dates that match class schedule (e.g., Mon, Wed, Fri)
    if ([1, 3, 5].includes(currentDate.getDay())) {
      // Mon, Wed, Fri
      dates.push(currentDate.toISOString().split("T")[0]);
    }
    currentDate.setDate(currentDate.getDate() + 1);
  }

  return dates;
}

function generateTaskwarriorCommand(title, project, priority, due, xp, skill) {
  return `task add "${title}" project:${project} priority:${priority} due:${due} xp:${xp} skill:${skill}`;
}

// Export for Templater
module.exports = {
  generateQuestID,
  calculateQuestXP,
  formatClassSchedule,
  generateTaskwarriorCommand,
};
```

### ┌─ TASKS PLUGIN CONFIG ─┐

```yaml
# File: .obsidian/plugins/obsidian-tasks-plugin/data.json
{
  "globalFilter": "#task",
  "removeGlobalFilter": false,
  "setCreatedDate": true,
  "setDoneDate": true,
  "useFilenameAsScheduledDate": false,
  "autoSuggestInEditor": true,
  "debugSettings": false,
  "features":
    { "prioritySymbols": { "High": "🔺", "Medium": "🔶", "Low": "🔽" } },
}
```

### ┌─ STYLE SETTINGS CONFIG ─┐

```json
{
  "solo-leveling-theme@@dark-accent": "#00ff00",
  "solo-leveling-theme@@dark-background": "#0a0a0a",
  "solo-leveling-theme@@dark-surface": "#1a1a2e",
  "solo-leveling-theme@@matrix-green": "#00ff00",
  "solo-leveling-theme@@warning-yellow": "#ffff00",
  "solo-leveling-theme@@danger-red": "#ff0000",
  "solo-leveling-theme@@info-blue": "#0080ff",
  "solo-leveling-theme@@font-family": "Courier New",
  "solo-leveling-theme@@font-size": "14px",
  "solo-leveling-theme@@enable-animations": true,
  "solo-leveling-theme@@hud-transparency": "0.9"
}
```

---

# 🔄 MODULE 09: BIDIRECTIONAL SYNC SYSTEM

## 📊 Complete Sync Architecture

```python
#!/usr/bin/env python3
# File: ~/.local/bin/complete-sync-manager.py
# Purpose: Master sync controller for all systems

import asyncio
import json
import subprocess
import yaml
from pathlib import Path
from datetime import datetime
import logging

class CompleteSyncManager:
    def __init__(self):
        self.vault_path = Path.home() / "obsidian-vault-solo-leveling"
        self.config = self.load_config()
        self.setup_logging()

    def load_config(self):
        """Load sync configuration"""
        config_file = Path.home() / ".config" / "solo-leveling" / "sync-config.yaml"

        if config_file.exists():
            with open(config_file, 'r') as f:
                return yaml.safe_load(f)

        # Default configuration
        return {
            'sync_interval': 1800,  # 30 minutes
            'taskwarrior': {'enabled': True},
            'khal': {'enabled': True},
            'google_calendar': {'enabled': False},  # Requires API setup
            'obsidian': {'enabled': True}
        }

    def setup_logging(self):
        """Setup logging for sync operations"""
        log_file = self.vault_path / "99-META" / "AUTOMATION" / "sync.log"
        log_file.parent.mkdir(exist_ok=True)

        logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s - %(levelname)s - %(message)s',
            handlers=[
                logging.FileHandler(log_file),
                logging.StreamHandler()
            ]
        )
        self.logger = logging.getLogger(__name__)

    async def sync_obsidian_to_taskwarrior(self):
        """Sync Obsidian quests to Taskwarrior tasks"""
        self.logger.info("🔄 Syncing Obsidian → Taskwarrior")

        quests_path = self.vault_path / "02-QUESTS"
        synced_count = 0

        for quest_file in quests_path.glob("*.md"):
            try:
                with open(quest_file, 'r') as f:
                    content = f.read()

                # Parse frontmatter
                if content.startswith('---'):
                    _, frontmatter, body = content.split('---', 2)
                    metadata = yaml.safe_load(frontmatter)

                    if metadata.get('status') in ['active', 'planning']:
                        # Check if task already exists in Taskwarrior
                        existing_check = subprocess.run([
                            'task', 'export', f"description.contains:{metadata['quest_name']}"
                        ], capture_output=True, text=True)

                        if not existing_check.stdout.strip():
                            # Create new task
                            cmd = [
                                'task', 'add', metadata['quest_name'],
                                f"project:quests",
                                f"priority:{metadata.get('priority', 'M')[0].upper()}",
                                f"xp:{metadata.get('xp_reward', 10)}",
                                f"quest_type:{metadata.get('quest_type', 'sub')}",
                                f"difficulty:{metadata.get('difficulty', 'medium')}"
                            ]

                            if metadata.get('deadline'):
                                cmd.extend([f"due:{metadata['deadline']}"])

                            result = subprocess.run(cmd, capture_output=True, text=True)
                            if result.returncode == 0:
                                synced_count += 1
                                self.logger.info(f"✅ Created task: {metadata['quest_name']}")
                            else:
                                self.logger.error(f"❌ Failed to create task: {result.stderr}")

            except Exception as e:
                self.logger.error(f"❌ Error processing {quest_file}: {e}")

        self.logger.info(f"📊 Synced {synced_count} quests to Taskwarrior")

    async def sync_taskwarrior_to_obsidian(self):
        """Sync completed Taskwarrior tasks back to Obsidian"""
        self.logger.info("🔄 Syncing Taskwarrior → Obsidian")

        # Get completed tasks from last 24 hours
        cmd = ['task', 'export', 'status:completed', 'end.after:yesterday']
        result = subprocess.run(cmd, capture_output=True, text=True)

        if result.returncode == 0 and result.stdout.strip():
            tasks = json.loads(result.stdout)
            today_file = self.vault_path / "03-DAILY" / f"{datetime.now().strftime('%Y-%m-%d')}.md"

            # Create today's file if it doesn't exist
            if not today_file.exists():
                self.create_daily_file(today_file)

            # Add completed tasks to daily log
            completed_tasks = []
            total_xp = 0

            for task in tasks:
                xp_reward = int(task.get('xp', 1))
                skill = task.get('skill', 'general')
                end_time = datetime.fromisoformat(task['end']).strftime('%H:%M')

                task_line = f"- [x] {task['description']} [+{xp_reward} XP] #{skill} (Completed: {end_time})"
                completed_tasks.append(task_line)
                total_xp += xp_reward

            if completed_tasks:
                self.append_to_daily_file(today_file, completed_tasks, total_xp)
                self.logger.info(f"✅ Added {len(completed_tasks)} completed tasks (+{total_xp} XP)")

    async def sync_khal_calendar(self):
        """Sync calendar events between Khal and Obsidian"""
        self.logger.info("🔄 Syncing Calendar events")

        # Export upcoming course events from Obsidian to Khal
        courses_path = self.vault_path / "04-COURSES"

        for course_file in courses_path.glob("*.md"):
            try:
                with open(course_file, 'r') as f:
                    content = f.read()

                # Parse course schedule and create Khal events
                # This would extract dates/times from course tables
                self.extract_and_sync_course_events(content)

            except Exception as e:
                self.logger.error(f"❌ Calendar sync error: {e}")

    def create_daily_file(self, file_path):
        """Create daily file with template"""
        template_content = f"""---
date: {datetime.now().strftime('%Y-%m-%d')}
tags: [daily, auto-sync]
total_xp_today: 0daily_file(self, file_path, date):
        """Create daily note file"""
        content = f"""---
date: {date}
tags: [daily, auto-sync]
---

# {date}

## Scheduled Events (Khal Sync)

## XP Tracking
- xp_programming:: 0
- xp_fitness:: 0
- xp_study:: 0
- total_xp:: 0

## Completed Tasks
"""

        with open(file_path, 'w') as f:
            f.write(content)

    def update_daily_file(self, file_path, events):
        """Update daily file with events"""
        with open(file_path, 'r') as f:
            content = f.read()

        # Replace events section
        if "## Scheduled Events (Khal Sync)" in content:
            parts = content.split("## Scheduled Events (Khal Sync)")
            before = parts[0] + "## Scheduled Events (Khal Sync)\n"

            # Find next section
            after_parts = parts[1].split("##", 1)
            events_content = "\n".join(events) + "\n\n"
            after = "##" + after_parts[1] if len(after_parts) > 1 else ""

            new_content = before + events_content + after

            with open(file_path, 'w') as f:
                f.write(new_content)

if __name__ == "__main__":
    sync = ObsidianKhalSync()
    sync.sync_to_khal()
    sync.sync_from_khal()
    print("✅ Sync completed!")
```

---

# 🤖 MODULE 05: AUTOMATION SCRIPTS

## 📊 XP Auto-Calculator Enhanced

```python
#!/usr/bin/env python3
# File: ~/.local/bin/xp-auto-calculator.py
# Purpose: Comprehensive XP calculation and level management

import os
import re
import json
from pathlib import Path
from datetime import datetime, date
import yaml
import subprocess

class XPCalculator:
    def __init__(self):
        self.vault_path = Path.home() / "obsidian-vault-solo-leveling"
        self.daily_path = self.vault_path / "03-DAILY"
        self.skills_path = self.vault_path / "01-SKILLS"
        self.xp_log_path = self.vault_path / "00-SYSTEM" / "01-XP-Logger.md"
        self.dashboard_path = self.vault_path / "00-SYSTEM" / "00-Dashboard.md"

        # XP conversion rates
        self.xp_rates = {
            'programming': 100,  # 100 minutes = 1 XP
            'fitness': 100,      # 100 reps = 1 XP
            'study': 100,        # 100 minutes = 1 XP
            'reading': 100,      # 100 pages = 1 XP
            'projects': 100,     # 100 minutes = 1 XP
            'course': 30         # 1 class = 30 XP (3 hours)
        }

    def scan_completed_tasks(self):
        """Scan all daily logs for completed XP tasks"""
        total_xp = {}

        for daily_file in self.daily_path.glob("*.md"):
            with open(daily_file, 'r') as f:
                content = f.read()

            # Find completed XP tasks: [x] Task [+N XP] #skill
            xp_pattern = r'\[x\].*?\[\+(\d+)\s+XP\].*?#(\w+)'
            matches = re.findall(xp_pattern, content, re.IGNORECASE)

            for xp_str, skill in matches:
                xp_amount = int(xp_str)
                skill = skill.lower()

                if skill not in total_xp:
                    total_xp[skill] = 0
                total_xp[skill] += xp_amount

        return total_xp

    def calculate_level(self, xp):
        """Calculate level from XP (150 XP per level)"""
        return (xp // 150) + 1

    def xp_to_next_level(self, current_xp):
        """Calculate XP needed for next level"""
        current_level = self.calculate_level(current_xp)
        next_level_threshold = current_level * 150
        return next_level_threshold - current_xp

    def update_skill_files(self, xp_data):
        """Update individual skill files with current XP and levels"""
        for skill_name, xp_amount in xp_data.items():
            skill_file = self.skills_path / f"Skill-{skill_name.title()}.md"

            if skill_file.exists():
                # Update existing skill file
                with open(skill_file, 'r') as f:
                    content = f.read()

                # Update XP values using regex
                content = re.sub(r'current_xp:\s*\d+', f'current_xp: {xp_amount}', content)

                current_level = self.calculate_level(xp_amount)
                content = re.sub(r'level:\s*\d+', f'level: {current_level}', content)

                next_level_xp = current_level * 150
                content = re.sub(r'next_level_xp:\s*\d+', f'next_level_xp: {next_level_xp}', content)

                with open(skill_file, 'w') as f:
                    f.write(content)
            else:
                # Create new skill file
                self.create_skill_file(skill_name, xp_amount)

```
