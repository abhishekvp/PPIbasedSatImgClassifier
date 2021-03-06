PPI and Spectral Angle Based Satellite Image Classifier Web Application
========================================================================
End Member Extraction using PPI and Spectral Angle Classifier is a web application, that has been developed using MATLAB at its core. 
The front end has been designed in HTML and CSS. PHP is used at the backend for image upload and triggering MATLAB.

Application Flow:
-------------
* The image input is handled by the HTML front-end, the PHP back-end uploads the image on the server. 
* The PHP at the backend then triggers the MATLAB Script that takes the uploaded image as input and generates the classified image as the output. 
* The PHP waits for the output classified image to be generated by MATLAB, once generated, it renders the classified image to the browser.

GUI Screenshots:
----------------
![Home Page](https://raw.githubusercontent.com/abhishekvp/PPIbasedSatImgClassifier/master/screenshots/GUI-Home%20Page.png "Home Page")
![Classified Image Output](https://raw.githubusercontent.com/abhishekvp/PPIbasedSatImgClassifier/master/screenshots/GUI-Result.png "Classified Image Output")



