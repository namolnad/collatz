//
//  ViewController.swift
//  threeNPlusOne
//
//  Created by Daniel Loman on 4/11/16.
//  Copyright © 2016 Dan Loman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var input1: UITextField!
    @IBOutlet var input2: UITextField!
    @IBOutlet var storageSwitch: UISwitch!
    @IBOutlet var resultsLabel: UILabel!
    @IBOutlet var countingLabel: UILabel!
    
    let tester = TesterClass()
    var timer = NSTimer()
    var counter = 0.0


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.countingLabel.text = String(self.counter)
        self.storageSwitch.on = false
//        createTimer()
//        startTimer(){}

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func caculateButtonPressed(sender: UIButton) {
        resetTimer()
        createTimer()
        //                dispatch_async(dispatch_get_main_queue(), {
        self.startTimer() {
            let queue = NSOperationQueue()
            queue.qualityOfService = .UserInteractive
            
            let firstInt = Int(self.input1.text!)
            let secondInt = Int(self.input2.text!)
            
            let opBlock = NSBlockOperation {
                let results = self.getResults(firstInt!, secondInt: secondInt!)
                dispatch_async(dispatch_get_main_queue(), {
                    self.resultsLabel.text = "\(results.0) \(results.1) \(results.2)"
                })
            }
            queue.addOperation(opBlock)
        }
        //                })
        

    }
    
    
    func update(timerObj: NSTimer) {
        self.counter += 0.01
        self.countingLabel.text = String(format: "%.2f", self.counter)
    }
    
    func getResults(firstInt: Int, secondInt: Int) -> (Int, Int, Int) {
        let useStorageFlag = self.storageSwitch.on
        let results = self.tester.programmingTest(firstInt, secondInt: secondInt, useStorage: useStorageFlag) {
            ()->() in
            self.timer.invalidate()
        }

        return results
    }
    
    func resetTimer() {
        self.counter = 0
        self.countingLabel.text = String(self.counter)
        self.resultsLabel.text = "Results"
    }
    
    func createTimer() {
        let watch = NSTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.update(_:)), userInfo: nil, repeats: true)
        self.timer = watch

    }
    
    func startTimer(comp: ()->()) {
//        let timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("update:"), userInfo: nil, repeats: true)

//        timer.fire()
        NSRunLoop.mainRunLoop().addTimer(self.timer, forMode: NSDefaultRunLoopMode)
        comp()
    }

}

