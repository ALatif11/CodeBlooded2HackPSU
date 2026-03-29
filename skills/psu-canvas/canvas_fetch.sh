#!/bin/bash
# canvas_fetch.sh - Fetch data from Canvas LMS API
# Usage: ./canvas_fetch.sh <endpoint> <api_token>
#
# Examples:
#   ./canvas_fetch.sh "users/self/upcoming_events" "your_token"
#   ./canvas_fetch.sh "courses?enrollment_state=active" "your_token"
#   ./canvas_fetch.sh "courses/12345/assignments?order_by=due_at" "your_token"

CANVAS_URL="https://psu.instructure.com/api/v1"
ENDPOINT="$1"
TOKEN="$2"

if [ -z "$ENDPOINT" ] || [ -z "$TOKEN" ]; then
    echo "Usage: ./canvas_fetch.sh <endpoint> <api_token>"
    echo "Example: ./canvas_fetch.sh 'users/self/upcoming_events' 'your_token_here'"
    exit 1
fi

curl -s -H "Authorization: Bearer $TOKEN" "$CANVAS_URL/$ENDPOINT"
