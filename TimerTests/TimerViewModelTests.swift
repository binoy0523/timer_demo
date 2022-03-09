//
//  TimerViewModelTests.swift
//  TimerTests
//
//  Created by Binoy T on 09/03/22.
//

import XCTest
@testable import Timer

class TimerViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testStartTimerCall() {
        let viewModel = TimerViewModel()
        // Invoke start timer action
        viewModel.startPauseTimer()
        XCTAssertTrue(viewModel.isTimerOn)
        XCTAssertTrue(viewModel.canStopTimer)
        XCTAssertEqual(viewModel.startButtonTitle, "Pause")
        
    }
    
    func testResetTimerCall() {
        let viewModel = TimerViewModel()
        // Invoke stop timer action
        viewModel.stopTimer()
        XCTAssertFalse(viewModel.isTimerOn)
        XCTAssertFalse(viewModel.canStopTimer)
        XCTAssertEqual(viewModel.startButtonTitle, "Start")
        
    }
    
}
