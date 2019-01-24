//
//  Utilities.swift
//  WordsCounter
//
//  Created by alessio on 24/01/2019.
//  Copyright © 2019 Giovannoli. All rights reserved.
//

import Foundation

class Utilities{
        
    func getWordsDictionaryFromList(list: Array<String>) -> Dictionary<String, PropertiesForWord>{
        var dict = Dictionary<String, PropertiesForWord>()
        for w in list{
            if dict[w] != nil{
                dict[w]!.occurrencies += 1
                dict[w]!.isPrime = isPrimenumber(number: dict[w]!.occurrencies)
            }
            else{
                dict[w] = PropertiesForWord(occurrencies: 1, isPrime: false)
            }
        }
        return dict
    }
    
    func getWordsFromText(text: String) -> Array<String>{
        let range = CFRangeMake(0, text.count)
        let stringTokenizer = CFStringTokenizerCreate( kCFAllocatorDefault, text as CFString, range, UInt(kCFStringTokenizerUnitWord), CFLocaleCopyCurrent())
        var tokenType = CFStringTokenizerAdvanceToNextToken(stringTokenizer)
        var result : [String] = []
        
        while tokenType != []
        {
            let currentTokenRange = CFStringTokenizerGetCurrentTokenRange(stringTokenizer)
            let substring = self.substringWithRange(text: text, aRange: currentTokenRange)
            result.append(substring)
            tokenType = CFStringTokenizerAdvanceToNextToken(stringTokenizer)
        }
        
        return result
    }
    
    func substringWithRange(text: String, aRange : CFRange) -> String {
        let nsrange = NSMakeRange(aRange.location, aRange.length)
        let substring = (text as NSString).substring(with: nsrange)
        return substring
    }
    
    func isPrimenumber(number: Int) -> Bool{
        if number == 1{
            return false
        }
        if number <= 3{
            return true
        }
        var isPrime = true
        var i = 2
        while i < number {
            if number % i == 0 {
                isPrime = false
            }
            i += 1
        }
        return isPrime
    } 
}


struct PropertiesForWord{
    var occurrencies: Int = 0
    var isPrime: Bool = false
    
    init(occurrencies: Int, isPrime: Bool){
        self.occurrencies = occurrencies
        self.isPrime = isPrime
    }
}
