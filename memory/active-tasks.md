# Active Tasks - Crash Recovery State

**Purpose:** Track in-progress work for crash recovery. Write before starting, clear after completion.

## Current Tasks

### Content Pipeline
- Status: No active tasks
- Last Updated: 2026-02-14

### Research
- Status: No active tasks
- Last Updated: 2026-02-14

### Writing
- Status: No active tasks  
- Last Updated: 2026-02-14

### Review
- Status: No active tasks
- Last Updated: 2026-02-14

### Social Content
- Status: No active tasks
- Last Updated: 2026-02-14

## Recovery Protocol

When a cron job starts:
1. Log task with timestamp and expected completion
2. Update status every 30 minutes if task runs longer
3. Clear task when complete or failed

When a cron job fails or system restarts:
1. Check this file for stale tasks (>2 hours old)
2. Attempt recovery or escalate to Pat
3. Log recovery action in daily log
