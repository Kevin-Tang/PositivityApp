# Positivity App

## Purpose
The purpose of this project is to learn the fundamental skills in building iOS applications using the programming language Swift. Specifically speaking, mobile device programming is the future. Mobile devices has changed the way people communicate, do business, access news and entertainment, and even browse the internet. By utilizing online resources and tutorials, this project involves learning basic principles in order to build a simple application that tracks a streak of emotionally positive days with the capability to add brief context in a journal.

In particular, the programming language Swift has been thought of to be the next generation programming language, building on the infrastructure and techniques of Objective-C and Apple's Cocoa and Cocoa Touch Frameworks in order to build a safer programming experience. The future of mobile application development is bright as it brings more innovation in technological advances in areas such as virtual reality, augmented reality, artificial intelligence agents that have been seen more prevalent in the home, and of course, the Internet of Things.

Founder and CEO of Unsplash (unsplash.com)  and Crew (crew.co) Mikael Cho believes mobile apps will continue to be a prominenet fixture of the present. In a technology marketing blog [post](https://www.tune.com/blog/76-mobile-predictions-2017-76-marketing-influencers-reveal-winning-strategies/), Cho says 
> The future of work is clearly mobile. 90% of my day-to-day tasks are not only possible on my phone today but they’re **pleasurable**. I’m confident the majority of people will be working fully mobile within a few years.

## About the App
The goal of the project is to create a **Positivity** tracking app that maintains and incentivises positivity throughout someone's day. The ideal use of this app goes something like this; A user opens the app to reflect upon their day. As they think about the moments of their day, they begin to feel proud of the fact that they were resiliently positive throughout their day. They then open up the app, type in a one line sentence describing a moment that defines positivity of their day and taps the big round button on the screen to increase their strak of positive days. As users use this app, they can track their streak of positive days and if they want to look back on their previous days, they can take a view onto their journal and the details of that journal entry.

This app is to help people continue to live a positive and happy life. It's a simple and minnimalistic approach to maintaining happiness and journaling.

## Learning goals
1. [x] Core concepts of the programming language: Swift (3)
2. [x] Basic user inteface design
3. [x] Application of concepts learned in iOS projects

## How to build
Step one is to 'git clone' or download the project from the Github repo

```
git clone https://github.com/Kevin-Tang/PositivityApp.git
```

- Step two is to open Xcode and select 'Open another project...'
- Step three is build the project: Navigate to the menu bar and select 'Product -> Build' or 'Command + B' for shortcut
- Step four is to run the project: Navigate to the mnu bar and select 'Product -> Run' or 'Command + R' for shortcut

There may be some extra settings such as selecting Xcode development team that needs to be configured before running the app but the project should run a simulator and open up to the main screen of the application.

# Documentation

## MainViewController.swift
This file follows the structure:

1. Properties
2. UITextFieldDelegate
3. Navigations
4. Actions
5. Private Methods

This is the swift file the operates the main view of the application. It's subclassed under UIViewController and maintains functions of the ViewController object in the Main.storyboard.

At the beginning of the swift file, there's a section marked *Properties* that holds the files fields such as UITextFields, UILabels, UIButtons, etc. The function *viewDidLoad()* is called once when the ViewController object (this view) is created. 

The next section, *UITextFieldDelegate*, operates when the a textField is in the view. It controls when the keyboard appears and disappears and performs an action once the user is finished typing.

The next section, *Navigations*, holds an important function called 'override func prepare(for segue: UIStoryboardSegue, sender: Any?)' that prepares the ViewController to pass data/information from its own view to the next ViewController. In this function, it utilizes a segue that instances a new custom object of the class JournalEntry (which will be explained later) and passes this object to the next view.

The next section, *Actions*, holds two functions that links to two UIButton's the maintains the functionality of the count; 'incrementCount' and 'resetCount'. One function increased the count variable on the screen, saves the value to the device, and animates when pressed while the other function sets the count back to 0 and saves the value to the deveice.

The last section, *Private Methods*, holds private functions only relevant to the ViewController. getDate() returns a string of the current date today.

## EntryTableViewController.swift
This file follows the structure:

1. Properties
2. Table View data source
3. Navigation
4. Private Methods

In the *Properties* section, since this view is a TableViewController, the view holds properties that builds that of a table. Table cells are composed of custom class objects called JournalEntry that are stored in an array and is populated within the table. However, this section only instantiates the objects to be used within the view itself.

In the *Table View data source* section, the functions in this section is used to populate the table. The number of tableView sections are declared along with the number of rows (set equal to the number of JournalEntry array objects). The type of data within each table cell is also set through this function as well. Lastly, this section holds a function that allows users to swipe edit the cells in the table.

In the *Navigation* section, the two main functions are dismiss animation and prepareForSegue, which has been used before to pass data between View Controllers. The first function activates once the home UIBarButton that resides on the top left of this view is pressed and cancels the interaction of this view. The view is taken off the stack of the UINavigationController so that the view is no longer instantiated. The second function prepares the application to pass data to a detailViewController when a table cell is pressed. 

In the *Private Methods* section, this section holds functions only relevant to this view. The functions include savejournal that saves the array of custom class objects (JournalEntry) using a NSKeyedArchiver (different from how we saved the count integer in the first view), loadJournal() that gets the array of JournalEntry, and animateTable() that is placed in the viewWillAppear function and is activated once a change in the state of the application occured, such as the view controller is becoming "active."

## EntryTableViewCell.swift
The only section in this file is: 

1. Properties

*Properties* holds the objects of each Table Cell within the previous file, EntryTableViewController.swift. The properties in the table cell includes a message label, a date label, and a count label. 

## JournalEntry.swift
The JournalEntry.swift file is a custom class file that creates objects of the class JournalEntry. Each object is used to populate the TableViewController and is created by users entering their positive message of the day.

The file follows the structure:

1. Properties
2. Archiving Paths
3. Types
4. Initialization
5. NSCoding

Since the sections within each file is appearing redundent, it will be skipped for things that hasn't been explained yet. The section, *Archiving Paths*, is Swift's way of incorporating data persistance and archiving. Inhernrelty, Swift is an object oriented programming language. When data is passed along ViewControllers of an application, the data needs to be saved in order to use it for other ViewControllers. This section uses archiving which involves encoding objects into a format that is written to a file. Data may subsequently be decoded (or unarchived) and used to automatically rebuild the object.

The section *Types* simply stores the variables declared in properties as fields within the class. It's stored as a struct which is explained here by [Raywenderlich](https://www.raywenderlich.com/116714/swift-tutorial-introducing-structures)
> Structures, or structs, are one of the named types in Swift that allow you to encapsulate related properties and behaviors. You can define it, give it a name and then use it in your code.

Of course the custom class object has to include an intialization function. 

Finally, the section *NSCoding* is incorporated in the previous swift files explained above using NSKeyArchiver. IT's a way for Swift to store custom data objects and archive them for later use.

## DetailViewController.swift
This file follows the strcuture:

1. Properties
2. Actions

This file is last ViewController file in the application. It hosts the detail view of each table cell. Initially a simple static text view, the detailViewController includes labels that are animated onto the screen once the ViewController becomes active. The ViewController also has a Share Button for users to share their journal entry.

# Moving forward

Since this is a very simple application, there are a lot of improvements that could be made. Some ideas I have for improvement include things such as:

## Improving User Experience
The application is at it's very beginning stages of development. As an amatuer iOS devleoper, user experience was not at the forefront of my mind as I was building this application. The home screen could be improved to include a better experience that doesn't need explaination of the application in order for the user to understand the concept. Perhaps an improvement could be incorporated a tutorial upon first time load of the application. 

## Improving User Interface
User interface was also not a strong point in the development of this application. User aspects of the user interface that were included in order to give a more pleasing experience such as animation of the MainViewController, EntryTableViewController, and the DetailTailController. Some improvements to the interface could simply be not such a colorless application. The application is mostly functional but not asthetically pleasing.

## Improving Concept of the Application
One of the many ideas I have to improve the concept of the application is to incorporate a simply imrpovement that changes the color of the incrementCount button once the user reaches certains levels of the streak. For example, once the user reaches a streak of 5 positive days, they gain the beautiful color of green to incrementCounts. Another idea to improve the concept of the application is allow users to enter positive images of their own using a UIImagePickerController. 

All in all, the project was really fun to build and most of the techniques I learned was from the basic tutorual on Apple's developer website: [Start Developing iOS Apps (Swift)](https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/) by building a [FoodTracker App](https://github.com/Kevin-Tang/FoodTracker.git).
