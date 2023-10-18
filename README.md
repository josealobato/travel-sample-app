# Introduction

This is a sample app that shows five unique, interesting flights to destinations you can visit with Kiwi.com on a daily basis. That is, if your sample app presents some selection of routes (f.e. PRG→JFK, ORY→SFO, ...) between destinations on Day 1, these exact routes won’t be offered again on a different day, and so on.

It uses the Kiwi.com Umbrella API to either list or search available Places and search for respective Flights based on your request.

# Some Decisions

* **Unique offers different days**. I decided to query every day for one-way itineraries that **start that given day**. This way, I will offer every day fresh information. But I wonder if the API works like this. I decided not to invest more time guessing how the API works on this part. In a work environment, I'll gather more information and even contact the people who could explain what to expect from it.
* **Unique offerings on one day**. I noticed that some offers received have almost the same data (at least the one on the interface), including the same `id`. **I decided that data with different id are different**. So, on the same day, you will see offerings that look the same but are different (different ID). Probably, a better strategy is needed here once more acquainted with the API.

# Development Steps

Below, you will find the list of steps that I followed to do that job. They match the commits in the git directory so you can review step by step if needed.
Write an introduction on the readme file.

1. **Readme file**: Write an introduction on the readme file.
2. **Project + Feature UI initial version**. Creating a SwiftUI-based Xcode project and doing the initial implementation of the UI. This implementation is unpolished and uses dummy data.
3. **Feature VIP**. Basic implementation of the "FlightOffers" Feature using the VIP pattern (see the VIP section)
4. **Service + Remote Storage**. Simple implementation of the remote storage in charge of querying the API.
5. **Connect feature to service**. Connecting the feature to the service and building the view model from the entities to show them on screen.
6. **Images**. Show the images on the interface.
7. **Remote Storage query for one day and many places**. Use the place's query to fill the one-way itineraries query. Also, restrict the departure to a single day. 
8. **Loading and Error State**. Quickly handle the error, loading, and no data states on the View. 
9. **Basic ut coverage to view model and interactor**. The tests don't cover the whole functionality but the basics. This entry also includes the generation of mocks with Sourcery. One can regenerate the mocks by calling `rake mocks` on ther root of the repository. Notice that I added a `Rakefile` at the root of the project to do so. 
10. **Some cleaning and documentation**

## VIP pattern

The feature is developed using the View-Interactor-Presenter pattern (VIP). This pattern depicts a circular relation with the Interactor as the only independent object, allowing testing it thoroughly. In this demo project, the feature is not built on a package, but the idea is that every feature could be in a container offering the minimum set of interfaces to plug them into the application. Its dependencies will also be reduced to the Entities, and even this could be avoided.

You can see in this diagram the VIP implementation.
```
 Feature build   ┌───────────────────────────────────────────────────────────────────────────┐
    facility     │                   FlightOffers (V.I.P. Implementation)                    │
                 │   ┏━━━━━━━━━━━━━━━━━━━━━━━┓                                               │
           .     │   ┃  FlightOffersBuilder  ┃                                               │
          ( )────┼── ┃                       ┃                                               │
           '     │   ┗━━━━━━━━━━━━━━━━━━━━━━━┛                                               │
                 │                                                                           │
                 │  ┏━━━━━━━━━━━━━━━━━━━━━━━┓              ╔═══════════════════════════╗     │  
                 │  ┃ FlightOffersPresenter ┃              ║     FlightOffersView      ║     │
                 │  ┃                       ┃◀─────────────║  <<public as some View>>  ║     │
                 │  ┗━━━━━━━━━━━━━━━━━━━━━━━┛              ╚═══════════════════════════╝     │
                 │              │                                        │                   │
                 │              │                                        │                   │
                 │              ▼                                        ▼                   │
                 │                                                                           │
                 │FlightOffersInteractorOutput             FlightOffersInteractorInput       │
                 │                                                                           │
                 │              ▲                                        ▲                   │
                 │              └──────────────────────┬─────────────────┘                   │
                 │                                     │                                     │
                 │                      ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓                      │
                 │                      ┃                             ┃                      │
                 │                      ┃   FlightOffersInteractor    ┃                      │
                 │                      ┃                             ┃                      │
                 │                      ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛                      │
                 │                                     │                                     │
                 │                                     ▼                                     │
                 │                                                                           │
                 │                       FlightOffersServicesProtocol                        │
                 │                                <<public>>                                 │
                 │                                                                           │
                 │                                     │                                     │
                 └─────────────────────────────────────┼─────────────────────────────────────┘
                                                       │                                      
                                                       .     Feature Interface for            
                                                      ( )          services.                  
                                                       '                                      
```

The only object omitted in this diagram is the ViewModel created in the Presenter and Observed by the View.

> Please notice that VIP is not a bidirectional structure. The presenter receives requests from the Interactor, but it doesn't talk to the Interactor.

## What is missing

I can not consider this application to be production-ready because there are many things missing. Among them:

* Error management. The service data throws, and the VIP should handle those errors and inform the user about the state.
* No connection state. The app does not inform the user about no connectivity.
* UT is missing. All the functional logic should be tested. In this case, only the View Model Builder and the Intercator are covered partially as an example. 
* Not Decode Protection. There is no decoding protection on the remote storage. Changes on the server can break the app.
* Desing. I invest no time on desing.
* Localization. Strings should not be hardcoded on the views or errors. They should be localized.
* Code review. I expect the code to be reviewed by other developers to catch potential issues and suggest improvements.

## Administrative information

I did invest a total of 11 hours on this sample app. A big part was on setting up the UI and on getting aquainted with the GraphQL API.

## On code, and formatting

You will notice that in some cases, I use an empty line after a curly brace, especially in methods. That was the rule in my previous company, and I am used to it. Having Swift Lint setup and configured will help to adjust to any coding style.

On the Feature (FlightOffer), you will notice that I have used `public` in many places when it is unnecessary. The idea is that every feature will be in its own package, and only the `public` builder and interfaces will be visible from the outside. So, I use `public` as a notation to demonstrate that fact.
