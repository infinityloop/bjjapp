//
//  CountdownTimerLabel.swift
//  bjj
//
//  Created by Kelvin Lau on 2015-02-28.
//  Copyright (c) 2015 Kelvin Lau. All rights reserved.
//

protocol countdownTimerDelegate {
    func timerDidFinish(label: UILabel)
    func timerDidStop(label: UILabel)
    func timerDidStart(label: UILabel)
}

class CountdownTimerLabel: UILabel {

    // MARK: - Class Properties
    
    var timeInCentiseconds: Double = 0
    var initialTime: Double = 0
    
    var delegate: countdownTimerDelegate?
    
    var timer: NSTimer?
    
    var minutes: Double {
        get {
            return floor(self.timeInSeconds / 60)
        }
        set {
            self.timeInSeconds = newValue * 60
            self.updateTimer()
        }
    }

    var seconds: Double {
        get {
            return floor(self.timeInSeconds % 60)
        }
    }
    
    var  centiSeconds: Double {
        get {
            return self.timeInCentiseconds % 100
        }
    }
    
    var timeInSeconds:Double {
        get {
            return self.timeInCentiseconds / 100
        }
        set {
            self.timeInCentiseconds = newValue * 100
            self.updateTimer()
        }
    }
    
    // MARK: - Init Methods

    init(frame: CGRect, seconds: NSInteger) {
        super.init(frame: frame)
        self.textColor = UIColor.whiteColor()
        self.font = UIFont.systemFontOfSize(45)
        self.numberOfLines = 0
        self.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.timeInSeconds = Double(seconds)
        self.initialTime = self.timeInCentiseconds
        self.updateTimer()
        
        var tapTimer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "didTapTimer")
        self.addGestureRecognizer(tapTimer)
        
        var doubleTapTimer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "didDoubleTapTimer")
        doubleTapTimer.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTapTimer)
        
        self.userInteractionEnabled = true
        
        self.setupNotifications()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.stopNotifications()
    }
    
    // MARK: - Convenience Methods
    
    func setupNotifications() {
        UIDevice.currentDevice().beginGeneratingDeviceOrientationNotifications()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "deviceDidChangeOrientation", name:UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    func stopNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: - Notification Methods
    
    func deviceDidChangeOrientation() {
        self.layoutSubviews()
    }
    
    // MARK: - Class Methods
    
    func tickTimer() {
        if (self.timeInCentiseconds > 0) {
            self.timeInCentiseconds -= 1
            self.updateTimer()
        } else {
            self.stopTimer()
            self.delegate!.timerDidFinish(self)
        }
    }
    
    func updateTimer() {
        self.text = NSString(format: "%01.0f:%02.0f:%02.0f", self.minutes, self.seconds, self.centiSeconds)
    }

    func startTimer() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "tickTimer", userInfo: nil, repeats: true)
        self.delegate?.timerDidStart(self)
        self.textColor = UIColor.whiteColor()
    }
    
    func stopTimer() {
        if ((self.timer?.valid) != nil) {
            self.timer?.invalidate()
        }
        self.timer = nil
        self.delegate!.timerDidStop(self)
        self.textColor = UIColor.grayColor()
    }
    
    func resetTimer() {
        self.stopTimer()
        self.timeInCentiseconds = self.initialTime
        self.updateTimer()
        self.textColor = UIColor.whiteColor()
    }
    
    // MARK: - Gesture Methods
    
    func didTapTimer() {
        if (self.timer == nil) {
            self.startTimer()
        } else {
            self.stopTimer()
        }
    }
    
    func didDoubleTapTimer() {
        self.resetTimer()
    }

}
