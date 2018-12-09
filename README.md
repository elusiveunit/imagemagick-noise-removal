# Image noise removal with ImageMagick

- http://www.imagemagick.org/Usage/fourier/#noise_removal
- http://www.fmwconcepts.com/imagemagick/fourier_transforms/fourier.html#noise_removal

All credit to the original authors, this is just a reference for myself.

The example will be a scan of the cover image for [The Hunt for Gollum](https://www.fantasyflightgames.com/en/products/the-lord-of-the-rings-the-card-game/products/the-hunt-for-gollum/), an Adventure Pack for The Lord of the Rings: The Card Game.

![Original scan](/img.png?raw=true)

The scan has an undesired circular pattern:

![Original scan detail](/img-detail.png?raw=true)

> Many noisy images contain some kind of patterned noise. This kind of noise is easy to remove in the frequency domain as the patterns show up as either a pattern of a few dots or lines. Recall a simple sine wave is a repeated pattern and shows up as only 3 dots in the spectrum.
>
> In order to remove this noise, one simply, but unfortunately, has to manually mask (or notch) out the dots or lines [...]

Run `step1.sh` to create the spectrum image. It defaults to creating it from `img.jpg`, a custom one can be passed as a parameter: `step1.sh scan.png`.

![Spectrum](/img_spectrum.png?raw=true)

> We see that the spectrum contains four bright star-like dots, one in each quadrant. These unusual points represent the pattern in the image we want to get rid of.
>
> The bright dot and lines in the middle of the image are of no concern as they represent the DC (average image color), and effects of the edges from the image, and should not be modified.
>
> [...] I masked out the area of those 4 star like patterns.

In this case, the spectrum has several brighter areas in a circular pattern, which should be a good candidate for masking. Use soft edges for the best result.

![Mask being created](/img_spectrum_mask-editing.png?raw=true) ![Mask](/img_spectrum_mask.png?raw=true)

> Now we simply multiply the mask with the magnitude and use the result with the original phase image to transform back to the spatial domain.

Run `step2.sh` (with the same parameter as step 1 if it was used, e.g. `step2.sh scan.png`) to create the final image.

![Result](/img_filtered.png?raw=true)

Depending on the original dimensions, the resulting image will be padded:

> To make it work as people generally expect for images, any non-square image or one with an odd dimension will be padded (using Virtual Pixels to be square of the maximum width or height of the image. To allow for proper centering of the 'FFT origin' in the center of the image, it is also forced to have a even (multiple of 2) dimensions. The consequence of this is that after applying the Inverse Fourier Transform, the image will need to be cropped back to its original dimensions to remove the padding.

Just crop the result from the top left to the original dimensions.

Same detail as before:

![Result detail](/img_filtered-detail.png?raw=true)

Comparison:

![Original and result comparison](/comparison.gif?raw=true)
