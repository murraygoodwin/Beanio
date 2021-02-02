#  Beanio

## FourSquare credentials
Please add your FourSquare credentials in the 'Credentials.swift' file.

## Approach
I broke the project down into steps on a Trello board, which allowed me to track progress over time and prioritise my work accordingly.

### The discrete tasks I identified were:
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


## Notes on user Interface Design
Please note that I have not focused on the user interface in this example, since I have an existing published 'coffee shop listing app' available on the app store, which I think gives a good indication of my abilities around UI design. It seemed silly to duplicate effort for a throwaway project.

ARTISAN is available here:
https://apps.apple.com/us/app/artisan-cafes-coffee-nearby/id1521699791

ARTISAN uses much the same approach as in this project and I have given a lot of thought to the user interface, journeys and experience, so it seemed a more sensible use of time to point you to that app instead. In addition to a simple tableView, ARTISAN also incorporates functionality to overlay the search results onto a map, interact with each listing, and allows the user to get directions to each location.

I have included data for latitude and longitude in the listings data within this demo to allow for that functionality to be extended.
