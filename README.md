# Introduction

This is a sample app that shows five unique, interesting flights to destinations you can visit with Kiwi.com on a daily basis. That is, if your sample app presents some selection of routes (f.e. PRG→JFK, ORY→SFO, ...) between destinations on Day 1, these exact routes won’t be offered again on a different day, and so on.

It uses the Kiwi.com Umbrella API to either list or search available Places and search for respective Flights based on your request.

# Development Steps

Below, you will find the list of steps that I followed to do that job. They match the commits in the git directory so you can review step by step if needed.
Write an introduction on the readme file.

1. **Readme file**: Write an introduction on the readme file.
2. **Project + Feature UI initial version**. Creating a SwiftUI-based Xcode project and doing the initial implementation of the UI. This implementation is unpolished and uses dummy data.
3. **Feature VIP**. Basic implementation of the "FlightOffers" Feature using the VIP pattern (see the VIP section)


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
