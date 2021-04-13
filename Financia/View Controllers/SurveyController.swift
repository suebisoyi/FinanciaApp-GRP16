//
//  SurveyController.swift
//  Financia
//
//  Created by Sudikshya Bisoyi
//

import UIKit

class SurveyController: UIViewController {
    
    @IBOutlet weak var questionCounter: UILabel!
    //@IBOutlet weak var flagView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    
    //Outlet for the Buttons
    @IBOutlet weak var optionA: UIButton!
    @IBOutlet weak var optionB: UIButton!
    @IBOutlet weak var optionC: UIButton!
    @IBOutlet weak var optionD: UIButton!
    
    var allQuestions = Array(
        arrayLiteral:
        Question(questionText: "Which product has the highest value interest rate?", choiceA: "Car Loans", choiceB: "Credit Card", choiceC: "Mortgage", choiceD: "Line of Credit", answer: 1),
        Question(/*image: "p2.png", */ questionText: "Which of the following products have the highest risks?", choiceA: "A. GIC", choiceB: "B. Mutual Funds", choiceC: "C. Bonds", choiceD: "D. Savings", answer: 2),
        Question(/*image: "p4.png", */questionText: "What is the maximum amortization period in Canada for an uninsured mortgage?", choiceA: "A. 20 years", choiceB: "B. 25 years", choiceC: "C. 30 years", choiceD: "50 years", answer: 3),
        Question(/*image: "p3.png", */questionText: "Pick the best choice for compounding for you?", choiceA: "A. Compounding monthly", choiceB: "B. Compounding quarterly", choiceC: "C. Compounding annually", choiceD: "D. Compounding weekly", answer: 1)
    )
        var questionNumber: Int = 0
        var score: Int = 0
        var selectedAnswer: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        super.viewDidLoad()
               updateQuestion()
        questionCounter.text = String(questionNumber+1) + "/4"
        //updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
   /* @IBAction func optionAPressed(_ sender: UIButton) {
        if sender.tag == selectedAnswer {
            
        }
    }
    
    @IBAction func optionBPressed(_ sender: Any) {
    }
    
    @IBAction func optionCPressed(_ sender: Any) {
    }
    
    
    @IBAction func optionDPressed(_ sender: Any) {
    }*/
    
  @IBAction func answerPressed(_ sender: UIButton) {
        if sender.tag == allQuestions[questionNumber].correctAnswer{
                print("Fantastic!")
            print("Not Updated: \(questionNumber) | \(score)")
                score += 1
            print("Updated: \(questionNumber) | \(score)")
            
        }else{
            print("Good Try!")
            print("Updated: \(questionNumber) | \(score)")
            
        }
                
        questionNumber += 1
        updateQuestion()
        if questionNumber == 4 {
            questionCounter.text = String(questionNumber) + "/4"
        }
        else {
            questionCounter.text = String(questionNumber+1) + "/4"
        }
  }
    
    func updateQuestion(){
            
            if questionNumber <= allQuestions.count - 1{
               /// flagView.image = UIImage(named:(allQuestions.list[questionNumber].questionImage))
                questionLabel.text = allQuestions[questionNumber].question
                optionA.setTitle(allQuestions[questionNumber].optionA, for: UIControl.State.normal)
                optionB.setTitle(allQuestions[questionNumber].optionB, for: UIControl.State.normal)
                optionC.setTitle(allQuestions[questionNumber].optionC, for: UIControl.State.normal)
                optionD.setTitle(allQuestions[questionNumber].optionD, for: UIControl.State.normal)
                selectedAnswer = allQuestions[questionNumber].correctAnswer
                //updateUI()
                
            } else {
                let alert = UIAlertController(title: "Awesome!", message: "Congrats! You are of \(findUserLevel()) level.", preferredStyle: .alert)
                let goToLevelPageAction = UIAlertAction(title: "Go To \(findUserLevel()) Content Page", style: .default, handler: {action in self.goToLevelPage(pageLevel: self.findUserLevel())})
                let restartAction = UIAlertAction(title: "Restart Survey", style: .default, handler: {action in self.restartQuiz()})
                alert.addAction(goToLevelPageAction)
                alert.addAction(restartAction)
                present(alert, animated: true, completion: nil)
            }
        }
        
        /*func updateUI(){
            scoreLabel.text = "Score: \(score)"
            questionCounter.text = "\(questionNumber + 1)/\(allQuestions.list.count)"
            progressView.frame.size.width = (view.frame.size.width / CGFloat(allQuestions.list.count)) * CGFloat(questionNumber + 1)
            
        }*/
        
        func restartQuiz(){
            score = 0
            questionNumber = 0
            updateQuestion()
            questionCounter.text = String(questionNumber+1) + "/4"
            
        }
    func findUserLevel() -> String {
        var userLevel: String = ""
        
        if score <= 1 { userLevel = "Beginner"}
        
        else if score == 2 && score <= 3 { userLevel =  "Intermediate"}
        
        else if score == 4 { userLevel = "Advanced"}
        
        return userLevel
    }
    
    func goToLevelPage(pageLevel: String) {
        if pageLevel.elementsEqual("Beginner") {
            self.performSegue(withIdentifier: "goToBeginnerContentPage", sender: self)
        }
        else if pageLevel.elementsEqual("Intermediate") {
            self.performSegue(withIdentifier: "goToIntermediateContentPage", sender: self)
            
        }
        else if pageLevel.elementsEqual("Advanced") {
            self.performSegue(withIdentifier: "goToAdvancedContentPage", sender: self)        }
    }
    
}
