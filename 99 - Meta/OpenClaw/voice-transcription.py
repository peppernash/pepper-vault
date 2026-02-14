#!/usr/bin/env python3
"""
Voice Transcription for Car Search Assistant
Uses cloud APIs to avoid local package installation requirements
"""

import requests
import json
import os

def transcribe_with_google(audio_file_path, api_key=None):
    """
    Use Google Cloud Speech-to-Text API
    Requires GOOGLE_CLOUD_API_KEY environment variable
    """
    if not api_key:
        api_key = os.getenv('GOOGLE_CLOUD_API_KEY')
    
    if not api_key:
        return {"error": "Google Cloud API key required"}
    
    # Convert audio to base64
    import base64
    with open(audio_file_path, 'rb') as f:
        audio_content = base64.b64encode(f.read()).decode('utf-8')
    
    # Google Speech-to-Text API call
    url = f"https://speech.googleapis.com/v1/speech:recognize?key={api_key}"
    
    payload = {
        "config": {
            "encoding": "OGG_OPUS",
            "sampleRateHertz": 48000,
            "languageCode": "en-US",
            "model": "latest_short"
        },
        "audio": {
            "content": audio_content
        }
    }
    
    try:
        response = requests.post(url, json=payload)
        result = response.json()
        
        if 'results' in result and result['results']:
            transcript = result['results'][0]['alternatives'][0]['transcript']
            confidence = result['results'][0]['alternatives'][0]['confidence']
            return {
                "transcript": transcript,
                "confidence": confidence,
                "service": "google"
            }
        else:
            return {"error": "No transcription results", "raw": result}
            
    except Exception as e:
        return {"error": str(e)}

def generate_voice_response(text, voice="Rachel", api_key=None):
    """
    Generate natural voice response using ElevenLabs API
    Requires ELEVENLABS_API_KEY environment variable
    """
    if not api_key:
        api_key = os.getenv('ELEVENLABS_API_KEY')
    
    if not api_key:
        return {"error": "ElevenLabs API key required"}
    
    # ElevenLabs voice IDs (popular voices)
    voices = {
        "Rachel": "21m00Tcm4TlvDq8ikWAM",  # Young American female
        "Adam": "pNInz6obpgDQGcFmaJgB",    # Middle-aged American male  
        "Bella": "EXAVITQu4vr4xnSDxMaL",   # Young American female
        "Antoni": "ErXwobaYiN019PkySvjV",  # Young American male
        "Elli": "MF3mGyEYCl7XYWbV9V6O",    # Young American female
        "Josh": "TxGEqnHWrfWFTfGW9XjX",    # Young American male
        "Arnold": "VR6AewLTigWG4xSOukaG",  # Middle-aged American male
        "Domi": "AZnzlk1XvdvUeBnXmlld",    # Young American female
        "Dave": "CYw3kZ02Hs0563khs1Fj"     # Young British male
    }
    
    voice_id = voices.get(voice, voices["Rachel"])
    url = f"https://api.elevenlabs.io/v1/text-to-speech/{voice_id}"
    
    headers = {
        "Accept": "audio/mpeg",
        "Content-Type": "application/json",
        "xi-api-key": api_key
    }
    
    payload = {
        "text": text,
        "model_id": "eleven_monolingual_v1",
        "voice_settings": {
            "stability": 0.5,
            "similarity_boost": 0.5
        }
    }
    
    try:
        response = requests.post(url, json=payload, headers=headers)
        
        if response.status_code == 200:
            # Save audio file
            output_path = f"/tmp/elevenlabs_response_{os.getpid()}.mp3"
            with open(output_path, "wb") as f:
                f.write(response.content)
            return {
                "audio_file": output_path,
                "voice": voice,
                "service": "elevenlabs"
            }
        else:
            return {"error": f"ElevenLabs API error: {response.status_code}", "details": response.text}
            
    except Exception as e:
        return {"error": str(e)}

if __name__ == "__main__":
    import sys
    
    if len(sys.argv) < 2:
        print("Usage: python3 voice-transcription.py <audio_file> [action]")
        print("Actions: transcribe, respond <text>, full_workflow")
        sys.exit(1)
    
    audio_file = sys.argv[1]
    action = sys.argv[2] if len(sys.argv) > 2 else "transcribe"
    
    if action == "transcribe":
        result = transcribe_with_google(audio_file)
        print(json.dumps(result, indent=2))
    
    elif action.startswith("respond"):
        text = " ".join(sys.argv[2:])
        result = generate_voice_response(text)
        print(json.dumps(result, indent=2))
    
    elif action == "full_workflow":
        # Transcribe input
        transcript_result = transcribe_with_google(audio_file)
        if "transcript" in transcript_result:
            print(f"Transcribed: {transcript_result['transcript']}")
            
            # Generate response (placeholder - will be replaced with car search logic)
            response_text = f"I heard you say: {transcript_result['transcript']}. Let me process your car search requirements."
            
            voice_result = generate_voice_response(response_text)
            if "audio_file" in voice_result:
                print(f"Generated voice response: {voice_result['audio_file']}")
            else:
                print(f"Voice generation failed: {voice_result}")
        else:
            print(f"Transcription failed: {transcript_result}")