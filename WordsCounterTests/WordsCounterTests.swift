//
//  WordsCounterTests.swift
//  WordsCounterTests
//
//  Created by alessio on 24/01/2019.
//  Copyright © 2019 Giovannoli. All rights reserved.
//

import XCTest
@testable import WordsCounter

class WordsCounterTests: XCTestCase {

    let testText = "They were not railway children to begin with. I don't suppose they had\never thought about railways except as a means of getting to Maskelyne\nand Cook's, the Pantomime, Zoological Gardens, and Madame Tussaud's.\nThey were just ordinary suburban children, and they lived with their\nFather and Mother in an ordinary red-brick-fronted villa, with coloured\nglass in the front door, a tiled passage that was called a hall, a\nbath-room with hot and cold water, electric bells, French windows, and\na good deal of white paint, and 'every modern convenience', as the\nhouse-agents say."
    
    let utilities = Utilities()
    
    
    override func setUp() {
    }

    override func tearDown() {
    }

    func testCountOccurrencesOfASingleWordInText() -> Bool {
        var count = 0
        guard let match = utilities.getWordsDictionaryFromList(list: utilities.getWordsFromText(text: testText.lowercased())).first(where: { $0.key == "and" }) else {
            XCTFail("No match found for test word")
            return false
        }
        count = match.value
        let expectedResult = 7
        XCTAssertEqual(count, expectedResult)
        return true
    }
    
    func testGetWordsFromText(){
        let count = utilities.getWordsFromText(text: testText.lowercased()).count
        let expectedResult = 98 //98 is the result obtained putting the testText in this website: https://wordcounttools.com/
        XCTAssertEqual(count, expectedResult)
    }
    
    func testListOfWordsFromText(){
        let count = utilities.getWordsDictionaryFromList(list: utilities.getWordsFromText(text: testText.lowercased())).count
        let expectedResult = 73
        XCTAssertEqual(count, expectedResult)
    }
    
    func testPrimeNumbers(){
        let count = 0
        let expectedResult = 10
        XCTAssertEqual(count, expectedResult)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
