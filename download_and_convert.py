import torch
import open_clip
from executorch.exir import to_edge
import os

### This script will download the unified MobileClip S1 model, splice into separate text - image encoders, and place it in the correct directory.
### You could also modify this script to install S2 => S4(openclip) for better zero shot classification, although you'll have to download the correct tokenizer.json file for that specific model 
### Make sure you run install.sh first!!

OUTPUT_DIR = "assets/models"

def main():
    os.makedirs(OUTPUT_DIR, exist_ok=True)

    # 1. Load the OpenCLIP model pre-trained by Apple
    model_name = "MobileCLIP-S1"
    pretrained_tag = "datacompdr"
    print("Loading MobileCLIP-S1 model...")
    model, _, preprocess = open_clip.create_model_and_transforms(
        model_name,
        pretrained=pretrained_tag
    )
    model.eval()

    # 2. Separate into Image and Text encoders
    class ImageEncoder(torch.nn.Module):
        def __init__(self, clip_model):
            super().__init__()
            self.model = clip_model
        def forward(self, image):
            return self.model.encode_image(image)

    class TextEncoder(torch.nn.Module):
        def __init__(self, clip_model):
            super().__init__()
            self.model = clip_model
        def forward(self, text):
            return self.model.encode_text(text)

    image_encoder = ImageEncoder(model).eval()
    text_encoder = TextEncoder(model).eval()

    # 3. Create dummy inputs
    dummy_image = torch.randn(1, 3, 256, 256)
    dummy_text = open_clip.tokenize(["a photo of a cat"]).to(torch.int32)

    # 4. Export the Image Encoder -> model.pte
    image_out = os.path.join(OUTPUT_DIR, "model.pte")
    print("Exporting Image Encoder to ExecuTorch (.pte)...")
    with torch.no_grad():
        image_ep = torch.export.export(image_encoder, (dummy_image,))
        image_edge = to_edge(image_ep)
        with open(image_out, "wb") as f:
            f.write(image_edge.to_executorch().buffer)
    print(f" -> Saved '{image_out}'")

    # 5. Export the Text Encoder -> text.pte
    text_out = os.path.join(OUTPUT_DIR, "text.pte")
    print("Exporting Text Encoder to ExecuTorch (.pte)...")
    with torch.no_grad():
        text_ep = torch.export.export(text_encoder, (dummy_text,))
        text_edge = to_edge(text_ep)
        with open(text_out, "wb") as f:
            f.write(text_edge.to_executorch().buffer)
    print(f" -> Saved '{text_out}'")

    print("Done!")

if __name__ == "__main__":
    main()