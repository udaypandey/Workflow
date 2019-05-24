//
//  Workflow.swift
//  Workflow
//
//  Created by Uday Pandey on 24/05/2019.
//  Copyright © 2019 Uday Pandey. All rights reserved.
//

import Foundation

/// Generic state machine implementation
///
/// Add states and events and define the routes between states based
/// on events.
///
/// It can be used to build any kind of state and event based transition.
class Workflow<State: Hashable, Event: Hashable> {
    /// Provide the context to the handler on state transition
    /// A state may be entered from different events and states
    /// Handler may use the transition object to take further actions
    typealias Transition = (event: Event, from: State, to: State, userInfo: Any?)
    typealias TransitionHandler = (_ transition: Transition) -> Void
    typealias TransitionErrorHandler = () -> Void

    private(set) var currentState: State

    /// Any user specific data and it will be provided to handlers
    /// for any state transitions
    private var userInfo: Any?

    private var transitions: [RoutingKey<State, Event>: State] = [:]

    private var routes: [State: TransitionHandler] = [:]

    /// Called in case of invalid event trigger or mis configured
    /// FSM. The user of the framework can set it up to capture
    /// any missing transitions
    var errorHandler: TransitionErrorHandler?

    init(state: State, userInfo: Any? = nil) {
        self.currentState = state
        self.userInfo = userInfo
    }

    func addRoute(event: Event, from fromStates: [State], to toState: State) {
        for state in fromStates {
            addRoute(event: event, from: state, to: toState)
        }
    }

    func addRoute(event: Event, from fromState: State, to toState: State) {
        let key = RoutingKey(state: fromState, event: event)
        transitions[key] = toState
    }

    func fire(event: Event) {
        let key = RoutingKey(state: currentState, event: event)

        guard let toState = transitions[key] else {
            errorHandler?()
            return
        }

        let fromState = currentState
        currentState = toState

        let transition = (event: event, from: fromState, to: toState, userInfo: userInfo)
        routes[currentState]?(transition)
    }

    subscript(state: State) -> TransitionHandler? {
        get {
            return routes[state]
        }

        set (newValue) {
            routes[state] = newValue
        }
    }
}

private struct RoutingKey<State: Hashable, Event: Hashable>: Hashable {
    let state: State
    let event: Event

    func hash(into hasher: inout Hasher) {
        hasher.combine(state)
        hasher.combine(event)
    }

    static func == (lhs: RoutingKey, rhs: RoutingKey) -> Bool {
        return lhs.state == rhs.state && lhs.event == rhs.event
    }
}
