# Lossless audio compression
LOSSLESS AUDIO COMPRESSION IN THE NEW IEEE STANDARD FOR ADVANCED AUDIO CODING is a paper authored by H. Huang, H.Shu and R.Yu that explains a lossless audio compression standard proposed by the IEEE (Institute of Electrical and Electronics Engineers). In this GitHub repository I will propose an implementation using MATLAB and will review its results. 

## Introduction
Generally we can find two types of audio compression: lossy and lossless.
* **Lossy:** attempts to remove perceptually less important information from the audio data while keeping the sound quality very close, and sometimes indistinguisable to the original audio.
* **Lossless:** this algorithm essentially keeps every bit of information in the original audio data.

The general schema of the explained lossless compressor is the following:
---IMG

In the following sections we will detail each of the building blocks of the lossless encoder.

## Predictor
Below we can find the predictor schema. 
--IMG

Input audio samples are first segmented into frames of fixed length (30ms in our implementation). Take into account that as we are working with stereo audio, all the processing is done for each channel separately. From now on all the performed operations will be referred to one 30ms frame of one of the channels.

Once we have the frame we have to calculate its PARCORs (partial correlation) coefficients through the Levinson-Durbin algorithm. In our case, we used 20 coefficients. Then we quantify those coefficients to send them to the reconstructor. At the same time, we dequantize them in this same block in order to obtain the LPC (Linear Predictive Coding) coefficients in order to make the prediction with the same ones we are going to use in the decoding part, so the reconstruction is exact. Through this method, we will avoid losses when quantifying.
Going more into the quantization detail, it is performed in two steps. First of all, we quantify non-evenly through the arcsin() function. After that, we quantify uniformly.

At the reconstructing part, as we don't have the original signal yet, we cannot perform the prediction directly filtering the signal with the obtained LPC coefficients. To do so, we apply the following formulas:

--IMG

## Pre-processor
Below we can find the pre-processor schema.
-- IMG
