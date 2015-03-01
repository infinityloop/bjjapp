//
//  ModalViewController.swift
//  bjj
//
//  Created by Kelvin Lau on 2015-02-21.
//  Copyright (c) 2015 Kelvin Lau. All rights reserved.
//

import UIKit

class ScoreboardViewController: UIViewController, countdownTimerDelegate {

    var timer: UIView!
    var timeLabel: UILabel!
    var redScoreboard: UIView!
    var blueScoreboard: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.timer = UIView(frame: CGRectMake(0, self.view.bounds.height - 75, 200, 75))
        self.timer = UIView(frame: CGRectZero)
        self.timer.center.x = self.view.center.x
        self.timer.backgroundColor = UIColor.blackColor()
        self.timer.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        //self.redScoreboard = UIView(frame: CGRectMake(0, 0, self.view.bounds.width/2, self.view.bounds.height))
        self.redScoreboard = UIView(frame: CGRectZero)

        self.redScoreboard.backgroundColor = UIColor.redColor()
        self.redScoreboard.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.layoutRedScoreboard()
        
        //self.blueScoreboard = UIView(frame: CGRectMake(self.view.bounds.width/2, 0, self.view.bounds.width/2, self.view.bounds.height))
        self.blueScoreboard = UIView(frame: CGRectZero)

        self.blueScoreboard.backgroundColor = UIColor.blueColor()
        self.blueScoreboard.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.view.addSubview(self.redScoreboard)
        self.view.addSubview(self.blueScoreboard)
        self.view.addSubview(self.timer)
        
//        var viewDictionary: NSDictionary = ["redScoreboard" : self.redScoreboard, "blueScoreboard" : self.blueScoreboard, "timer" : self.timer]
//        var metricDictionary: NSDictionary = ["quarterPadding": self.view.bounds.width/4]
//        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[redScoreboard]-quarterPadding-[timer]-quarterPadding-[blueScoreboard]", options: nil, metrics: metricDictionary, views: viewDictionary))
//        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[redScoreboard][timer]", options: nil, metrics: metricDictionary, views: viewDictionary))
//        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[blueScoreboard][timer]", options: nil, metrics: metricDictionary, views: viewDictionary))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.redScoreboard, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.redScoreboard, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier: 0.5, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.redScoreboard, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.redScoreboard, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.blueScoreboard, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view,attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.blueScoreboard, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view,attribute: NSLayoutAttribute.Width, multiplier: 0.5, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.blueScoreboard, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view,attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.blueScoreboard, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view,attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0))

        
        self.view.addConstraint(NSLayoutConstraint(item: self.timer, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))

        self.view.addConstraint(NSLayoutConstraint(item: self.timer, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier: 0.15, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.timer, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier: 0.75, constant: 0))

        self.view.addConstraint(NSLayoutConstraint(item: self.timer, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.timer, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 0.8, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.timer, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 0.8, constant: 0))


        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.layoutTimer()
        //self.view.layoutSubviews()
    }
    
    
    func layoutRedScoreboard() {
        var pointsLabel: UILabel = UILabel(frame: CGRectMake(10, 10, 40, 40))
        pointsLabel.text = "0"
        pointsLabel.textColor = UIColor.whiteColor()
        pointsLabel.textAlignment = NSTextAlignment.Left
        pointsLabel.sizeToFit()
        self.redScoreboard.addSubview(pointsLabel)
//        pointsLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        var pointsTextLabel: UILabel = UILabel(frame: CGRectMake(30, 30, 40, 40))
        pointsTextLabel.text = "pts"
        pointsTextLabel.textColor = UIColor.whiteColor()
        pointsTextLabel.sizeToFit()
        self.redScoreboard.addSubview(pointsTextLabel)
//        pointsTextLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
//        var viewDictionary: NSDictionary = ["pointsLabel": pointsLabel, "pointsTextLabel": pointsTextLabel]
//        
//        self.redScoreboard.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[pointsLabel][pointsTextLabel]-|", options: nil, metrics: nil, views: viewDictionary))
//        self.redScoreboard.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[pointsLabel]-|", options: nil, metrics: nil, views: viewDictionary))
//        self.redScoreboard.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[pointsTextLabel]-|", options: nil, metrics: nil, views: viewDictionary))
//        
    }
    
    func layoutBlueScoreboard() {
        
    }
    
    func layoutTimer() {
        var timeLabel: CountdownTimerLabel = CountdownTimerLabel(frame: CGRectZero, seconds: 1800)

        timeLabel.delegate = self
        timeLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.timeLabel = timeLabel
        self.view.bringSubviewToFront(self.timeLabel)
        self.timer.addSubview(timeLabel)
        
        
//        var viewDictionary: NSDictionary = ["timeLabel" : self.timeLabel]
//        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[timeLabel]", options: nil, metrics: nil, views: viewDictionary))
//        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[timeLabel]", options: nil, metrics: nil, views: viewDictionary))
        
//        
//        self.timer.addConstraint(NSLayoutConstraint(item: self.timeLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.timer, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0))
//        
//        self.timer.addConstraint(NSLayoutConstraint(item: self.timeLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.timer, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0.0))
//
//        self.timer.addConstraint(NSLayoutConstraint(item: self.timeLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.timer, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0))
//        
//        self.timer.addConstraint(NSLayoutConstraint(item: self.timeLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.timer, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0))
        
        self.timer.addConstraint(NSLayoutConstraint(item: self.timeLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.timer, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0))

        self.timer.addConstraint(NSLayoutConstraint(item: self.timeLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.timer, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        
        self.timer.addConstraint(NSLayoutConstraint(item: self.timeLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.timer, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0))
    }
    
    // MARK: - CountdownTimerDelegate Methods
    
    func timerDidFinish(label: UILabel) {
        self.showNavigationBar()
    }
    
    func timerDidStop(label: UILabel) {
        self.showNavigationBar()
    }
    
    func timerDidStart(label: UILabel) {
        self.hideNavigationBar()
    }
    
    // MARK: - Convenience Methods
    
    func hideNavigationBar() {
        self.navigationController?.navigationBarHidden = true
    }
    
    func showNavigationBar() {
        self.navigationController?.navigationBarHidden = false
    }
}
