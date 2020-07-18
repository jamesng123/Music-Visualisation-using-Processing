# Music-Visualisation-using-Processing
A music visualisation tool created using Processing and Java.

## Properties of the visualisation

#### Fast Fourier Transform

- The background colour is linked to FFT readings of the music. The colours then fade in to each other using lerpcolor.

- The FFT spectrum is in the middle of the screen in the form of a circular shape.

#### Beats

- A beat is detected using the Minim library.

- The speed of the bubbles, the rotational speed of the middle objects, as well as the speed of the parametric shape is based on the BPM of the music calculated over a 5 second period.

- Every time there is a beat the middle shape changes, and a bubble appears on the screen / is taken off the screen depending on how many bubbles are present. (Max 15).

- When there is a beat the brightness of the Phillips Hue is set to its maximum value.

#### Phillips Hue

- The colour of the light matches the background.

- When there is a beat the brightness value is set to its maximum (otherwise it's set to 50).
