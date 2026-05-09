set -e

pip uninstall -y torch torchvision torchaudio executorch 2>/dev/null || true

pip install torch torchvision --index-url https://download.pytorch.org/whl/cpu
pip install executorch open_clip_torch