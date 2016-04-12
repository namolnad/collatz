//
//  TesterClass.swift
//  threeNPlusOne
//
//  Created by Daniel Loman on 4/11/16.
//  Copyright © 2016 Dan Loman. All rights reserved.
//

import Foundation
import UIKit

class TesterClass {
    var array: [[[[[[[[[[[[Int:Int]]]]]]]]]]]]?
    
    init() {
        //        self.array = [[[[[[Int:Int]]]]]]()
        self.array = arrayForHundredBillionValues()
    }
    
    
    func arrayForOneHundredValues() -> ([[[Int:Int]]]) {
        let dictionary = [Int: Int]()
        var subArray = [dictionary]
        for _ in 1..<10 {
            subArray.append(dictionary)
        }
        var oneHundredContainer = [subArray]
        for _ in 1..<10 {
            oneHundredContainer.append(subArray)
        }
        return oneHundredContainer
    }
    
    func arrayForOneThousandValues() -> ([[[[Int:Int]]]]) {
        let subArray = arrayForOneHundredValues()
        var oneThousandContainer = [subArray]
        for _ in 1..<10 {
            oneThousandContainer.append(subArray)
        }
        return oneThousandContainer
    }
    
    func arrayForTenThousandValues() -> ([[[[[Int:Int]]]]]) {
        let subArray = arrayForOneThousandValues()
        var tenThousandContainer = [subArray]
        for _ in 1..<10 {
            tenThousandContainer.append(subArray)
        }
        return tenThousandContainer
    }
    
    func arrayForHundredThousandValues() -> ([[[[[[Int:Int]]]]]]) {
        
        let subArray = arrayForTenThousandValues()
        var hundredThousandContainer = [subArray]
        for _ in 1..<10 {
            hundredThousandContainer.append(subArray)
        }
        return hundredThousandContainer
    }
    
    func arrayForOneMillionValues() -> ([[[[[[[Int:Int]]]]]]]) {
        let subArray = arrayForHundredThousandValues()
        var millionContainer = [subArray]
        for _ in 1..<10 {
            millionContainer.append(subArray)
        }
        return millionContainer
    }
    
    func arrayForTenMillionValues() -> ([[[[[[[[Int:Int]]]]]]]]) {
        let subArray = arrayForOneMillionValues()
        var tenMillionContainer = [subArray]
        for _ in 1..<10 {
            tenMillionContainer.append(subArray)
        }
        return tenMillionContainer
    }
    
    func arrayForOneHundredMillionValues() -> ([[[[[[[[[Int:Int]]]]]]]]]) {
        let subArray = arrayForTenMillionValues()
        var millionContainer = [subArray]
        for _ in 1..<10 {
            millionContainer.append(subArray)
        }
        return millionContainer
    }
    
    func arrayForOneBillionValues() -> ([[[[[[[[[[Int:Int]]]]]]]]]]) {
        let subArray = arrayForOneHundredMillionValues()
        var billionContainer = [subArray]
        for _ in 1..<10 {
            billionContainer.append(subArray)
        }
        return billionContainer
    }
    
    func arrayForTenBillionValues() -> ([[[[[[[[[[[Int:Int]]]]]]]]]]]) {
        let subArray = arrayForOneBillionValues()
        var tenBillionContainer = [subArray]
        for _ in 1..<10 {
            tenBillionContainer.append(subArray)
        }
        return tenBillionContainer
    }
    
    func arrayForHundredBillionValues() -> ([[[[[[[[[[[[Int:Int]]]]]]]]]]]]) {
        let subArray = arrayForTenBillionValues()
        var hundredBillionContainer = [subArray]
        for _ in 1..<10 {
            hundredBillionContainer.append(subArray)
        }
        return hundredBillionContainer
    }
    
    
    func testThreeNPlusOne(x: Int, useStorage: Bool) -> (Int) {
        var testX = x
        var cycleValuesArray = [testX]
        var cycleCount = cycleValuesArray.count
        var storedValueFound = false
        var storedCount = 0
        while testX > 1 {
            // Search for value here
            if useStorage == true {
                if let foundCycleCount = findValue(testX, inArray: self.array!) {
                    storedCount = foundCycleCount
                    storedValueFound = true
                    break
                }
            }

            if (testX % 2) != 1 {
                testX /=  2
            } else {
                testX = (3 * testX) + 1
            }
            cycleValuesArray.append(testX)
        }
        if storedValueFound == false {
            cycleCount = cycleValuesArray.count
            setValuesFromArray(cycleValuesArray)
            // use cyclevaluesarray to set values for various different values in array
        } else {
            cycleCount = cycleValuesArray.count + storedCount - 1
            if useStorage == true {
                setValuesFromArrayPlusFoundCount(cycleValuesArray, count: storedCount)
                //        use cyclevaluesarray plus count to set values for new values in array
            }
        }
        
        return cycleCount
    }
    
    func outputSmallerIntFirst(firstInt: Int, secondInt: Int) -> (Int, Int) {
        var smallerInt = firstInt
        var largerInt = secondInt
        
        if firstInt > secondInt {
            smallerInt = secondInt
            largerInt = firstInt
        }
        return (smallerInt, largerInt)
    }
    
    func programmingTest(firstInt: Int, secondInt: Int, useStorage: Bool, completion: (()->())?) -> (Int, Int, Int) {
        let smallerInt: Int
        let largerInt: Int
        var maxCycleCount = 0
        
        (smallerInt, largerInt) = outputSmallerIntFirst(firstInt, secondInt: secondInt)
        
        for x in smallerInt...largerInt {
            
            let cycleCount = testThreeNPlusOne(x, useStorage: useStorage)
            
            if cycleCount > maxCycleCount {
                maxCycleCount = cycleCount
            }
        }
        
        print("\(firstInt) \(secondInt) \(maxCycleCount)", terminator: "")
        completion?()
        return (firstInt, secondInt, maxCycleCount)
    }
    
    
    
    func setValuesFromArray(array: [Int]) {
        for subtractor in 0..<array.count {
            let value = array.count - subtractor
            setValue(array[subtractor], value: value, inArray: self.array!)
        }
    }
    
    func setValuesFromArrayPlusFoundCount(array: [Int], count: Int) {
        for subtractor in 0..<array.count {
            let value = array.count - (subtractor + 1) + count
            setValue(array[subtractor], value: value, inArray: self.array!)
        }
    }
    
    func arrayAccessor(input: Int) -> ([Int]) {
        let stringInput = String(input)
        var characterCount = stringInput.characters.count
        if characterCount == 1 {
            characterCount += 1
        }
        var output = [Int]()
        let numOfZeros = 12-characterCount
        if numOfZeros > 0 {
            for _ in 0...(numOfZeros) {
                let numberToAppend = 0
                
                output.append(numberToAppend)
            }
        }

        if characterCount > 1 {
            for i in 0..<(characterCount-2) {
                let startIndex = stringInput.startIndex.advancedBy(i)
                let endIndex = startIndex.advancedBy(1)
                let numberString = stringInput.substringToIndex(endIndex).substringFromIndex(startIndex)
                //        let adjustedNumber = String(Int(numberString)!-1)
                let toAppend = Int(numberString)
                output.append(toAppend!)
            }
        }
        output.append(input)
        return output
    }
    
    func findValue(intToFind: Int, inArray: [[[[[[[[[[[[Int:Int]]]]]]]]]]]]) -> (Int?) {
        let access = arrayAccessor(intToFind)
        let subArray = inArray[access[0]][access[1]][access[2]][access[3]][access[4]]
        if let x = subArray[access[5]][access[6]][access[7]][access[8]][access[9]][access[10]][access[11]] {
            print(x)
            return x
        } else {
            print("nothing found")
            return nil
        }
    }
    
    func setValue(key: Int, value: Int, inArray: [[[[[[[[[[[[Int:Int]]]]]]]]]]]]) -> () {
        let access = arrayAccessor(key)
        var subArray = self.array![access[0]][access[1]][access[2]][access[3]][access[4]]
        subArray[access[5]][access[6]][access[7]][access[8]][access[9]][access[10]][access[11]] = value
        self.array![access[0]][access[1]][access[2]][access[3]][access[4]] = subArray
    }
    
}