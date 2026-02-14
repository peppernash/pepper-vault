#!/usr/bin/env python3
"""
Local Whisper transcription for Car Search Assistant
Complete offline voice processing - no cloud APIs needed
"""

import sys
import os
import json

# Add the whisper environment to path
WHISPER_ENV = "/home/pat/.local/whisper-env"
sys.path.insert(0, f"{WHISPER_ENV}/lib/python3.13/site-packages")

def transcribe_audio_local(audio_file_path, model_size="base"):
    """
    Transcribe audio using local Whisper installation
    Models: tiny, base, small, medium, large-v3 (larger = more accurate)
    """
    try:
        import whisper
        
        print(f"🎤 Loading Whisper model: {model_size}")
        model = whisper.load_model(model_size)
        
        print(f"📁 Transcribing: {os.path.basename(audio_file_path)}")
        result = model.transcribe(audio_file_path)
        
        return {
            "transcript": result["text"].strip(),
            "language": result["language"],
            "segments": result.get("segments", []),
            "model": model_size,
            "service": "whisper_local",
            "confidence": "high" if model_size in ["large", "large-v3"] else "medium"
        }
        
    except ImportError as e:
        return {
            "error": "Whisper not installed",
            "details": str(e),
            "fix": "Wait for installation to complete"
        }
    except Exception as e:
        return {
            "error": "Transcription failed", 
            "details": str(e)
        }

def process_car_search_voice(audio_file_path):
    """
    Process Pat's car search voice message with local Whisper
    """
    
    print("🚗 Car Search Voice Processing - Local Whisper")
    print("=" * 60)
    
    # Check if audio file exists
    if not os.path.exists(audio_file_path):
        return {"error": f"Audio file not found: {audio_file_path}"}
    
    # Get file info
    stat = os.stat(audio_file_path)
    print(f"📁 File: {os.path.basename(audio_file_path)}")
    print(f"📊 Size: {stat.st_size:,} bytes ({stat.st_size/1024:.1f} KB)")
    
    # Transcribe with base model (good balance of speed/accuracy)
    result = transcribe_audio_local(audio_file_path, model_size="base")
    
    if "transcript" in result:
        transcript = result["transcript"]
        
        print(f"\n🎯 Transcription Result:")
        print(f"📝 Text: {transcript}")
        print(f"🌍 Language: {result['language']}")
        print(f"🔧 Model: {result['model']}")
        print(f"✅ Confidence: {result['confidence']}")
        
        # Parse car requirements from transcript
        requirements = parse_car_requirements(transcript)
        
        print(f"\n🚗 Extracted Requirements:")
        for key, value in requirements.items():
            if value and value != "not specified":
                print(f"   • {key.replace('_', ' ').title()}: {value}")
        
        return {
            "success": True,
            "transcript": transcript,
            "requirements": requirements,
            "audio_info": {
                "file": audio_file_path,
                "size_kb": stat.st_size / 1024
            }
        }
    else:
        print(f"\n❌ Transcription failed: {result.get('error', 'Unknown error')}")
        return result

def parse_car_requirements(transcript):
    """
    Extract structured car search requirements from transcript
    """
    text_lower = transcript.lower()
    
    # Vehicle type detection
    vehicle_types = {
        "suv": ["suv", "crossover", "sport utility", "utility vehicle"],
        "sedan": ["sedan", "four door", "4-door"],
        "truck": ["truck", "pickup", "f-150", "silverado", "tacoma", "ranger"],
        "coupe": ["coupe", "two door", "2-door", "sports car"],
        "hatchback": ["hatchback", "hatch"],
        "wagon": ["wagon", "estate"],
        "convertible": ["convertible", "rag top", "cabrio"],
        "minivan": ["minivan", "van", "sienna", "odyssey"]
    }
    
    detected_type = "not specified"
    for vtype, keywords in vehicle_types.items():
        if any(keyword in text_lower for keyword in keywords):
            detected_type = vtype
            break
    
    # Brand detection
    brands = [
        "toyota", "honda", "ford", "chevrolet", "chevy", "nissan",
        "bmw", "mercedes", "audi", "lexus", "acura", "infiniti", 
        "mazda", "subaru", "volkswagen", "vw", "hyundai", "kia",
        "jeep", "dodge", "ram", "gmc", "cadillac", "lincoln",
        "volvo", "jaguar", "land rover", "porsche", "tesla",
        "genesis", "alfa romeo", "maserati", "bentley"
    ]
    
    mentioned_brands = [brand for brand in brands if brand in text_lower]
    
    # Budget extraction (basic regex patterns)
    import re
    money_patterns = [
        r'\$(\d{1,3}(?:,\d{3})*)',
        r'(\d+)\s*(?:dollars?|per month|monthly|a month)'
    ]
    
    budget_amounts = []
    for pattern in money_patterns:
        matches = re.findall(pattern, text_lower)
        budget_amounts.extend(matches)
    
    # Feature extraction
    features = []
    feature_keywords = [
        "awd", "all wheel drive", "4wd", "four wheel drive",
        "leather", "heated seats", "sunroof", "panoramic roof", 
        "navigation", "nav", "backup camera", "rear camera",
        "blind spot", "adaptive cruise", "lane keeping",
        "automatic", "manual", "stick", "v6", "v8", 
        "hybrid", "electric", "towing", "third row",
        "captain chairs", "premium sound", "bluetooth"
    ]
    
    for feature in feature_keywords:
        if feature in text_lower:
            features.append(feature)
    
    return {
        "vehicle_type": detected_type,
        "mentioned_brands": mentioned_brands if mentioned_brands else ["not specified"],
        "budget_mentions": budget_amounts if budget_amounts else ["not specified"],
        "features": features if features else ["not specified"],
        "raw_transcript": transcript
    }

if __name__ == "__main__":
    # Test with Pat's voice message
    audio_file = "/home/pat/.openclaw/media/inbound/file_2---2413d1d7-fa13-4d48-bc23-e7f5e74eb35d.ogg"
    
    if len(sys.argv) > 1:
        audio_file = sys.argv[1]
    
    result = process_car_search_voice(audio_file)
    
    if result.get("success"):
        print(f"\n🎉 Voice processing complete!")
        print(f"💾 Full results available for car search automation")
    else:
        print(f"\n⏳ Waiting for Whisper installation to complete...")
        print(f"🔧 Run again once installation finishes")