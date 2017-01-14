# Positivity App

## Purpose
The purpose of this project is to learn the fundamental skills in building iOS applications using the programming language Swift. Specifically speaking, mobile deveice programming is the future. Mobile has changed the way people communicate, do business, access news and entertainment, and even browse the internet. By utilizing online resources and tutorials, the project involves learning basic principles in order to build a simple application that tracks a streak of emotionally positive days with the capability to add brief context in a journal.

In particular, the programming language Swift has been thought of to be the next generation programming language, building on the infrastructure and techniques of fundamental languages such as Objective-C and Apple's Cocoa and Cocoa Touch Frameworks in order to build a safer programming experience. The future of mobile application development in general is thought to be in good light as the future brings more innovation in technological advances in areas such as virtual reality, augmented reality, artificial intelligence agents that have been seen more prevalent in the home, and of course, the Internet of Things.

Founder and CEO of Unsplash (unsplash.com)  and Crew (crew.co) Mikael Cho believes mobile apps will continue to be a prominenet fixture of the present, saying 
> The future of work is clearly mobile. 90% of my day-to-day tasks are not only possible on my phone today but they’re **pleasurable**. I’m confident the majority of people will be working fully mobile within a few years.

## About the App
The goal of the project is to create a **Positivity** tracking app that is maintains and incentivises positivity throughout someone's day. The ideal use of this app goes something like this; A user opens the app to reflect upon their day. As they think about the moments of their day, they begin to feel proud of the fact that they were resiliently positive throughout their day. They then type one line sentence describing a moment that defines positivity of their day and taps the big blue button on the screen to increase the positive day count. As users use this app, they can track their streak of positive days and if they want to look back on their previous days, they can take a view onto their journal and the details of that journal entry.

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

## EntryTableViewCell.swift

## JournalEntry.swift

## DetailViewController.swift

# Moving forward
