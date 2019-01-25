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

    let shortTestText = "They were not railway children to begin with. I don't suppose they had\never thought about railways except as a means of getting to Maskelyne\nand Cook's, the Pantomime, Zoological Gardens, and Madame Tussaud's.\nThey were just ordinary suburban children, and they lived with their\nFather and Mother in an ordinary red-brick-fronted villa, with coloured\nglass in the front door, a tiled passage that was called a hall, a\nbath-room with hot and cold water, electric bells, French windows, and\na good deal of white paint, and 'every modern convenience', as the\nhouse-agents say."
    
    var longTestText = ""
    var longTextTestUrl = "http://www.loyalbooks.com/download/text/Railway-Children-by-E-Nesbit.txt"
    
    let utilities = Utilities()
    
    
    override func setUp() {
        let exp = expectation(description: "Retrieving longer text from url")
        Client().getText(url: longTextTestUrl, onSuccess: {contentText in
            self.longTestText = contentText
            exp.fulfill()
        }, onFailure: { error in
            debugPrint(error.localizedDescription)
            XCTFail()
        })
        waitForExpectations(timeout: 10, handler: nil)
    }

    override func tearDown() {
    }

    func testCountOccurrencesOfASingleWordInText() -> Bool {
        var count = 0
        guard let match = utilities.getWordsDictionaryFromList(list: utilities.getWordsFromText(text: shortTestText.lowercased())).first(where: { $0.key == "and" }) else {
            XCTFail("No match found for test word")
            return false
        }
        count = match.value.occurrences
        let expectedResult = 7
        XCTAssertEqual(count, expectedResult)
        return true
    }
    
    func testGetWordsFromText(){
        let count = utilities.getWordsFromText(text: shortTestText.lowercased()).count
        let expectedResult = 98 //98 is the result obtained putting the testText in this website: https://wordcounttools.com/
        XCTAssertEqual(count, expectedResult)
    }
    
    func testResultComparisonBetweenCountMethods(){
        let firstMethodResult = utilities.getWordsFromText(text: shortTestText.lowercased())
        let secondMethodResult = utilities.getWordsFromText2(text: shortTestText.lowercased())
        XCTAssertEqual(firstMethodResult, secondMethodResult)
    }
    
    func testListOfWordsFromText(){
        let count = utilities.getWordsDictionaryFromList(list: utilities.getWordsFromText(text: shortTestText.lowercased())).count
        let expectedResult = 73
        XCTAssertEqual(count, expectedResult)
    }
    
    func testPrimeNumbers(){
        let count = utilities.getWordsDictionaryFromList(list: utilities.getWordsFromText(text: shortTestText.lowercased())).filter({ $0.value.isPrime }).count
        let expectedResult = 10
        XCTAssertEqual(count, expectedResult)
    }
    
    func testPrimeNumbersSecondMethod(){
        let count = utilities.getWordsDictionaryFromList2(list: utilities.getWordsFromText(text: shortTestText.lowercased())).filter({ $0.value.isPrime }).count
        let expectedResult = 10
        XCTAssertEqual(count, expectedResult)
    }

    //slower
    func testPerformancePrimeNumbersFirstMethod(){
        self.measure {
            _  = utilities.getWordsDictionaryFromList(list: utilities.getWordsFromText(text: longTestText.lowercased())).filter({ $0.value.isPrime })
        }
    }
    
    //faster
    func testPerformancePrimeNumbersSecondMethod(){
        self.measure {
            _  = utilities.getWordsDictionaryFromList2(list: utilities.getWordsFromText(text: longTestText.lowercased())).filter({ $0.value.isPrime })
        }
    }
    
    //slower
    func testPerformanceFirstMethod() {
        self.measure {
            _ = utilities.getWordsFromText(text: ("\(longTestText) \(longTestText) \(longTestText) \(longTestText)").lowercased())
        }
    }
    
    //faster
    func testPerformanceSecondMethod() {
        self.measure {
            _ = utilities.getWordsFromText2(text: ("\(longTestText) \(longTestText) \(longTestText) \(longTestText)").lowercased())
        }
    }

}
