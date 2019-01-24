//
//  Utilities.swift
//  WordsCounter
//
//  Created by alessio on 24/01/2019.
//  Copyright © 2019 Giovannoli. All rights reserved.
//

import Foundation

class Utilities{
        
    func getWordsDictionaryFromList(list: Array<String>) -> Dictionary<String, Int>{
        var dict = Dictionary<String, Int>()
        for w in list{
            if let count = dict[w]{
                dict[w] = count + 1
            }
            else{
                dict[w] = 1
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
        
        debugPrint("FINISHED")
        return result
    }
    
    func substringWithRange(text: String, aRange : CFRange) -> String {
        let nsrange = NSMakeRange(aRange.location, aRange.length)
        let substring = (text as NSString).substring(with: nsrange)
        return substring
    }
    
}
