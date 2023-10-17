# Introduction

This is a sample app that shows five unique, interesting flights to destinations you can visit with Kiwi.com on a daily basis. That is, if your sample app presents some selection of routes (f.e. PRG→JFK, ORY→SFO, ...) between destinations on Day 1, these exact routes won’t be offered again on a different day, and so on.

It uses the Kiwi.com Umbrella API to either list or search available Places and search for respective Flights based on your request.

# Development Steps

Below, you will find the list of steps that I followed to do that job. They match the commits in the git directory so you can review step by step if needed.
Write an introduction on the readme file.

1. **Readme file**: Write an introduction on the readme file.
2. **Project + Feature UI initial version**. Creating a SwiftUI-based Xcode project and doing the initial implementation of the UI. This implementation is unpolished and uses dummy data.
3. **Feature VIP**. Basic implementation of the "FlightOffers" Feature using the VIP pattern (see the VIP section)
4. **Service + Remote Storage**. Simple implementation of the remote storage in charge of querying the API.
5. **Connect feature to service**. Connecting the feature to the service and building the view model from the entities to show them on screen.
6. **Images**. Show the images on the interface.

## VIP pattern

The feature is developed using the View-Interactor-Presenter pattern. This pattern depicts a circular relation with the Interactor as the only independent object, allowing testing it thoroughly. In this demo project, the feature is not built on a package, but the idea is that every feature could be in a container offering the minimum set of interfaces to plug them into the application. Its dependencies will also be reduced to the Entities.

You can see in this diagram the VIP implementation.
```
 Feature build   ┌───────────────────────────────────────────────────────────────────────────┐
    facility     │                   FlightOffers (V.I.P. Implementation)                    │
                 │   ┏━━━━━━━━━━━━━━━━━━━━━━━┓                                               │
           .     │   ┃  FlightOffersBuilder  ┃                                               │
          ( )────┼── ┃                       ┃                                               │
           '     │   ┗━━━━━━━━━━━━━━━━━━━━━━━┛                                               │
                 │                                                                           │
                 │  ┏━━━━━━━━━━━━━━━━━━━━━━━┓              ╔═══════════════════════════╗     
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

## What is missing

* I can not consider this application to be production-ready because there are many things missing.
* Error management. The service data throws, and the VIP should handle those errors and inform the user about the state.
* No connection state. The app does not inform the user about no connectivity.
* UT is missing. All the functional logic should be tested. In this case, the View Model Builder and the Intercator should be covered. 
* Not Decode Protection. There is no decoding protection on the remote storage. Changes on the server can break the app.

## Administrative information

I did invest a total of n hours on this test.
