//
//  ViewController.swift
//  SlotMachine
//
//  Created by Dan Manteufel on 10/17/14.
//  Copyright (c) 2014 ManDevil Programming. All rights reserved.
//

import UIKit

//MARK: - View Controller Class
class ViewController: UIViewController {

    
    //MARK: Properties
    var firstContainer: UIView!
    var secondContainer: UIView!
    var thirdContainer: UIView!
    var fourthContainer: UIView!
    
    var titleLabel: UILabel!
    
    var creditsLabel: UILabel!
    var betLabel: UILabel!
    var winnerPaidLabel: UILabel!
    var creditsTitleLabel: UILabel!
    var betTitleLabel: UILabel!
    var winnerPaidTitleLabel: UILabel!
    
    var resetButton: UIButton!
    var betOneButton: UIButton!
    var betMaxButton: UIButton!
    var spinButton: UIButton!

    //MARK: Defines
    let kMarginForView: CGFloat = 10.0 //Float or double (32 or 64 bit core)
    let kMarginForSlot: CGFloat = 2.0
    let kEighth: CGFloat = 1.0 / 8.0
    let kSixth: CGFloat = 1.0 / 6.0
    let kThird: CGFloat = 1.0 / 3.0
    let kHalf: CGFloat = 1.0 / 2.0
    let kNumberOfContainers = 3
    let kNumberOfSlots = 3
    
    //MARK: Flow Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContainerViews()
        setupFirstContainer(firstContainer)
        setupSecondContainer(secondContainer)
        setupThirdContainer(thirdContainer)
        setupFourthContainer(fourthContainer)
    }
    
    func resetButtonPressed (button: UIButton) {
        println("Test Reset")
    }
    
    func betOneButtonPressed (button: UIButton) {
        println("Test Bet One")
    }
    
    func betMaxButtonPressed (button: UIButton) {
        println("Test Bet Max")
    }
    
    func spinButtonPressed (button: UIButton) {
        println("Test Spin")
    }
    
    //MARK: Helper Functions
    func setupContainerViews() {
        firstContainer = UIView(frame: CGRect(x: view.bounds.origin.x + kMarginForView,
                                              y: view.bounds.origin.y,
                                              width: view.bounds.width - (kMarginForView * 2),
                                              height: view.bounds.height * kSixth))
        firstContainer.backgroundColor = UIColor.redColor()
        view.addSubview(firstContainer)
        
        secondContainer = UIView(frame: CGRect(x: view.bounds.origin.x + kMarginForView,
                                               y: view.bounds.height * kSixth,
                                               width: view.bounds.width - (kMarginForView * 2),
                                               height: view.bounds.height * 3 * kSixth))
        secondContainer.backgroundColor = UIColor.blackColor()
        view.addSubview(secondContainer)
        
        thirdContainer = UIView(frame: CGRect(x: view.bounds.origin.x + kMarginForView,
                                              y: view.bounds.height * 4 * kSixth,
                                              width: view.bounds.width - (kMarginForView * 2),
                                              height: view.bounds.height * kSixth))
        thirdContainer.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(thirdContainer)
        
        fourthContainer = UIView(frame: CGRect(x: view.bounds.origin.x + kMarginForView,
                                               y: view.bounds.height * 5 * kSixth,
                                               width: view.bounds.width - (kMarginForView * 2),
                                               height: view.bounds.height * kSixth))
        fourthContainer.backgroundColor = UIColor.blackColor()
        view.addSubview(fourthContainer)
    }
    
    func setupFirstContainer (containerView: UIView) { //Global variable, so you don't really need to pass in
        titleLabel = UILabel()
        titleLabel.text = "Super Slots"
        titleLabel.textColor = UIColor.yellowColor()
        titleLabel.font = UIFont(name: "MarkerFelt-Wide",
                                 size: 40)
        titleLabel.sizeToFit()
        titleLabel.center = containerView.center
        containerView.addSubview(titleLabel)
    }
    
    func setupSecondContainer (containerView: UIView) {
        for containers in 0..<kNumberOfContainers {
            for slots in 0..<kNumberOfSlots {
                var slotImageView = UIImageView()
                slotImageView.backgroundColor = UIColor.yellowColor()
                slotImageView.frame = CGRect(x: containerView.bounds.origin.x +
                                                (containerView.bounds.size.width * CGFloat(containers) * kThird),
                                             y: containerView.bounds.origin.y +
                                                (containerView.bounds.size.height * CGFloat(slots) * kThird),
                                             width: containerView.bounds.width * kThird - kMarginForSlot,
                                             height: containerView.bounds.height * kThird - kMarginForSlot)
                containerView.addSubview(slotImageView)
            }
        }
    }
    
    func setupThirdContainer (containerView: UIView) {
        creditsLabel = UILabel()
        creditsLabel.text = "000000"
        setGenericVariableLabelAttributes(creditsLabel)
        creditsLabel.center = CGPoint(x: containerView.frame.width * kSixth,
                                      y: containerView.frame.height * kThird)
        containerView.addSubview(creditsLabel)
        
        betLabel = UILabel()
        betLabel.text = "0000"
        setGenericVariableLabelAttributes(betLabel)
        betLabel.center = CGPoint(x: containerView.frame.width * 3 * kSixth,
                                  y: containerView.frame.height * kThird)
        containerView.addSubview(betLabel)
        
        winnerPaidLabel = UILabel()
        winnerPaidLabel.text = "000000"
        setGenericVariableLabelAttributes(winnerPaidLabel)
        winnerPaidLabel.center = CGPoint(x: containerView.frame.width * 5 * kSixth,
                                         y: containerView.frame.height * kThird)
        containerView.addSubview(winnerPaidLabel)
        
        creditsTitleLabel = UILabel()
        creditsTitleLabel.text = "Credits"
        setGenericTitleLabelAttributes(creditsTitleLabel)
        creditsTitleLabel.center = CGPoint(x: containerView.frame.width * kSixth,
                                           y: containerView.frame.height * 2 * kThird)
        containerView.addSubview(creditsTitleLabel)
        
        betTitleLabel = UILabel()
        betTitleLabel.text = "Bet"
        setGenericTitleLabelAttributes(betTitleLabel)
        betTitleLabel.center = CGPoint(x: containerView.frame.width * 3 * kSixth,
                                       y: containerView.frame.height * 2 * kThird)
        containerView.addSubview(betTitleLabel)
        
        winnerPaidTitleLabel = UILabel()
        winnerPaidTitleLabel.text = "Winner Paid"
        setGenericTitleLabelAttributes(winnerPaidTitleLabel)
        winnerPaidTitleLabel.center = CGPoint(x: containerView.frame.width * 5 * kSixth,
                                              y: containerView.frame.height * 2 * kThird)
        containerView.addSubview(winnerPaidTitleLabel)
    }
    
    func setGenericVariableLabelAttributes (label: UILabel) {
        label.textColor = UIColor.redColor()
        label.font = UIFont(name: "Menlo-Bold",
            size: 16)
        label.sizeToFit()
        label.textAlignment = NSTextAlignment.Center
        label.backgroundColor = UIColor.darkGrayColor()
    }
    
    func setGenericTitleLabelAttributes (label: UILabel) {
        label.textColor = UIColor.blackColor()
        label.font = UIFont(name: "AmericanTypewriter",
            size: 14)
        label.sizeToFit()
    }
    
    func setupFourthContainer (containerView: UIView) {
        resetButton = UIButton()
        resetButton.setTitle("Reset",
                             forState: UIControlState.Normal)
        resetButton.setTitleColor(UIColor.blueColor(),
                                  forState: UIControlState.Normal)
        resetButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold",
                                              size: 12)
        resetButton.backgroundColor = UIColor.lightGrayColor()
        resetButton.sizeToFit()
        resetButton.center = CGPoint(x: containerView.frame.width * kEighth,
                                     y: containerView.frame.height * kHalf)
        resetButton.addTarget(self,
                              action: "resetButtonPressed:", //Don't miss the colon, specifying one or more parameters.
                              forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(resetButton)
        
        betOneButton = UIButton()
        betOneButton.setTitle("Bet One",
                              forState: UIControlState.Normal)
        betOneButton.setTitleColor(UIColor.blueColor(),
                                   forState: UIControlState.Normal)
        betOneButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold",
                                               size: 12)
        betOneButton.backgroundColor = UIColor.greenColor()
        betOneButton.sizeToFit()
        betOneButton.center = CGPoint(x: containerView.frame.width * 3 * kEighth,
                                      y: containerView.frame.height * kHalf)
        betOneButton.addTarget(self,
                               action: "betOneButtonPressed:",
                               forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(betOneButton)
        
        betMaxButton = UIButton()
        betMaxButton.setTitle("Bet Max",
                              forState: UIControlState.Normal)
        betMaxButton.setTitleColor(UIColor.blueColor(),
                                   forState: UIControlState.Normal)
        betMaxButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold",
                                               size: 12)
        betMaxButton.backgroundColor = UIColor.redColor()
        betMaxButton.sizeToFit()
        betMaxButton.center = CGPoint(x: containerView.frame.width * 5 * kEighth,
                                      y: containerView.frame.height * kHalf)
        betMaxButton.addTarget(self,
                               action: "betMaxButtonPressed:",
                               forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(betMaxButton)
        
        spinButton = UIButton()
        spinButton.setTitle("Spin",
                            forState: UIControlState.Normal)
        spinButton.setTitleColor(UIColor.blueColor(),
                                 forState: UIControlState.Normal)
        spinButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold",
                                             size: 12)
        spinButton.backgroundColor = UIColor.greenColor()
        spinButton.sizeToFit()
        spinButton.center = CGPoint(x: containerView.frame.width * 7 * kEighth,
                                    y: containerView.frame.height * kHalf)
        spinButton.addTarget(self,
                             action: "spinButtonPressed:",
                             forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(spinButton)
    }

}

