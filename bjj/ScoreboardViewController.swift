//
//  ModalViewController.swift
//  bjj
//
//  Created by Kelvin Lau on 2015-02-21.
//  Copyright (c) 2015 Kelvin Lau. All rights reserved.
//

import UIKit

class ScoreboardViewController: UIViewController, CountdownTimerDelegate {

    var timer: CountdownTimerView!
    var timeLabel: UILabel!
    var redScoreboard: UIView!
    var labelColumn: UIView!
    var blueScoreboard: UIView!
    var scoreboardModel: ScoreboardModel!
    
    var redScore: UILabel!
    var redAdvantage: UILabel!
    var redPenalty: UILabel!

    var blueScore: UILabel!
    var blueAdvantage: UILabel!
    var bluePenalty: UILabel!
    
    var competitor1Label: UILabel!
    var competitor2Label: UILabel!
    
    let competitor1Default: NSString = "Competitor 1"
    let competitor2Default: NSString = "Competitor 2"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timer = CountdownTimerView(frame: CGRectZero, seconds: 300)
        self.timer.center.x = self.view.center.x
        self.timer.backgroundColor = UIColor.blackColor()
        self.timer.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.timer.delegate = self
        
        self.redScoreboard = UIView(frame: CGRectZero)
        self.redScoreboard.backgroundColor = UIColor.redColor()
        self.redScoreboard.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.blueScoreboard = UIView(frame: CGRectZero)
        self.blueScoreboard.backgroundColor = UIColor.blueColor()
        self.blueScoreboard.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.view.addSubview(self.redScoreboard)
        self.view.addSubview(self.blueScoreboard)
        self.view.addSubview(self.timer)
        
        if ((self.navigationController?.respondsToSelector("interactivePopGestureRecognizer")) != nil) {
            self.navigationController?.interactivePopGestureRecognizer.enabled = false;
        }
        
        self.scoreboardModel = ScoreboardModel()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = true
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        
        self.layoutScoreboard()
        self.layoutRedScoreboard()
        self.layoutBlueScoreboard()
        self.displaySetupDialog()

        self.view.layoutSubviews()
    }
        
    func layoutScoreboard() {
        self.view.addConstraint(NSLayoutConstraint(item: self.redScoreboard, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.redScoreboard, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier: 0.5, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.redScoreboard, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0))
        
        
        self.view.addConstraint(NSLayoutConstraint(item: self.blueScoreboard, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view,attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.blueScoreboard, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view,attribute: NSLayoutAttribute.Width, multiplier: 0.5, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.blueScoreboard, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view,attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.blueScoreboard, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view,attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0))
        
        
        self.view.addConstraint(NSLayoutConstraint(item: self.timer, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.timer, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier: 0.15, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.timer, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier: 0.75, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.timer, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0))
    }
    
    func layoutRedScoreboard() {
        var competitorLabel:ScoreboardLabel = ScoreboardLabel(frame: CGRectZero, text: "", fontSize: 80, textAlignment: NSTextAlignment.Center)
        competitorLabel.baselineAdjustment = UIBaselineAdjustment.AlignCenters
        self.redScoreboard.addSubview(competitorLabel)
        var competitorTapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "displaySetupDialog")
        competitorLabel.addGestureRecognizer(competitorTapGesture)

        self.competitor1Label = competitorLabel
        
        var pointsLabel: ScoreboardLabel = ScoreboardLabel(frame: CGRectZero, text: "00", fontSize: 200, textAlignment: NSTextAlignment.Left)
        self.redScoreboard.addSubview(pointsLabel)
        self.redScore = pointsLabel
        var scoreSwipeGesture:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "decrementRedScoreValue:")
        scoreSwipeGesture.direction = (UISwipeGestureRecognizerDirection.Left | UISwipeGestureRecognizerDirection.Right | UISwipeGestureRecognizerDirection.Down)
        var scoreTapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "incrementRedScoreValue:")
        scoreTapGesture.requireGestureRecognizerToFail(scoreSwipeGesture)
        self.redScore.addGestureRecognizer(scoreSwipeGesture)
        self.redScore.addGestureRecognizer(scoreTapGesture)
        
        var advantageLabel: ScoreboardLabel = ScoreboardLabel(frame: CGRectZero, text: "0", fontSize: 120, textAlignment: NSTextAlignment.Left)
        self.redScoreboard.addSubview(advantageLabel)
        self.redAdvantage = advantageLabel
        var advantageSwipeGesture:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "decrementRedAdvantageValue:")
        advantageSwipeGesture.direction = (UISwipeGestureRecognizerDirection.Left | UISwipeGestureRecognizerDirection.Right | UISwipeGestureRecognizerDirection.Down)
        var advantageTapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "incrementRedAdvantageValue:")
        advantageTapGesture.requireGestureRecognizerToFail(advantageSwipeGesture)
        self.redAdvantage.addGestureRecognizer(advantageSwipeGesture)
        self.redAdvantage.addGestureRecognizer(advantageTapGesture)
        
        var advantageTextLabel: ScoreboardLabel = ScoreboardLabel(frame: CGRectZero, text: "adv", fontSize: 30, textAlignment: NSTextAlignment.Left)
        self.redScoreboard.addSubview(advantageTextLabel)

        var penaltyLabel: ScoreboardLabel = ScoreboardLabel(frame: CGRectZero, text: "0", fontSize: 120, textAlignment: NSTextAlignment.Left)
        self.redScoreboard.addSubview(penaltyLabel)
        self.redPenalty = penaltyLabel
        var penaltySwipeGesture:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "decrementRedPenaltyValue:")
        penaltySwipeGesture.direction = (UISwipeGestureRecognizerDirection.Left | UISwipeGestureRecognizerDirection.Right | UISwipeGestureRecognizerDirection.Down)
        var penaltyTapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "incrementRedPenaltyValue:")
        penaltyTapGesture.requireGestureRecognizerToFail(penaltySwipeGesture)
        self.redPenalty.addGestureRecognizer(penaltySwipeGesture)
        self.redPenalty.addGestureRecognizer(penaltyTapGesture)
        
        var penaltyTextLabel: ScoreboardLabel = ScoreboardLabel(frame: CGRectZero, text: "pen", fontSize: 30, textAlignment: NSTextAlignment.Left)
        self.redScoreboard.addSubview(penaltyTextLabel)
        
        var timerPaddingView: UIView = UIView()
        timerPaddingView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.redScoreboard.addSubview(timerPaddingView)
        
        var textSpacerView: UIView = UIView()
        self.redScoreboard.addSubview(textSpacerView)
        textSpacerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        
        var viewDictionary: NSDictionary = ["competitorLabel": competitorLabel, "pointsLabel": pointsLabel, "advantageLabel": advantageLabel, "advantageTextLabel": advantageTextLabel, "penaltyLabel": penaltyLabel, "penaltyTextLabel": penaltyTextLabel, "timerPaddingView": timerPaddingView, "textSpacerView": textSpacerView]
        var metricsDictionary: NSDictionary = ["topPadding": self.view.bounds.height*0.1, "spacing": 20]

        self.redScoreboard.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[competitorLabel]-|", options: nil, metrics: metricsDictionary as [NSObject : AnyObject], views: viewDictionary as [NSObject : AnyObject]))
        self.redScoreboard.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-spacing-[pointsLabel]-|", options: nil, metrics: metricsDictionary as [NSObject : AnyObject], views: viewDictionary as [NSObject : AnyObject]))
        self.redScoreboard.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-spacing-[advantageLabel]", options: nil, metrics: metricsDictionary as [NSObject : AnyObject], views: viewDictionary as [NSObject : AnyObject]))
        self.redScoreboard.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[advantageTextLabel]", options: nil, metrics: metricsDictionary as [NSObject : AnyObject], views: viewDictionary as [NSObject : AnyObject]))
        self.redScoreboard.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-spacing-[penaltyLabel]", options: nil, metrics: metricsDictionary as [NSObject : AnyObject], views: viewDictionary as [NSObject : AnyObject]))
        self.redScoreboard.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[penaltyTextLabel]", options: nil, metrics: metricsDictionary as [NSObject : AnyObject], views: viewDictionary as [NSObject : AnyObject]))
        
        self.redScoreboard.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-spacing-[competitorLabel][pointsLabel]-[advantageLabel][advantageTextLabel]-[penaltyLabel][penaltyTextLabel]-spacing-[timerPaddingView]|", options: nil, metrics: metricsDictionary as [NSObject : AnyObject], views: viewDictionary as [NSObject : AnyObject]))
        
        self.redScoreboard.addConstraint(NSLayoutConstraint(item: competitorLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: pointsLabel, attribute: NSLayoutAttribute.Height, multiplier: 0.5, constant: 0))
        
        self.redScoreboard.addConstraint(NSLayoutConstraint(item: advantageLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: pointsLabel, attribute: NSLayoutAttribute.Height, multiplier: 0.9, constant: 0))

        self.redScoreboard.addConstraint(NSLayoutConstraint(item: penaltyLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: advantageLabel, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0))

        self.redScoreboard.addConstraint(NSLayoutConstraint(item: advantageTextLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: advantageLabel, attribute: NSLayoutAttribute.Height, multiplier: 0.2, constant: 0))

        self.redScoreboard.addConstraint(NSLayoutConstraint(item: penaltyTextLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: penaltyLabel, attribute: NSLayoutAttribute.Height, multiplier: 0.2, constant: 0))

        
        self.view.addConstraint(NSLayoutConstraint(item: timerPaddingView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.timer, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0))
    }
    
    func layoutBlueScoreboard() {
        
        var competitorLabel:ScoreboardLabel = ScoreboardLabel(frame: CGRectZero, text:"", fontSize: 80, textAlignment: NSTextAlignment.Center)
        self.blueScoreboard.addSubview(competitorLabel)
        var competitorTapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "displaySetupDialog")
        competitorLabel.addGestureRecognizer(competitorTapGesture)

        self.competitor2Label = competitorLabel
        
        var pointsLabel: ScoreboardLabel = ScoreboardLabel(frame: CGRectZero, text: "00", fontSize: 200, textAlignment: NSTextAlignment.Right)
        self.blueScoreboard.addSubview(pointsLabel)
        self.blueScore = pointsLabel
        var scoreSwipeGesture:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "decrementBlueScoreValue:")
        scoreSwipeGesture.direction = (UISwipeGestureRecognizerDirection.Left | UISwipeGestureRecognizerDirection.Right | UISwipeGestureRecognizerDirection.Down)
        var scoreTapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "incrementBlueScoreValue:")
        scoreTapGesture.requireGestureRecognizerToFail(scoreSwipeGesture)
        self.blueScore.addGestureRecognizer(scoreSwipeGesture)
        self.blueScore.addGestureRecognizer(scoreTapGesture)
        
        var advantageLabel: ScoreboardLabel = ScoreboardLabel(frame: CGRectZero, text: "0", fontSize: 120, textAlignment: NSTextAlignment.Right)
        self.blueScoreboard.addSubview(advantageLabel)
        self.blueAdvantage = advantageLabel
        var advantageSwipeGesture:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "decrementBlueAdvantageValue:")
        advantageSwipeGesture.direction = (UISwipeGestureRecognizerDirection.Left | UISwipeGestureRecognizerDirection.Right | UISwipeGestureRecognizerDirection.Down)
        var advantageTapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "incrementBlueAdvantageValue:")
        advantageTapGesture.requireGestureRecognizerToFail(advantageSwipeGesture)
        self.blueAdvantage.addGestureRecognizer(advantageSwipeGesture)
        self.blueAdvantage.addGestureRecognizer(advantageTapGesture)
        
        var advantageTextLabel: ScoreboardLabel = ScoreboardLabel(frame: CGRectZero, text: "adv", fontSize: 30, textAlignment: NSTextAlignment.Right)
        self.blueScoreboard.addSubview(advantageTextLabel)
        
        var penaltyLabel: ScoreboardLabel = ScoreboardLabel(frame: CGRectZero, text: "0", fontSize: 120, textAlignment: NSTextAlignment.Right)
        self.blueScoreboard.addSubview(penaltyLabel)
        self.bluePenalty = penaltyLabel
        var penaltySwipeGesture:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "decrementBluePenaltyValue:")
        penaltySwipeGesture.direction = (UISwipeGestureRecognizerDirection.Left | UISwipeGestureRecognizerDirection.Right | UISwipeGestureRecognizerDirection.Down)
        var penaltyTapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "incrementBluePenaltyValue:")
        penaltyTapGesture.requireGestureRecognizerToFail(penaltySwipeGesture)
        self.bluePenalty.addGestureRecognizer(penaltySwipeGesture)
        self.bluePenalty.addGestureRecognizer(penaltyTapGesture)

        
        var penaltyTextLabel: ScoreboardLabel = ScoreboardLabel(frame: CGRectZero, text: "pen", fontSize: 30, textAlignment: NSTextAlignment.Right)
        self.blueScoreboard.addSubview(penaltyTextLabel)
        
        var timerPaddingView: UIView = UIView()
        timerPaddingView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.blueScoreboard.addSubview(timerPaddingView)
        
        var textSpacerView: UIView = UIView()
        self.blueScoreboard.addSubview(textSpacerView)
        textSpacerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        
        var viewDictionary: NSDictionary = ["competitorLabel": competitorLabel, "pointsLabel": pointsLabel, "advantageLabel": advantageLabel, "advantageTextLabel": advantageTextLabel, "penaltyLabel": penaltyLabel, "penaltyTextLabel": penaltyTextLabel, "timerPaddingView": timerPaddingView, "textSpacerView": textSpacerView]
        var metricsDictionary: NSDictionary = ["topPadding": self.view.bounds.height*0.1, "spacing": 20]
        
        self.blueScoreboard.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[competitorLabel]-|", options: nil, metrics: metricsDictionary as [NSObject : AnyObject], views: viewDictionary as [NSObject : AnyObject]))
        self.blueScoreboard.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[pointsLabel]-spacing-|", options: nil, metrics: metricsDictionary as [NSObject : AnyObject], views: viewDictionary as [NSObject : AnyObject]))
        self.blueScoreboard.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[advantageLabel]-spacing-|", options: nil, metrics: metricsDictionary as [NSObject : AnyObject], views: viewDictionary as [NSObject : AnyObject]))
        self.blueScoreboard.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[advantageTextLabel]-|", options: nil, metrics: metricsDictionary as [NSObject : AnyObject], views: viewDictionary as [NSObject : AnyObject]))
        self.blueScoreboard.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[penaltyLabel]-spacing-|", options: nil, metrics: metricsDictionary as [NSObject : AnyObject], views: viewDictionary as [NSObject : AnyObject]))
        self.blueScoreboard.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[penaltyTextLabel]-|", options: nil, metrics: metricsDictionary as [NSObject : AnyObject], views: viewDictionary as [NSObject : AnyObject]))
        
        self.blueScoreboard.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-spacing-[competitorLabel][pointsLabel]-[advantageLabel][advantageTextLabel]-[penaltyLabel][penaltyTextLabel]-spacing-[timerPaddingView]|", options: nil, metrics: metricsDictionary as [NSObject : AnyObject], views: viewDictionary as [NSObject : AnyObject]))
        
        self.blueScoreboard.addConstraint(NSLayoutConstraint(item: competitorLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: pointsLabel, attribute: NSLayoutAttribute.Height, multiplier: 0.5, constant: 0))
        
        self.blueScoreboard.addConstraint(NSLayoutConstraint(item: advantageLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: pointsLabel, attribute: NSLayoutAttribute.Height, multiplier: 0.9, constant: 0))
        
        self.blueScoreboard.addConstraint(NSLayoutConstraint(item: penaltyLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: advantageLabel, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0))
        
        self.blueScoreboard.addConstraint(NSLayoutConstraint(item: advantageTextLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: advantageLabel, attribute: NSLayoutAttribute.Height, multiplier: 0.2, constant: 0))
        
        self.blueScoreboard.addConstraint(NSLayoutConstraint(item: penaltyTextLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: penaltyLabel, attribute: NSLayoutAttribute.Height, multiplier: 0.2, constant: 0))
        
        
        self.view.addConstraint(NSLayoutConstraint(item: timerPaddingView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.timer, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0))
    }
    
    func layoutTimer() {

        self.timer.addSubview(timeLabel)
        
        self.timer.addConstraint(NSLayoutConstraint(item: self.timeLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.timer, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0))
        
        self.timer.addConstraint(NSLayoutConstraint(item: self.timeLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.timer, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0))
        
        self.timer.addConstraint(NSLayoutConstraint(item: self.timeLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.timer, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0))
        
        self.timer.addConstraint(NSLayoutConstraint(item: self.timeLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.timer, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
    }
    
    // MARK: - UIGestureRecognizer Methods
    // I am not proud of this.
    
    func incrementRedScoreValue(sender: UITapGestureRecognizer) {
        self.scoreboardModel.redScore++
        self.updateScoreboard()
    }
    
    func incrementRedAdvantageValue(sender: UITapGestureRecognizer) {
        self.scoreboardModel.redAdvantage++
        self.updateScoreboard()
    }
    
    func incrementRedPenaltyValue(sender: UITapGestureRecognizer) {
        self.scoreboardModel.redPenalty++
        self.updateScoreboard()
    }
    
    func incrementBlueScoreValue(sender: UITapGestureRecognizer) {
        self.scoreboardModel.blueScore++
        self.updateScoreboard()
    }
    
    func incrementBlueAdvantageValue(sender: UITapGestureRecognizer) {
        self.scoreboardModel.blueAdvantage++
        self.updateScoreboard()
    }
    
    func incrementBluePenaltyValue(sender: UITapGestureRecognizer) {
        self.scoreboardModel.bluePenalty++
        self.updateScoreboard()
    }
    
    func decrementRedScoreValue(sender: UISwipeGestureRecognizer) {
        if (self.scoreboardModel.redScore > 0) {
            self.scoreboardModel.redScore--
        }
        self.updateScoreboard()
    }
    
    func decrementRedAdvantageValue(sender: UISwipeGestureRecognizer) {
        if (self.scoreboardModel.redAdvantage > 0) {
            self.scoreboardModel.redAdvantage--
        }
        self.updateScoreboard()
    }
    
    func decrementRedPenaltyValue(sender: UISwipeGestureRecognizer) {
        if (self.scoreboardModel.redPenalty > 0) {
            self.scoreboardModel.redPenalty--
        }
        self.updateScoreboard()
    }
    
    func decrementBlueScoreValue(sender: UISwipeGestureRecognizer) {
        if (self.scoreboardModel.blueScore > 0) {
            self.scoreboardModel.blueScore--
        }
        self.updateScoreboard()
    }
    
    func decrementBlueAdvantageValue(sender: UISwipeGestureRecognizer) {
        if (self.scoreboardModel.blueAdvantage > 0) {
            self.scoreboardModel.blueAdvantage--
        }
        self.updateScoreboard()
    }
    
    func decrementBluePenaltyValue(sender: UISwipeGestureRecognizer) {
        if (self.scoreboardModel.bluePenalty > 0) {
            self.scoreboardModel.bluePenalty--
        }
        self.updateScoreboard()
    }
    
    // MARK: - CountdownTimerDelegate Methods
    
    func timerDidFinish() {
    }
    
    func timerDidStop() {
    }
    
    func timerDidStart() {
    }
    
    // MARK: - Convenience Methods
    
    func updateScoreboard() {
        self.redScore.text = NSString(format:"%02d", self.scoreboardModel.redScore) as String
        self.redAdvantage.text = NSString(format:"%d", self.scoreboardModel.redAdvantage) as String
        self.redPenalty.text = NSString(format:"%d", self.scoreboardModel.redPenalty) as String

        self.blueScore.text = NSString(format:"%02d", self.scoreboardModel.blueScore) as String
        self.blueAdvantage.text = NSString(format:"%d", self.scoreboardModel.blueAdvantage) as String
        self.bluePenalty.text = NSString(format:"%d", self.scoreboardModel.bluePenalty) as String
    }
    
    func displaySetupDialog() {
        var setupDialog:UIAlertController = UIAlertController(title: nil, message: "Match Setup", preferredStyle: UIAlertControllerStyle.Alert)
        
        setupDialog.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Competitor 1's Name"
            if (self.competitor1Label.text != self.competitor1Default) {
                textField.text = self.competitor1Label.text
            }
        }
        
        setupDialog.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Competitor 2's Name"
            if (self.competitor2Label.text != self.competitor2Default) {
                textField.text = self.competitor2Label.text
            }
        }

        var confirmAction:UIAlertAction = UIAlertAction(title: "Start", style: UIAlertActionStyle.Cancel) { (alertAction: UIAlertAction!) -> Void in
            let competitor1TextField = setupDialog.textFields![0] as! UITextField
            let competitor2TextField = setupDialog.textFields![1] as! UITextField
            self.updateCompetitorNames(competitor1TextField.text, competitor2Name: competitor2TextField.text)
        }
        
        setupDialog.addAction(confirmAction)
        
        self.presentViewController(setupDialog, animated:true, completion:nil)
    }
    
    func updateCompetitorNames(competitor1Name: NSString?, competitor2Name: NSString?) {
        if (competitor1Name != nil && competitor1Name!.length > 0) {
            self.competitor1Label.text = competitor1Name as? String
        } else {
            self.competitor1Label.text = self.competitor1Default as String
        }
        if (competitor2Name != nil && competitor2Name!.length > 0) {
            self.competitor2Label.text = competitor2Name as? String
        } else {
            self.competitor2Label.text = self.competitor2Default as String
        }

    }
}
