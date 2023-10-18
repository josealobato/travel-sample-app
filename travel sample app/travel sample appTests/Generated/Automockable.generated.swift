// Generated using Sourcery 2.1.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

@testable import travel_sample_app














final class FlightOffersInteractorInputMock: FlightOffersInteractorInput {

    //MARK: - request

    var requestCallsCount = 0
    var requestCalled: Bool {
        return requestCallsCount > 0
    }
    var requestReceivedEvent: FlightOffersInteractorEvents.Input?
    var requestReceivedInvocations: [FlightOffersInteractorEvents.Input] = []
    var requestClosure: ((FlightOffersInteractorEvents.Input) -> Void)?

    func request(_ event: FlightOffersInteractorEvents.Input) async {
        requestCallsCount += 1
        requestReceivedEvent = event
        requestReceivedInvocations.append(event)
        requestClosure?(event)
    }

}
final class FlightOffersInteractorOutputMock: FlightOffersInteractorOutput {

    //MARK: - dispatch

    var dispatchCallsCount = 0
    var dispatchCalled: Bool {
        return dispatchCallsCount > 0
    }
    var dispatchReceivedEvent: FlightOffersInteractorEvents.Output?
    var dispatchReceivedInvocations: [FlightOffersInteractorEvents.Output] = []
    var dispatchClosure: ((FlightOffersInteractorEvents.Output) -> Void)?

    func dispatch(_ event: FlightOffersInteractorEvents.Output) {
        dispatchCallsCount += 1
        dispatchReceivedEvent = event
        dispatchReceivedInvocations.append(event)
        dispatchClosure?(event)
    }

}
final class FlightOffersServicesProtocolMock: FlightOffersServicesProtocol {

    //MARK: - flights

    var flightsThrowableError: Error?
    var flightsCallsCount = 0
    var flightsCalled: Bool {
        return flightsCallsCount > 0
    }
    var flightsReturnValue: [FlightOfferEntity]!
    var flightsClosure: (() throws -> [FlightOfferEntity])?

    func flights() async throws -> [FlightOfferEntity] {
        if let error = flightsThrowableError {
            throw error
        }
        flightsCallsCount += 1
        return try flightsClosure.map({ try $0() }) ?? flightsReturnValue
    }

}
