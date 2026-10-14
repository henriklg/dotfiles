#!/usr/bin/env bash

input=$(cat)
model_id=$(echo "$input" | jq -r '.model.id // ""')
cwd=$(echo "$input" | jq -r '.cwd // ""')
context=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)

case "$model_id" in
  "$ANTHROPIC_DEFAULT_OPUS_MODEL")  model="Opus" ;;
  "$ANTHROPIC_DEFAULT_SONNET_MODEL") model="Sonnet" ;;
  "$ANTHROPIC_DEFAULT_HAIKU_MODEL") model="Haiku" ;;
  *opus*)   model="Opus" ;;
  *sonnet*) model="Sonnet" ;;
  *haiku*)  model="Haiku" ;;
  *)        model="$model_id" ;;
esac

PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)

# Build progress bar: printf -v creates a run of spaces, then
# ${var// /▓} replaces each space with a block character
BAR_WIDTH=10
FILLED=$((PCT * BAR_WIDTH / 100))
EMPTY=$((BAR_WIDTH - FILLED))
BAR=""
[ "$FILLED" -gt 0 ] && printf -v FILL "%${FILLED}s" && BAR="${FILL// /▓}"
[ "$EMPTY" -gt 0 ] && printf -v PAD "%${EMPTY}s" && BAR="${BAR}${PAD// /░}"

cwd_short=$(echo "$cwd" | sed "s|$HOME|~|")
echo "$model | $BAR $PCT%  | 🗂️  $cwd_short"