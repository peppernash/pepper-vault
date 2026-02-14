# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

## What Goes Here

Things like:

- Camera names and locations
- SSH hosts and aliases
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Anything environment-specific

## Examples

```markdown
### Cameras

- living-room → Main area, 180° wide angle
- front-door → Entrance, motion-triggered

### SSH

- home-server → 192.168.1.100, user: admin

### TTS

- Preferred voice: "Nova" (warm, slightly British)
- Default speaker: Kitchen HomePod
```

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

---

Add whatever helps you do your job. This is your cheat sheet.

## Weather Commands

### Quick Weather
```bash
# Current conditions (compact)
curl -s "wttr.in/Boston?format=3"

# Detailed current conditions  
curl -s "wttr.in/Boston?format=%l:+%c+%t+%h+%w+%m"

# Full 3-day forecast
curl -s "wttr.in/Boston?T"
```

### Locations
- **Boston** - Default local weather
- **BOS** - Logan Airport conditions
- **NYC** - New York City
- **London** - International example

### Format Options
- `%c` condition · `%t` temp · `%h` humidity · `%w` wind · `%l` location · `%m` moon
- `?m` metric · `?u` US units · `?T` no terminal colors · `?0` current only · `?1` today only
