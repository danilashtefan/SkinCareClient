# Introduction
Skincare feels like a never-ending experiment with a complicated cycle of trial and error. It is well known that skin is an indicator, by monitoring which we can prevent various serious deceases.
Unfortunately, currently skin problems have no commonly used detection and solution algorithm. However, technological progress provides us with computational resources, which are widespread and powerful and can help us to make a huge step towards the solution of the skincare problem and make the detection of skin issues available from home for everyone.
The goal of the Project Laboratory is to build a neural network for image processing, that will detect skin problems. Since one of the most visible and wide-spread skin problem is acne, it can become the first skin problem that will be detected by the neural network.
In the frames of this Project, the students were  engaged in developing a mobile face care application that will help users to track the state of their skin.


# Functionality description
User is able to access application via the email registration. After the email is successfully verified, user is able to access his profile. On the main page user is able to see some of his previous analysis. Via tapping on it, the page with detailed description is opened. "+" button will open the gallery, from where user will be able to upload on the images for the analysis. User will be able to receive the results later, pressing the "Box" item. Also, "News feed" functionaloty is available for the user, where he can see some articles related to the skincare and beauty topics


# Architecture description

### Log in

 The `Google Firebase` was used to implement login and registration functionality. All the users and their encrypted passwords are stored in the `firebase` database

### Design

First of all SWIFT UIKit was chosen to build the user interface, however, after the thorough investigation design of the project was implemented using the SwiftUI library.

### Server communication 

Local Python server (https://github.com/AirinB/SkinTrackingApp )is supposed to be run to let the application work. When user uploads the photo it is initially uploaded to the `Firebse` storage and download link is is sent to the locally running server via the `POST HTTP` request. Server is downloading the image, processes it (it contains AI model trained to detect pimples), uploads to the `Firebase` and sends the processed image download link as a response. After this, the response link is saved to UserDefault. When user clicks to the "box" icon on the navigation bar, processed image is retrieved and shown to him/her. Image is saved to the local storage later, and added to the list of the last user analysis.


### News API

News API was chosen for the implementation of the beauty news feed. The MVVP pattern is used to implement it: View contains ViewModel and ViewModel contains the NewsService, which fires the events when the API call is done. Based on these events ViewModel updates the view. 



