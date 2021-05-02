# TableFetch
Show parse data from json response

To run the project, go to the root folder and then pod install 

# Project Coverage 
App fetch data from API provided, then the data will be parse to a table. (For this sample I just call the api call once, then insert that data to Core Data, Once the data is stored, that data will be used for future usage -- Data checker/removing duplicates to core data this part is in progress/for improvement on my next commit ✌️🙏)

After fetching the data and already stored to core data. It will be shown on the table. (MovieList View/Tab)

Each table cell has a capability to add the data to their favourites. (Favourites View/Tab)
App can show movie title, price, category, image. 

Once the user clicks the cell, it will navigate to DetailViewController. On the DetailViewController you can see the title, image, star/actor name, and the long description. You can navigate back to the main screen. Once you navigate back to the previous screen, you can see that the cell was modified and "date visited label" was added.

App has the search functionality as well. It is sorted by 'Movie Title'

UI is compatible on for iphone and ipad portrait, although the image may be pixelated. 

**Notes**

Wasn't able to implement SwiftUI for this project and I used swift 4/XCode 9.3 since my macbook is outdated ☹️

**Reccommendations**

Feel free to contact me for suggestions and improvements 😃

**Future plans**

Code improvement and to add more features. 
