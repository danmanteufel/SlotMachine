//
//  ViewController.swift
//  SlotMachine
//
//  Created by Dan Manteufel on 10/17/14.
//  Copyright (c) 2014 ManDevil Programming. All rights reserved.
//

import UIKit

//MARK: - View Controller
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
    
    var slots:[[Slot]] = []//Should be in model?
    
    var credits = 0//Should be in model?
    var currentBet = 0//Should be in model?
    var winnings = 0//Should be in model?

    //MARK: Defines
    let kMarginForView: CGFloat = 10.0 //Float or double (32 or 64 bit core)
    let kMarginForSlot: CGFloat = 2.0
    let kNumberOfContainers = 3//Can't really change due to logic
    let kNumberOfSlots = 3//Can't really change due to logic
    let kDefaultCredits = 50
    let kMaxBet = 5
    
    let kEighth: CGFloat = 1.0 / 8.0
    let kSixth: CGFloat = 1.0 / 6.0
    let kThird: CGFloat = 1.0 / 3.0
    let kHalf: CGFloat = 1.0 / 2.0
    
    //MARK: Flow Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContainerViews()
        setupFirstContainer(firstContainer)
        setupThirdContainer(thirdContainer)
        setupFourthContainer(fourthContainer)
        hardReset()
    }
    
    func resetButtonPressed (button: UIButton) {
        println("Test Reset")
        hardReset()
    }
    
    func betOneButtonPressed (button: UIButton) { //IS THIS REALLY MODEL LOGIC?
        println("Test Bet One")
        if credits <= 0 { //SWITCH STATEMENT WITH UNDERSCORES????
            showAlertWithText(header: "No More Credits",
                              message: "Reset Game")
        } else {
            if currentBet < kMaxBet {
                currentBet++
                credits--
                updateMainView()
            } else {
                showAlertWithText(message: "You can only bet 5 credits at a time")
            }
        }
    }
    
    func betMaxButtonPressed (button: UIButton) {
        println("Test Bet Max")
        if credits <= kMaxBet {
            showAlertWithText(header: "Not enough credits",
                              message: "Bet less")
        } else {
            if currentBet < kMaxBet {
                var creditsToBetMax = kMaxBet - currentBet
                credits -= creditsToBetMax
                currentBet += creditsToBetMax
                updateMainView()
            } else {
                showAlertWithText(message: "You can only bet 5 credits at a time!")
            }
        }
    }
    
    func spinButtonPressed (button: UIButton) {
        println("Test Spin")
        removeSlotImageViews()
        slots = Factory.createSlots(kNumberOfSlots, numberOfContainers: kNumberOfContainers)
        setupSecondContainer(secondContainer)
        
        winnings = currentBet * SlotBrain.computeWinnings(slots)
        credits += winnings
        currentBet = 0
        updateMainView()
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
        for containerNumber in 0..<kNumberOfContainers {
            for slotNumber in 0..<kNumberOfSlots {
                var slot:Slot
                var slotImageView = UIImageView()
                
                if slots.count != 0 {
                    let slotContainer = slots[containerNumber]
                    slot = slotContainer[slotNumber]
                    slotImageView.image = UIImage(named: slot.imageName)
                } else {
                    slotImageView.image = nil
                }
                
                slotImageView.backgroundColor = UIColor.yellowColor()
                slotImageView.frame = CGRect(x: containerView.bounds.origin.x +
                                                (containerView.bounds.size.width * CGFloat(containerNumber) * kThird),
                                             y: containerView.bounds.origin.y +
                                                (containerView.bounds.size.height * CGFloat(slotNumber) * kThird),
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
    
    func removeSlotImageViews() {
        //let container: UIView? = secondContainer
        let subViews: Array? = secondContainer!.subviews
        for view in subViews! {
            view.removeFromSuperview()
        }
    }
    
    func hardReset() {
        removeSlotImageViews()
        slots.removeAll(keepCapacity: true)//Know size of slots
        setupSecondContainer(secondContainer)
        credits = kDefaultCredits
        winnings = 0
        currentBet = 0
        updateMainView()
    }
    
    func updateMainView() {
        creditsLabel.text = "\(credits)"
        betLabel.text = "\(currentBet)"
        winnerPaidLabel.text = "\(winnings)"
    }
    
    func showAlertWithText(header: String = "Warning",  //Modular to support any number of alerts
                           message: String) {//Warning is default
        var alert = UIAlertController(title: header,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: UIAlertActionStyle.Default,
                                      handler: nil))
        presentViewController(alert,
                              animated: true,
                              completion: nil)
    }
}

//MARK: - Model (NO UI ELEMENTS HERE!!!!)
//MARK: - Defines
let kFlushWinnings = 1
let kRoyalFlushWinnings = 15
let kStraightWinnings = 1
let kEpicStraightWinnings = 1000
let kThreeOfAKindWinnings = 3
let kThreesAllAroundWinnings = 50

//MARK:  Structs
struct Slot {
    
    var value = 0
    var imageName = "Ace"
    var red = true
    var isRed: Bool {return red}
    var description: String {return "\(value),"+imageName+",\(isRed)"}
}

//MARK:  Classes
class Factory { //Factory is a design pattern (look it up)
    
    class func createSlots(numberOfSlots: Int, numberOfContainers: Int) -> [[Slot]] { //Class function = (+) function
        var slots: [[Slot]] = []
        
        for container in 0..<numberOfContainers {
            var slotArray:[Slot] = []
            for slot in 0..<numberOfSlots {
                slotArray.append(Factory.createSlot(slotArray))//Don't need the Factory. because inside the class
            }
            slots.append(slotArray)
        }
        
        return slots
    }
    
    class func createSlot(currentCards: [Slot]) -> Slot {
        var currentCardValues:[Int] = []
        for slot in currentCards {
            currentCardValues.append(slot.value)
        }
        
        var randomNumber = Int(arc4random_uniform(UInt32(13)))
        while contains(currentCardValues, randomNumber + 1) {
            randomNumber = Int(arc4random_uniform(UInt32(13)))
        }
        
        var slot = Slot(value: 0, imageName: "", red: true)
        switch randomNumber {
        case 0:
            slot.value = 1
            slot.imageName = "Ace"
        case 1:
            slot.value = 2
            slot.imageName = "Two"
        case 2:
            slot.value = 3
            slot.imageName = "Three"
        case 3:
            slot.value = 4
            slot.imageName = "Four"
        case 4:
            slot.value = 5
            slot.imageName = "Five"
            slot.red = false
        case 5:
            slot.value = 6
            slot.imageName = "Six"
            slot.red = false
        case 6:
            slot.value = 7
            slot.imageName = "Seven"
        case 7:
            slot.value = 8
            slot.imageName = "Eight"
            slot.red = false
        case 8:
            slot.value = 9
            slot.imageName = "Nine"
            slot.red = false
        case 9:
            slot.value = 10
            slot.imageName = "Ten"
        case 10:
            slot.value = 11
            slot.imageName = "Jack"
            slot.red = false
        case 11:
            slot.value = 12
            slot.imageName = "Queen"
            slot.red = false
        case 12:
            slot.value = 13
            slot.imageName = "King"
        default:
            slot.value = 0
            slot.imageName = ""
        }
        return slot
    }
}

class SlotBrain {
    
    class func unpackSlotsIntoSlotRows(slots: [[Slot]]) -> [[Slot]] {
        var slotRow1: [Slot] = []
        var slotRow2: [Slot] = []
        var slotRow3: [Slot] = []
        
        for slotArray in slots {
            for index in 0..<slotArray.count {
                let slot = slotArray[index]
                switch index {
                case 0:
                    slotRow1.append(slot)
                case 1:
                    slotRow2.append(slot)
                case 2:
                    slotRow3.append(slot)
                default:
                    println("Error")
                }
            }
        }
        return [slotRow1, slotRow2, slotRow3]
    }
    
    class func computeWinnings(slots: [[Slot]]) -> Int {
        var slotsInRows = unpackSlotsIntoSlotRows(slots)
        var winnings = 0
        
        var flushWinCount = 0
        var straightWinCount = 0
        var threeOfAKindWinCount = 0
        
        for slotRow in slotsInRows {
            if checkFlush(slotRow) {
                println("flush")
                winnings += kFlushWinnings
                flushWinCount++
            }
            if checkStraight(slotRow) {
                println("three in a row")
                winnings += kStraightWinnings
                straightWinCount++
            }
            if checkThreeOfAKind(slotRow) {
                println("three of a kind")
                winnings += kThreeOfAKindWinnings
                threeOfAKindWinCount++
            }
        }
        
        if flushWinCount == 3 {
            println("Royal Flush")
            winnings += kRoyalFlushWinnings
        }
        if straightWinCount == 3 {
            println("Epic Straight")
            winnings += kEpicStraightWinnings
        }
        if threeOfAKindWinCount == 3 {
            println("Threes All Around")
            winnings += kThreesAllAroundWinnings
        }
        
        return winnings
    }
    
    class func checkFlush(slotRow: [Slot]) -> Bool {
        return slotRow[0].isRed && slotRow[1].isRed && slotRow[2].isRed ||
               !slotRow[0].isRed && !slotRow[1].isRed && !slotRow[2].isRed
    }
    
    class func checkStraight(slotRow: [Slot]) -> Bool {
        return slotRow[0].value == slotRow[1].value + 1 && slotRow[0].value == slotRow[2].value + 2 ||
               slotRow[0].value == slotRow[1].value - 1 && slotRow[0].value == slotRow[2].value - 2
    }
    
    class func checkThreeOfAKind(slotRow: [Slot]) -> Bool {
        return slotRow[0].value == slotRow[1].value && slotRow[0].value == slotRow[2].value
    }
}