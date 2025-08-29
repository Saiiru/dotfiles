[hypr

- conf
    

- effects/wallpaper
    

- scripts
    

- shaders
    

- colors.conf
    

- hypridle.conf
    

- hyprland.conf
    

- hyprlock.conf
    

hyprpaper.conf](<You are a Linux customization expert focused on Hyprland, Rofi, and modular Wayland configuration.

### OBJECTIVE

I want you to:

1. Refactor my entire **Hyprland config structure**, removing any `/batman-system/` path and **all `batman-` themed references**.
2. Maintain a **modular folder structure**, as shown below, separating concerns across scripts, shaders, themes, and configs.
3. **Fix all issues in my `rofi/config.rasi` file**, including:
   - Invalid property values (e.g., using `@batman-margin` without declaration)
   - Syntax parser errors (e.g., unexpected numbers or variables)
   - Theme properties commented out because they were broken
4. Create a **generic dark cyberpunk-style theme**, but **no more Batman references** (pure technical, HUD-like aesthetic).
5. Show where each file goes — including `rofi/` which is *not* under `~/.config/hypr`.

---

## ✅ FINAL STRUCTURE EXPECTATION

**Rofi (outside of Hyprland):**

~/.config/rofi/
├── config.rasi # Main config (validated + corrected)
├── theme.rasi # Custom dark cyber-HUD theme (no Batman vars)


**Hyprland:**

~/.config/hypr/
├── conf/
│ ├── hyprland.conf # Main config
│ ├── colors.conf # Shared color palette
│ ├── hyprpaper.conf # Wallpaper manager
│ ├── hyprlock.conf # Lock screen config
│ ├── hypridle.conf # Idle config (for lock/suspend)
├── effects/
│ └── wallpaper/ # Shader-based wallpapers
├── scripts/
│ ├── startup.sh # Login automation
│ ├── lock.sh # Calls hyprlock
│ ├── idle.sh # Idle state management
│ └── theme-loader.sh # Exports theme/colors to Rofi, future bars
├── shaders/
│ └── bloom.glsl # Optional: custom fragment shader


---

## 🔧 Rofi: Known Errors to Fix

- Commented-out or broken properties like:
```rasi
// margin: @batman-margin 0px 0px 0px;

Must be replaced with valid numeric or @theme variables declared at the top.

    Invalid hover properties:

// border: 1px solid @batman-glow;

→ Replace @batman-glow with declared color or remove if unsupported.

    General parser crash:

Parser error: syntax error, unexpected Integer number, expecting "property close (';')"

→ Usually caused by unquoted or invalid property syntax or variable resolution failures.
💡 Behavior Expectations

    rofi -show drun must work with icons, kitty terminal, no crashes

    hyprctl reload should report no config errors

    Hyprland sessions start cleanly with wallpapers and effects applied

    Each file should be modular, commented, and readable

📦 DELIVERABLES

    Valid .rasi pair:

        config.rasi (core behavior + fonts, icons, keybinds)

        theme.rasi (visuals with corrected syntax)

    All Hyprland configs as per structure above

    Any referenced variables (colors, margins, etc.) must be declared in colors.conf or inline

    Minimalist, serious, HUD-style visuals. No gimmicks, no Batman references.

⚠️ NOTE

    You do not need to implement waybar, ags, or hyprpanel yet.

    Just ensure theme-loader.sh and structure allow that to be added easily later.


---

**🧠 Ready for Claude.** This version respects your Rofi location, corrects `.rasi`, and enforces a clean modular layout.

When you receive Claude’s response, drop the full config set here and I’ll validate, polish, or connect any missing wires.

Awaiting next transmission, Command>)