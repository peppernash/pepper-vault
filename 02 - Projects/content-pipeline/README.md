# Content Pipeline - Yale Appliance Automation

**Purpose:** Automated content production with dependency-ordered agents.

## Directory Structure

```
content-pipeline/
├── README.md (this file)
├── week-YYYY-WW.md          # Marlo's weekly plans
├── social/
│   ├── hooks-performance.md  # Track what converts
│   └── lessons.md            # Social-specific lessons
└── archive/                  # Completed weeks
```

## Agent Flow (Dependency Ordered)

### Monday 8 AM - Marlo (Content Strategy)
- **Reads:** topic-inventory, product-insights, ICPs, templates
- **Writes:** `week-YYYY-WW.md` (weekly content plan)
- **Output:** 2-4 content pieces scheduled with templates + ICPs

### Tuesday-Friday 9 AM - Tuck (Research)
- **Reads:** Marlo's weekly plan, buying-guides/, reliability-data/
- **Writes:** Research briefs in `Yale-Content-Hub/deliverables/[category]/`
- **Output:** Structured brief with verified data, gaps classified

### Tuesday-Friday 11 AM - Finch (Writer)
- **Reads:** Tuck's research brief, brand voice, templates
- **Writes:** `.docx` deliverables in same directory
- **Output:** Draft in Steve's voice, template-compliant

### Tuesday-Friday 2 PM - Sable (Editor & Fact-Checker)
- **Reads:** Finch's `.docx` (actual file, not summary), vault data
- **Writes:** Review results in production log
- **Output:** Approved/flagged + specific issues to fix

### Wednesday + Friday 3 PM - Roux (Social & Short-Form)
- **Reads:** Published content, social templates, performance data
- **Writes:** Social packages in `social/` directory
- **Output:** TikTok, Shorts, IG, LinkedIn, Pinterest content packages

## File Coordination Rules

**One writer, many readers.**

| Agent  | Writes To                               | Reads From                              |
|--------|----------------------------------------|----------------------------------------|
| Marlo  | week-YYYY-WW.md                        | topic-inventory, ICPs, templates       |
| Tuck   | Yale-Content-Hub/deliverables/         | Marlo's plan, buying-guides/, data     |
| Finch  | Yale-Content-Hub/deliverables/         | Tuck's brief, voice, templates         |
| Sable  | production logs                        | Finch's .docx, data                    |
| Roux   | social/ packages                       | Published content, templates           |

## Verification Checkpoints

- **Marlo:** Plan is sensible, approved with minimal changes
- **Tuck:** Research matches Claude Code quality, no fabricated data
- **Finch:** Passes Steve Test >60% on first try
- **Sable:** Catches 100% of stat errors
- **Roux:** Social packages maintain voice while being platform-optimized

## Status Tracking

Weekly plans track:
- Content piece status (planned → researched → drafted → reviewed → published)
- Blocking issues (missing data, template gaps, review failures)
- Timeline adjustments (if dependencies break)

---

**Last Updated:** 2026-02-14 (Phase 0 setup)
