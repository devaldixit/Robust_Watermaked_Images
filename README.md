# Robust_Watermaked_Images
Watermarking Images In Wavelet Domain. 


**What is Digital Watermarking?**
In digital watermarking, information is embedded in the form of secret message or key (logo’s, labels, texts etc.) into
multimedia data which thereafter could be used for various applications such as authentication, copyright protection, and
tamper detection, etc. In view of the necessity of the application the watermark is extracted by the detection algorithm to
make an assertion of the object. The object may be image, audio or video.

**About This Project**
This project focuses on watermark embedding and extraction algorithms using 3-level Discrete Wavelet Transform (DWT)
watermarking technique. Also, to determine the robustness of the watermarked image, several “Attacks” are
performed. The quality of reconstructed image is calculated using **PSNR (Peak-Signal-to-Noise Ratio)**(Typical values for the PSNR in lossy image and video compression are between 30 and 50 dB, where higher is better), the correlation between
inserted and extracted watermark is calculated using the **correlation coefficient**, and **SSIM (Structural Similarity Index)** is
calculated for measuring the image quality.

In this project, watermarking technique based on a 3-level discrete wavelet transform has been implemented. In which
DWT transform is preformed on both host and watermark image and watermark is embedded on the host image with a **scaling
factor 'a'** . Results show that the quality of the watermarked image is dependent on the scaling factor ‘a’, also
higher scaling factor results in a visible watermark thus **we can use scaling factor to make watermarked image visible or
invisible according to the need of media distribution.

Discrete Wavelet Transform (DWT) based watermarking approach performed in **Haar transform domain** allows robust
embedding while preserving the perceptual aspects of the host image. With several attacks performed on the watermarked
image it is clear from their PSNR evaluation that this method provides high resilience.

Based On the Paper: ATTACKS ON DIGITAL WAVELET IMAGE WATERMARKS. (Authors: Andreja Samcovic and Jan Turan)
link:https://pdfs.semanticscholar.org/da90/181d987222de8257f6133844af11c46c232b.pdf
