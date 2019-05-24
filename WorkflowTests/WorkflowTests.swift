//
//  WorkflowTests.swift
//  WorkflowTests
//
//  Created by Uday Pandey on 24/05/2019.
//  Copyright © 2019 Uday Pandey. All rights reserved.
//

@testable import Workflow
import XCTest

class WorkflowTests: XCTestCase {
    enum State {
        case initial
        case inprogress
        case end
    }

    enum Event {
        case start
        case stop
        case cancel
    }

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testWorkflowSimpleFlow() {
        let workflow = Workflow<State, Event>(state: .initial)
        XCTAssertNotNil(workflow, "Invalid workflow")

        workflow.addRoute(event: .start, from: .initial, to: .inprogress)
        workflow.addRoute(event: .cancel, from: .inprogress, to: .initial)
        workflow.addRoute(event: .stop, from: .inprogress, to: .end)

        XCTAssertTrue(workflow.currentState == .initial, "Invalid state")
        workflow.fire(event: .stop)
        XCTAssertTrue(workflow.currentState == .initial, "Invalid state")
        workflow.fire(event: .cancel)
        XCTAssertTrue(workflow.currentState == .initial, "Invalid state")

        workflow.fire(event: .start)
        XCTAssertTrue(workflow.currentState == .inprogress, "Invalid state")
        workflow.fire(event: .cancel)
        XCTAssertTrue(workflow.currentState == .initial, "Invalid state")
        workflow.fire(event: .start)
        XCTAssertTrue(workflow.currentState == .inprogress, "Invalid state")
        workflow.fire(event: .stop)
        XCTAssertTrue(workflow.currentState == .end, "Invalid state")

        workflow.fire(event: .start)
        XCTAssertTrue(workflow.currentState == .end, "Invalid state")
        workflow.fire(event: .stop)
        XCTAssertTrue(workflow.currentState == .end, "Invalid state")
        workflow.fire(event: .cancel)
        XCTAssertTrue(workflow.currentState == .end, "Invalid state")
    }

//    func testOnboardingFSMWorkflow() {
//        let router = RHCOnboardingFakeRouter()
//        let context = RHCOnboardingFakeContext(deviceType: .hub)
//        let fsm = OnboardingFSM(router: router, context: context)
//
//        // This is a placeholder test case to test the internal
//        // implementation of states and events for FSM. This will change
//        // and it is only for initial testing for FSM.
//        let workflow = fsm.workflow
//
//        XCTAssertNotNil(workflow, "Invalid workflow")
//
//        XCTAssertTrue(workflow.currentState == .initial, "Invalid state")
//
//        workflow.fire(event: .showInstallHelp)
//        XCTAssertTrue(workflow.currentState == .preInstallHelp, "Invalid state")
//
//        workflow.fire(event: .startPreInstallValidation)
//        XCTAssertTrue(workflow.currentState == .preInstallValidate, "Invalid state")
//
//        workflow.fire(event: .selectDevice)
//        XCTAssertTrue(workflow.currentState == .selectDevice, "Invalid state")
//
//        workflow.fire(event: .connectDevice)
//        XCTAssertTrue(workflow.currentState == .connectDevice, "Invalid state")
//
//        workflow.fire(event: .selectWifiNetwork)
//        XCTAssertTrue(workflow.currentState == .selectWifiNetwork, "Invalid state")
//
//        workflow.fire(event: .setupWifiNetwork)
//        XCTAssertTrue(workflow.currentState == .setupWifiNetwork, "Invalid state")
//
//        workflow.fire(event: .claimDevice)
//        XCTAssertTrue(workflow.currentState == .claimDevice, "Invalid state")
//
//        workflow.fire(event: .startPostInstall)
//        XCTAssertTrue(workflow.currentState == .postInstall, "Invalid state")
//
//        //        workflow.fire(event: .renameDevice)
//        //        XCTAssertTrue(workflow.currentState == .renameDevice, "Invalid state")
//
//        workflow.fire(event: .finish)
//        XCTAssertTrue(workflow.currentState == .finish, "Invalid state")
//    }
//
//    func testMigrationFSMWorkflow() {
//        let router = RHCOnboardingFakeRouter()
//        let context = RHCOnboardingFakeContext(deviceType: .hub)
//        let fsm = OnboardingFSM(router: router, context: context)
//
//        // This is a placeholder test case to test the internal
//        // implementation of states and events for FSM. This will change
//        // and it is only for initial testing for FSM.
//        let workflow = fsm.workflow
//
//        XCTAssertNotNil(workflow, "Invalid workflow")
//
//        XCTAssertTrue(workflow.currentState == .initial, "Invalid state")
//
//        workflow.fire(event: .showInstallHelp)
//        XCTAssertTrue(workflow.currentState == .preInstallHelp, "Invalid state")
//
//        workflow.fire(event: .startPreInstallValidation)
//        XCTAssertTrue(workflow.currentState == .preInstallValidate, "Invalid state")
//
//        workflow.fire(event: .selectDevice)
//        XCTAssertTrue(workflow.currentState == .selectDevice, "Invalid state")
//
//        workflow.fire(event: .connectDevice)
//        XCTAssertTrue(workflow.currentState == .connectDevice, "Invalid state")
//
//        workflow.fire(event: .selectWifiNetwork)
//        XCTAssertTrue(workflow.currentState == .selectWifiNetwork, "Invalid state")
//
//        workflow.fire(event: .setupWifiNetwork)
//        XCTAssertTrue(workflow.currentState == .setupWifiNetwork, "Invalid state")
//
//        workflow.fire(event: .claimDevice)
//        XCTAssertTrue(workflow.currentState == .claimDevice, "Invalid state")
//
//        workflow.fire(event: .startMigration)
//        XCTAssertTrue(workflow.currentState == .migration, "Invalid state")
//
//        workflow.fire(event: .finish)
//        XCTAssertTrue(workflow.currentState == .finish, "Invalid state")
//    }
//
//    func testOnboardingFSM() {
//        let router = RHCOnboardingFakeRouter()
//        let context = RHCOnboardingFakeContext(deviceType: .hub)
//        let fsm = OnboardingFSM(router: router, context: context)
//
//        XCTAssertNotNil(fsm, "Invalid FSM")
//
//        XCTAssertTrue(fsm.workflow.currentState == .initial, "Invalid state")
//        fsm.start()
//        XCTAssertTrue(fsm.workflow.currentState == .finish, "Invalid state")
//    }
//
}
