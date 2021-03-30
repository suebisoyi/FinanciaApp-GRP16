//
//  WordBankWords.swift
//  Financia
//
//  Created by  on 3/30/21.
//

import UIKit

class WordBankWords: NSObject {

    var wordID: Int?
    var wordName: String?
    var wordDefinition: String?
    var wordExampleUses: String?
    
    override init() {
        wordName = ""
        wordDefinition = ""
        wordExampleUses = ""
    }
    
    func initWithWord(wordID id: Int, wordName passedWordName: String, wordDefinition passedWordDefinition: String, wordExampleUses passedWordExampleUses: String) {
        wordID = id
        wordName = passedWordName
        wordDefinition = passedWordDefinition
        wordExampleUses = passedWordExampleUses
    }
    
}
