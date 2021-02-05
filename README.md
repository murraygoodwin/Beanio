#  Beanio

## Overview
Beanio is a demo of a simple coffee shop finding app, completed for a job application, that pulls nearby coffee shops from the FourSquare API and presents them in an MVP style interface.

## Adding your FourSquare credentials
To test the demo, please add your own FourSquare credentials in the 'Credentials.swift' file under Managers > FoursquareAPI > Credentials.swift.

## Approach
I broke the project down into steps on a Trello board, which allowed me to track progress over time and prioritise my work accordingly.

### The tasks I identified were:
1. Create a FourSquare dev account
2. Undershand how to use the FourSquare API
3. Understand which information is returned
4. Design the look + feel
5. Design the architecture
6. Create an Xcode project without source control
7. Set up .gitignore file to exclude Credentials.swift
8. Set up git repos
9. Request User Location permissions
10. Get current location
11. Query the Foursquare API
12. Parse the JSON
13. Create a 'coffeeShop' object
14. Update the UI
15. Write unit tests
16. Write UI tests
17. Complete review checklist
18. Write README.md
19. Re-add Credentials.swift to repo

## User Interface Design
Please note that I have not focused extensively on the user interface in this example, since I have an existing published 'coffee shop listing app' available on the App Store, which I think gives a better indication of my abilities around UI design. It seemed silly to duplicate effort for a demo project where there is so much overlap.

ARTISAN is available here:
https://apps.apple.com/us/app/artisan-cafes-coffee-nearby/id1521699791

ARTISAN uses much the same approach as in this project – although it uses the Google Places and Maps APIs in place of FourSquare. I have given a lot of thought to the user interface, journeys and experience there, so it seemed more sensible to point you to that app instead.

In addition to a simple tableView as used in this demo, ARTISAN also incorporates functionality to: 
- overlay search results onto a map
- allow users to tap each listing to move the map
- allow users to tap the map pointers to move the table
- swipe down to refresh
- get directions to each venue
- view additional metadata for each listing, including Reviews, Photos and Open/Closed status
- receive sound feedback on user interactions

I recently refactored ARTISAN around MVVM and I intend to work on the styling of the tableView a bit more in the coming weeks.

I have included data for latitude and longitude in the listings objects within this demo, to allow for that functionality to be extended.


## Test Coverage
Test coverage currently stands at 91.4%. I experienced limitations around testing various Location Manager permissions scenarios, which I would like to explore with more time.


## Testing 'Warning Messages'
The Foursquare API returns 'warning messages' in certain scenarios (e.g. low numbers of results).

You can test this implementation by searching in an area such as: 
- Latitude: 50.245088
- Longitude: -31.867842
