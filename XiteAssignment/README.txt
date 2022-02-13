- This is a simple Roku Scene Graph music video channel containing mainly two screens:
a) Landing Screen - Contains movie grid. User can explore items here. User can apply filters as well and can also search content here.
b) Player Screen - Used for straming videos.

-  All the data for the screens is retrieved using a REST api which is executed when app launches at Main Scene.

-  User can filter content based on their release years & genres at Landing Screen. User can seach data based on music title as well.

-  User can play any content by pressing any item of Movie Grid at Landing Screen.

- Strucuture of the application:
a) CustomComponents - This folder contains some custom UI/Functional components which are used in the application at various places.
b) Main Scene - This is parent of all the components. Api call is initiated here to  get the screens data.
c) Modules - Contains all the main modules(Landing, Keyboard & Player).
d) NetworkUtils -  Contains Screen Data Task.
e) ApiHandler - Contains bright script code for making api call.
f) AppUtilities - Contains some utilities methods which are to be used throughout the application.
g) Constants - Contains some string literels which are to be used throughout the application

- Architecture of the application:
MVVM - This application intends to follow MVVM design pattern. Every module has  two folders:
a) Screens - Contains some configuration & focus handling related code.
b) ViewModel - Contains all the business logic.