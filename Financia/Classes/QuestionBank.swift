//
//  QuestionBank.swift
//  Financia
//
//  Created by Sudikshya Bisoyi
//

import Foundation

class QuestionBank{
    var list = [Question]()
    
    init() {
        list.append(Question(/*image: "p2.png", */ questionText: "Which of the following products have the highest risks?", choiceA: "A. GIC", choiceB: "B. Mutual Funds", choiceC: "C. Bonds", choiceD: "D. Savings", answer: 2))
        
        list.append(Question(/*image: "p4.png", */questionText: "What is the maximum amortization period in Canada for an uninsured mortgage?", choiceA: "A. 20 years", choiceB: "B. 25 years", choiceC: "C. 30 years", choiceD: "50 years", answer: 3))
        
        list.append(Question(/*image: "p3.png", */questionText: "Pick the best choice for compounding for you?", choiceA: "A. Compounding monthly", choiceB: "B. Compounding quarterly", choiceC: "C. Compounding annually", choiceD: "D. Compounding weekly", answer: 1))
      
    }
}
