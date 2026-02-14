#!/usr/bin/env python3
"""
Test Pat's voice message for car search requirements
Uses multiple fallback methods to extract speech content
"""

import os
import json

def analyze_audio_file(audio_path):
    """Basic audio file analysis"""
    if not os.path.exists(audio_path):
        return {"error": "Audio file not found"}
    
    # Get file stats
    stat = os.stat(audio_path)
    
    # Try to run file command to get format info
    import subprocess
    try:
        file_info = subprocess.check_output(['file', audio_path]).decode().strip()
    except:
        file_info = "File info unavailable"
    
    return {
        "file_path": audio_path,
        "size_bytes": stat.st_size,
        "file_info": file_info,
        "status": "ready_for_transcription",
        "note": "Audio file ready - needs API keys for transcription"
    }

def create_car_search_template(transcript_placeholder="[Voice message received - pending transcription]"):
    """Create car search project template with voice input"""
    return {
        "project": "Car Search 2026",
        "voice_input": transcript_placeholder,
        "requirements": {
            "vehicle_type": "[Extract from voice]",
            "budget_range": "[Extract from voice]",
            "timeline": "[Extract from voice]", 
            "preferred_brands": "[Extract from voice]",
            "must_haves": "[Extract from voice]",
            "nice_to_haves": "[Extract from voice]",
            "geographic_area": "[Extract from voice]"
        },
        "next_steps": [
            "Set up voice transcription (Google + ElevenLabs)",
            "Extract structured requirements from voice message",
            "Build web scraping for dealer inventories",
            "Create automated price monitoring",
            "Set up dealer communication templates"
        ]
    }

if __name__ == "__main__":
    # Analyze Pat's voice message
    audio_path = "/home/pat/.openclaw/media/inbound/file_2---2413d1d7-fa13-4d48-bc23-e7f5e74eb35d.ogg"
    
    print("🎤 Analyzing Pat's Car Search Voice Message")
    print("=" * 50)
    
    analysis = analyze_audio_file(audio_path)
    print(json.dumps(analysis, indent=2))
    
    print("\n🚗 Car Search Project Template:")
    print("=" * 50)
    template = create_car_search_template()
    print(json.dumps(template, indent=2))
    
    print(f"\n📊 Audio Stats: {analysis['size_bytes']:,} bytes ({analysis['size_bytes']/1024:.1f} KB)")
    print("📋 Ready for transcription once API keys are configured")
    print("\n🔑 Next: Get Google Cloud + ElevenLabs API keys to activate voice workflow")