//
//  TimerViewModel.swift
//  Timer
//
//  Created by Binoy T on 09/03/22.
//

import Foundation
final class TimerViewModel {
    private var counter = 0
    private var timer:Timer = Timer()
    var onTimeUpdate: ((_ time: String) -> Void)?
    var didEnterBackground = false
    var lastActiveDate:Date = Date()
    
    private var _isTimerOn = false
    
    private var _isPaused = false
    
    public var isTimerOn : Bool {
        get {
            return _isTimerOn
        }
    }
    
    
    public var isPaused: Bool {
        get {
            return _isPaused
        }
    }
    
    public  var startButtonTitle: String {
        get {
            if(_isTimerOn) {
                
                return isPaused ? "Resume":"Pause"
            }
            return "Start"
        }
    }
    
    public var canStopTimer : Bool {
        get {
            if(_isTimerOn) {
                return true
            }
            return false
        }
        
    }
    
    // Start and pause function on timer
    func startPauseTimer() {
        if(isPaused || !_isTimerOn) {
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            _isTimerOn = true
            _isPaused = false
        } else {
            timer.invalidate()
            _isPaused = true
        }
    }
    
    //  Stop/Reset the timer and set counter to 0
    func stopTimer() {
        timer.invalidate()
        counter = 0
        _isTimerOn = false
        _isPaused = false
        updateTimer(hours: 0, minutes: 0, seconds: 0)
    }
    
    
    // function called on every time interval from the timer
    @objc func timerAction() {
        counter += 1
        let time = generateTimeInFormat(seconds: counter)
        updateTimer(hours: time.0, minutes: time.1, seconds: time.2)
        
    }
    
    // convert time in seconds to hours,minutes & seconds
    func generateTimeInFormat(seconds:Int) -> (Int,Int,Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    // Time converted to string with format HH:MM:SS
    func updateTimer(hours:Int, minutes:Int, seconds:Int) {
        var timeString = String(format: "%02d", hours)
        timeString += ":"
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        onTimeUpdate?(timeString)
    }
    
    //  Notification observer method for UIApplication.didEnterBackgroundNotification
    @objc func isGoingBackground() {
        timer.invalidate()
        _isPaused = true
        didEnterBackground = true
        lastActiveDate = Date.now
        
    }
    
    //  Notification observer method for UIApplication.didEnterBackgroundNotification
    @objc  func backToActive() {
        if(didEnterBackground) {
            didEnterBackground = false
            let currentDate = Date.now
            let currentAccumulatedTime = currentDate.timeIntervalSince(lastActiveDate)
            counter +=  Int(round(currentAccumulatedTime))
            lastActiveDate = currentDate
            let time = generateTimeInFormat(seconds: counter)
            updateTimer(hours: time.0, minutes: time.1, seconds: time.2)
            startPauseTimer()
        }
    }
}

