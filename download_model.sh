#!/bin/bash

# Check if virtual environment exists
if [ ! -f "/home/ubuntu/workspace/venv/bin/activate" ]; then
    echo "Error: Virtual environment not found at /home/ubuntu/workspace/venv"
    echo "Please run setup_environment.sh first"
    exit 1
fi

# Activate virtual environment and verify it's working
source /home/ubuntu/workspace/venv/bin/activate
if [ $? -ne 0 ]; then
    echo "Error: Failed to activate virtual environment"
    exit 1
fi

# Verify we're in the virtual environment
if [ -z "$VIRTUAL_ENV" ]; then
    echo "Error: Virtual environment not activated properly"
    exit 1
fi

# Ensure huggingface-cli is in PATH
export PATH="/home/ubuntu/.local/bin:$PATH"

# Check if huggingface-cli is available
if ! command -v huggingface-cli &> /dev/null; then
    echo "Error: huggingface-cli not found. Installing..."
    pip install --upgrade "huggingface_hub[cli]"
fi

# Create model directory if it doesn't exist
mkdir -p /home/ubuntu/workspace/Wan2.1/Wan2.1-T2V-14B

echo "=== Starting model weights download ==="
echo "Environment: $VIRTUAL_ENV"
echo "Python version: $(python --version)"
echo "Download destination: /home/ubuntu/workspace/Wan2.1/Wan2.1-T2V-14B"

# Download the Hugging Face model weights
huggingface-cli download Wan-AI/Wan2.1-T2V-14B --local-dir /home/ubuntu/workspace/Wan2.1/Wan2.1-T2V-14B

# Verify the download
if [ $? -eq 0 ]; then
    echo "=== Model weights downloaded successfully ==="
    # Verify the model files exist
    if [ ! -d "/home/ubuntu/workspace/Wan2.1/Wan2.1-T2V-14B" ] || [ -z "$(ls -A /home/ubuntu/workspace/Wan2.1/Wan2.1-T2V-14B)" ]; then
        echo "Error: Model directory is empty after download"
        exit 1
    fi
    echo "Model files are present in the target directory"
else
    echo "=== Failed to download model weights ==="
    echo "Please check your internet connection and try again"
    exit 1
fi
