# BIOMECH::SIGHT

Minority Report-style augmented reality segmentation app. Runs entirely in mobile browser.

- Activates camera and uses MediaPipe DeepLabV3 to segment objects, people, animals, vehicles in real-time
- Trippy biomechanical overlay with glowing segment edges and pulsing fills
- HR Giger-inspired dark aesthetic with scanlines, vignette, and scan beam
- **Pause** to freeze the frame, **tap any object** to enhance and get analysis data
- **Resume** to continue scanning
- Flip camera button for front/rear

## Usage

Serve `index.html` over HTTPS (required for camera access) and open on mobile.

```
npx serve .
```
