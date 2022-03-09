//
//  ViewController.swift
//  Timer
//
//  Created by Binoy T on 09/03/22.
//

import UIKit

class TimerViewController: UIViewController {
    @IBOutlet weak var startResumeButton: UIButton!
    
    @IBOutlet weak var stopResetButton: UIButton!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    //   ViewModel instance for TimerViewModel
    private var viewModel = TimerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    
    deinit {
        removeNotificationObservers()
    }
    
    //  Stop/Reset button action
    @IBAction func stopTImer(_ sender: UIButton) {
        viewModel.stopTimer()
        updateButtonStatus()
        
    }
    //  Start/Pause button actopn
    @IBAction func startTImer(_ sender: UIButton) {
        viewModel.startPauseTimer()
        updateButtonStatus()
        
    }
    
    
    //    Set properties and oberver for notification
    private func initialize() {
        updateButtonStatus()
        
        viewModel.onTimeUpdate = { [weak self] (time) -> Void in
            self?.timeLabel.text = time
        }
    }
    
    //
    private func updateButtonStatus() {
        startResumeButton.setTitle(viewModel.startButtonTitle, for: .normal)
        stopResetButton.isHidden = !viewModel.canStopTimer
    }
    
    private func addNotificationObservers() {
        NotificationCenter.default.addObserver(viewModel, selector: #selector(viewModel.isGoingBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(viewModel, selector: #selector(viewModel.backToActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    private func removeNotificationObservers() {
        NotificationCenter.default.removeObserver(viewModel, name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.removeObserver(viewModel, name:  UIApplication.didBecomeActiveNotification, object: nil)
        
    }
}

