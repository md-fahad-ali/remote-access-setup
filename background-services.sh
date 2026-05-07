#!/bin/bash
# Background Services for Fahad's Sleep Mode

# Function to monitor and restart OpenClaw if needed
    while true; do
        if ! pgrep -f "openclaw" > /dev/null; then
            echo "🔄 Restarting OpenClaw..."
            openclaw gateway &
            sleep 5
        fi
        sleep 30  # Check every 30 seconds
    done
}

# Function to keep Gemini CLI responsive
keep_gemini_ready() {
    # Pre-create essential directories
    mkdir -p ~/.gemini/extensions/*/attachments/
    
    # Clear Gemini cache occasionally
    rm -rf ~/.gemini/cache/* 2>/dev/null
    
    sleep 60  # Run maintenance every minute
}

echo "🚀 Starting background services for sleep mode optimization..."

# Start both monitors in background
keep_gemini_ready &

echo "✅ Background services started - Ready for 24/7 productivity"