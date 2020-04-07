# Lossless audio compression
LOSSLESS AUDIO COMPRESSION IN THE NEW IEEE STANDARD FOR ADVANCED AUDIO CODING is a paper authored by H. Huang, H.Shu and R.Yu that explains a lossless audio compression standard proposed by the IEEE (Institute of Electrical and Electronics Engineers). In this GitHub repository I will propose an implementation using MATLAB and will review its results. 

## Introduction
Generally we can find two types of audio compression: lossy and lossless.
* **Lossy:** attempts to remove perceptually less important information from the audio data while keeping the sound quality very close, and sometimes indistinguisable to the original audio.
* **Lossless:** this algorithm essentially keeps every bit of information in the original audio data.

The general schema of the explained lossless compressor is the following:
