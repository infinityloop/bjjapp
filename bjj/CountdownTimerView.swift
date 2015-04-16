//
//  CountdownTimerView.swift
//  bjj
//
//  Created by Kelvin Lau on 2015-03-02.
//  Copyright (c) 2015 Kelvin Lau. All rights reserved.
//

protocol CountdownTimerDelegate {
    func timerDidFinish()
    func timerDidStop()
    func timerDidStart()
}

class CountdownTimerView: UIView, TimeTableDelegate {

    var minuteTableView: TimerTableView!
    var secondTableView: TimerTableView!
    var centisecondLabel: UILabel!
    let colonSpacer: NSString = ":"
    let periodSpacer: NSString = "."
    
    var timeInCentiseconds: Double = 0
    var initialTime: Double = 0
    
    var delegate:CountdownTimerDelegate!
    
    var singleTapGesture: UITapGestureRecognizer!
    var doubleTapGesture: UITapGestureRecognizer!
    
    let activeColor: UIColor = UIColor.whiteColor()
    let InactiveColor: UIColor = UIColor.grayColor()
    
//    var delegate: CountdownTimerDelegate!
    
    var seconds: NSInteger {
        get {
            return Int(floor(self.timeInSeconds % 60))
        }
    }
    
    var minutes: NSInteger {
        get {
            return Int(floor(self.timeInSeconds / 60))
        }
    }
    
    var centiSeconds: Double {
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
            //self.updateTimer()
        }
    }
    
    var timer:NSTimer!
    var previousSecond:NSInteger = 0
    var previousMinute:NSInteger = 0
    
    init(frame: CGRect, seconds: NSInteger) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.blackColor()
        self.timeInSeconds = Double(seconds)

        self.initialTime = self.timeInCentiseconds
        
        self.setupView()
        self.setupGestures()
        
        self.updateTimer()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.minuteTableView = TimerTableView(rows: 100, frame: CGRectZero)
        self.minuteTableView.rowHeight = 90
        self.minuteTableView.valueType = TimeTableValueTypes.Minutes
        self.minuteTableView.timeTableDelegate = self
        self.minuteTableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.secondTableView = TimerTableView(rows: 60, frame: CGRectZero)
        self.secondTableView.rowHeight = 90
        self.secondTableView.valueType = TimeTableValueTypes.Seconds
        self.secondTableView.timeTableDelegate = self
        self.secondTableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.centisecondLabel = TimerLabel(frame: CGRectZero, timeNumber: 0)
        self.centisecondLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        var colonLabel: UILabel = UILabel()
        colonLabel.text = self.colonSpacer as String
        colonLabel.textColor = self.activeColor
        colonLabel.textAlignment = NSTextAlignment.Center
        colonLabel.font = UIFont.systemFontOfSize(30)
        colonLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        var periodLabel: UILabel = UILabel()
        periodLabel.text = self.periodSpacer as String
        periodLabel.textColor = UIColor.whiteColor()
        periodLabel.textAlignment = NSTextAlignment.Center
        periodLabel.font = UIFont.systemFontOfSize(30)
        periodLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        var periodContainer: UIView = UIView()
        periodContainer.setTranslatesAutoresizingMaskIntoConstraints(false)
        periodContainer.addSubview(periodLabel)
        
        self.addSubview(self.minuteTableView)
        self.addSubview(self.secondTableView)
        self.addSubview(self.centisecondLabel)
        self.addSubview(colonLabel)
        self.addSubview(periodContainer)
        var periodDictionary:NSDictionary = ["period": periodLabel]
        
        self.addConstraint(NSLayoutConstraint(item: periodLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: periodContainer, attribute: NSLayoutAttribute.CenterY, multiplier: 1.25, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: periodLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: periodContainer, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))

        self.addConstraint(NSLayoutConstraint(item: periodLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: periodContainer, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0))

        var viewDictionary: NSDictionary = ["minute": self.minuteTableView, "second": self.secondTableView, "centisecond": self.centisecondLabel, "colon": colonLabel, "period": periodContainer]
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[minute][colon][second][period][centisecond]|", options: nil, metrics: nil, views: viewDictionary as [NSObject : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[minute]|", options: nil, metrics: nil, views: viewDictionary as [NSObject : AnyObject]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[colon]|", options: nil, metrics: nil, views: viewDictionary as [NSObject : AnyObject]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[second]|", options: nil, metrics: nil, views: viewDictionary as [NSObject : AnyObject]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[period]|", options: nil, metrics: nil, views: viewDictionary as [NSObject : AnyObject]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[centisecond]|", options: nil, metrics: nil, views: viewDictionary as [NSObject : AnyObject]))
        
        self.addConstraint(NSLayoutConstraint(item: self.minuteTableView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.minuteTableView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 0.3, constant: 0))
        
        
        self.addConstraint(NSLayoutConstraint(item: colonLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: colonLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 0.05, constant: 0))
        

        self.addConstraint(NSLayoutConstraint(item: self.secondTableView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.secondTableView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 0.3, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: periodContainer, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: periodContainer, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 0.05, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: self.centisecondLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.centisecondLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 0.3, constant: 0))
        
        self.setNeedsLayout()
    }

    func setupGestures() {
        self.singleTapGesture = UITapGestureRecognizer(target: self, action: "didTapTimer")
        self.addGestureRecognizer(self.singleTapGesture)
        
        self.userInteractionEnabled = true
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
        }
    }
    
    func updateTimer() {
        if (self.minutes != self.previousMinute) {
            self.previousMinute = self.minutes
            self.minuteTableView.scrollToRow(self.minutes)
        }
        
        if (self.seconds != self.previousSecond) {
            self.previousSecond = self.seconds
            self.secondTableView.scrollToRow(self.seconds)
        }
        
        self.centisecondLabel.text = NSString(format:"%02.0f", self.centiSeconds) as String
    }
    
    func startTimer() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "tickTimer", userInfo: nil, repeats: true)
        self.delegate.timerDidStart()
    }
    
    func stopTimer() {
        if ((self.timer?.valid) != nil) {
            self.timer?.invalidate()
        }
        self.timer = nil
        self.delegate.timerDidStop()
    }
    
    func resetTimer() {
        self.stopTimer()
        self.timeInCentiseconds = self.initialTime
        self.updateTimer()
    }
    
    // MARK: - Gesture Methods
    
    func didTapTimer() {
        if (self.timer == nil) {
            self.startTimer()
            self.toggleTableViewInteractivity(false)
        } else {
            self.stopTimer()
            self.toggleTableViewInteractivity(true)
        }
    }
    
    
    func toggleTableViewInteractivity(state: Bool) {
        self.minuteTableView.userInteractionEnabled = state
        self.secondTableView.userInteractionEnabled = state
    }
    
    // MARK: - TimeTableDelegate Methods
    
    func timeTableDidUpdate(deltaCentiseconds: Double) {
        self.timeInCentiseconds += deltaCentiseconds
    }
}
