# Words Counter

Words Counter is a small app to count the occurrences the words in a text.
To retrieve the text just type the url into the search bar. 
The app will fetch the test with an HTTP GET, it will analyze the text list all the words in it. Every item of the list will contain the Word, the occurrences of that word inside the text and a **true** if that number is a prime number or **false** otherwise

# Development Process
The app follows the TDD procedure: before implementing the user interface and the before writing the methods for analyzing the text, I wrote the tests that the app would have to pass in order to be completed

# The Tests
### testGetWordsFromText
Ensures that the `getWordsFromText` method returns the correct list words of a text. 
This has been made by feeding the method a brief sample text which has been already analyzed by an third party tool; the test is passed if the number of words is the same as expected. 
`getWordsFromText` features Core Foundation's `CFStringTokenizer` and ignores spaces, newlines and punctuation. Cases like "don't" are counted as one word.

### testResultComparisonBetweenCountMethods
`getWordsFromText2` is an alternative method to `getWordsFromText`. It features Foundation's `enumerateSubstringsInRange` and it's actually simpler to implement than `getWordsFromText`.
This test's purpose is to be sure that both methods return the same result

### testListOfWordsFromText
After getting the words of a text the list must be analyzed in order to count the occurrences of each word. 
The method `getWordsDictionaryFromList` serves this purpose and this test ensures that the output is correct. 
the result of `getWordsFromText` is fed to `getWordsDictionaryFromList` which returns a dictionary where the words of the text are the keys and the values are instances of `PropertiesForWord`, an object which contains an `Int` for the occurrences and a `Bool` to determinate whether or not the occurrences are a prime number or not. 
Again the output is compared with a result obtained with an external tool to proof that the result is correct.

### testPrimeNumbers
Still using an external tool the amount of prime number of the test text are compared with the output of `getWordsDictionaryFromList`. The output of `getWordsDictionaryFromList` is filtered with a predicate in order to obtain a list of `PropertiesForWord` where the `occurrences` are a prime number. If the resulting list length is the same as expected, the test is passed

### testCountOccurrencesOfASingleWordInText

Finally to be sure that the occurrences of a words are counted correctly, from the output of `getWordsDictionaryFromList` the occurrences of a test word (e.g. `the`) are compared with the expected result.

### testPrimeNumbersSecondMethod
`getWordsDictionaryFromList2` is an alternative method to `getWordsDictionaryFromList` but with a slightly different approach to determinate whether or not the occurrences are a prime number.
This test's purpose is to ensure that both method return the same result

# Performance Tests
- testPerformancePrimeNumbersFirstMethod
- testPerformancePrimeNumbersSecondMethod
- testPerformanceFirstMethod
- testPerformanceSecondMethod

These tests' purpose is to compare the performance of `getWordsDictionaryFromList` and `getWordsFromText` with their alternative methods.
For these tests I needed a much longer test text, so in the `setUp` method I retrieved a long text from internet, since the performances difference couldn't be measured using a short text (for `getWordsDictionaryFromList` I chained the text four times to make it even longer).
`getWordsDictionaryFromList` and `getWordsFromText` resulted slower than their alternative methods
