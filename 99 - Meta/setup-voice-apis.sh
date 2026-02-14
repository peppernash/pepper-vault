#!/bin/bash
# Set up API keys for voice transcription workflow

echo "🎤 Setting up Premium Voice Workflow for Car Search Assistant"
echo ""

# Check if API keys are already set
if [ -n "$GOOGLE_CLOUD_API_KEY" ]; then
    echo "✅ Google Cloud API key: Set (${GOOGLE_CLOUD_API_KEY:0:8}...)"
else
    echo "❌ Google Cloud API key: Not set"
    echo "   Get one at: https://console.cloud.google.com/apis/credentials"
    echo "   Enable: Cloud Speech-to-Text API"
    echo ""
    echo "   Export with: export GOOGLE_CLOUD_API_KEY=\"your_key_here\""
fi

if [ -n "$ELEVENLABS_API_KEY" ]; then
    echo "✅ ElevenLabs API key: Set (${ELEVENLABS_API_KEY:0:8}...)"
else
    echo "❌ ElevenLabs API key: Not set"
    echo "   Get one at: https://elevenlabs.io/speech-synthesis"
    echo "   Sign up for $5/month plan for best quality"
    echo ""
    echo "   Export with: export ELEVENLABS_API_KEY=\"your_key_here\""
fi

echo ""
echo "💡 Quick Setup Commands:"
echo "   export GOOGLE_CLOUD_API_KEY=\"your_google_key\""
echo "   export ELEVENLABS_API_KEY=\"your_elevenlabs_key\""
echo ""
echo "🧪 Test transcription:"
echo "   python3 voice-transcription.py /path/to/audio.ogg transcribe"
echo ""
echo "🗣️ Test voice generation:"  
echo "   python3 voice-transcription.py dummy respond \"Hello, this is a test\""

# Test basic functionality
echo ""
echo "🔧 Testing Python environment..."
python3 -c "import requests, json, os; print('✅ Required modules available')" 2>/dev/null || echo "❌ Missing required Python modules"