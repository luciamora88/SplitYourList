Zachary Howe, Rathang Pandit,
Lucia Mora, Barbara Hernandez

Table Of Contents:
Milestone 1 Page 2 - 3
Milestone 2 Page 4 -5
Milestone 3 Page 6



Milestone 1:
	The goal of this project is to create a roommate app that appropriately separates the costs of living with each other and splits those costs evenly so people can pay throughout the month. The goal is to allow people in real time to connect a group to each other through a username and login. This will then have real time updating lists through a database. Allowing for certain data to exist and update real time. We want to give roommates the option to opt in for certain purchases within a specific list within that group. This way there is a receipt that can be kept track of to help remove issues and bickering between roommates. 
	This project seems to require a few concepts:
In order to develop the app we need a database that can handle or utilize listeners. It must work with ios and hopefully work with SwiftUI.
	A. I was thinking postgress but now that I have worked on it a bit, it seems that for this team and the time we have, it would be more effective to utilize firebase.


Another problem we will have to face is that most of our team does not have a Mac and unfortunately the access to a Mac in the Library does not work.
	A. We solve this issue by going to the maker space. There were a few Macs there and a special password to allow xcode for the ios engineer group which we happened to know the person running that group.

Each member has contributed to the readme however it was first built in a doc.

Proposal:
A login and authentication feature.
An ability to have real time updating UI
Working with a database (firebase or postgres) 
Creating and connecting the database and listeners for real time UI changing
Having the ability to invite friends who also have the app
A way to add up the cost for a month and deliver it automatically to each user
Simple UI design to make the feature easy to use for everyone.




Milestone 2:
Wireframes were hand drawn which made it difficult to showcase clearly in the readme
Drawing of database diagram using dbdiagram.io:
	

We have decided that all the features listed in the proposal are “must haves” and have concluded that each person will probably have about 10 hours of features to make and another ten for debugging the connections between each feature. We have also decided that if we have enough time we will attempt to add a few helpful features such as utilize the receipt reader on the apple camera to help speed up the list making process.


Hours and Designation:
A login and authentication feature in Swift and database. (10 hours) (Everyone) 
An ability to have real time updating UI (10 hours) (Everyone)
Working with a database (firebase or postgres) (10 hours) (Zachary)
Creating and connecting the database and listeners for real time UI changing (10 hours) (Zachary and Rathang)
Create the group page (Barbara) (5 hours)
Creating the create list page (Lucia) (5 hours)
Creating the UI design for the rest of the pages (20 hours) (Barbara and Lucia)




Milestone 3:
All must have features have been implemented
	Issue, Recap and Learning:
One of the largest issues we ran into was trying to find the proper computer locations. Trying to get open spots in the maker space for the project.
Another issue that we ran into was originally the database was going to use porting and postgres (because it is free and unlimited) however, after working with the database we found that the relational database was not as effective with swift in our circumstances as a nosql database would be so we had to port everything to firebase. There are also many more tutorials which will be referenced later on swiftUI and firebase connections.
After experiencing this we believe we have a better understanding of how we could make apps such as these in a more effective and faster pace than the first time. Utilizing more SwiftUI features instead of falling back to some old swiftUI habits that may be deprecated in the future for the faster and more reliable new features that have come out for IOS16.

Important Note: If you want to test the app, please email Zachary Howe (923229694 , Zacharyh777@gmail.com) to turn on the database as it is required for the app to run. Unfortunately I cannot keep the database running for cost purposes and I don’t know when it will be graded. Sorry for the inconvenience.
