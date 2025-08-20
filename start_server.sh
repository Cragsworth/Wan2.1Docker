#!/bin/bash

echo "=== Starting Gradio server ==="
echo "Environment: $VIRTUAL_ENV"
echo "Python version: $(python --version)"
echo "CUDA path: $PATH"
echo "LD_LIBRARY_PATH: $LD_LIBRARY_PATH"
source /home/ubuntu/workspace/venv/bin/activate
python /home/ubuntu/workspace/Wan2.1/gradio/t2v_14B_singleGPU.py --ckpt_dir /home/ubuntu/workspace/Wan2.1/Wan2.1-T2V-14B
