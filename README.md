BNR4e_Ch17_AutorotationPopoverModal
===================================

Big Nerd Ranch's iOS Programming 4th ed, Hillegass & Conway
Ch 17: Autorotation, Popover Controllers, and Modal View Controllers

Homepwner app 
- this app builds on the functionality of the Homepwner app from chapter 16. 
- the image view from the has been re-added programmatically; user can take and 
save images in the detail items view.
- clicking on the "+" bar button in items view now launches the detail 
view modally

- on iPhones only, the camera button is disabled in detail interface 
when device is in landscape orientation 
- on iPads only, the interface rotates when device is upside down
- on iPads only, the image picker in displayed inside a popover 
controller when the user presses the camera button
- on iPads only, the detail interface is presented modally when user 
creates a new item

-----------------------------------

Note : in all repos of previous chapters, I'd recreated the repo from scratch, as 
I considered that separating each chapter's lessons in this way would be 
beneficial for organizational purposes.  However, the git logs of previous 
chapter's commits would not be kept  with each new chapter.  

Henceforth, starting with Ch17, I am keeping the repos from each 
successive chapter; each chapter's 'release' will be tagged.

-----------------------------------
Tagging Conventions: 

Commits that correspond to the completion of a chapter will be tagged 0.4.x, 
where x is the chapter number, and 4 represents the 4th edition of BNR. 

-----------------------------------

Chapter 17 covers the following :

- Distinguishing various device families
- Rotation Notification 
- UIPopoverController
- Presenting modal view controllers
