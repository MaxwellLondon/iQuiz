//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Maxwell London on 5/13/22.
//

import UIKit

class AnswerViewController: UIViewController {
    
    var selectedQuestionText = ""
    var selectedQuiz = ""
    var correctnessOutputText = "-1"
    var correctAnswerText = "-1"
    var currentQuestion: Int = 0
    var currentCorrect = 0
    
    @IBAction func nextQuestion(_ sender: Any) {
        let story = storyboard?.instantiateViewController(identifier: "quiz") as! QuizViewController
        
        story.currentCorrect = self.currentCorrect
        
        story.selectedQuiz = self.selectedQuiz
        if(currentQuestion < 2){
            story.currentQuestion = currentQuestion + 1
            story.modalPresentationStyle = .fullScreen
            present(story, animated: true)
        } else {
            let restartViewController = storyboard?.instantiateViewController(identifier: "finish") as! FinishViewController

            restartViewController.modalPresentationStyle = .fullScreen
            present(restartViewController, animated: true)
        }
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        correctnessOutput.text = correctnessOutputText
        correctAnswer.text = correctAnswerText
        questionText.text = selectedQuestionText
        currentScore.text = "Current Correct: " + String(currentCorrect)
        print(currentQuestion)
    }
    
    @IBOutlet var correctnessOutput: UILabel!
    
    @IBOutlet var correctAnswer: UILabel!
    
    @IBOutlet var questionText: UILabel!
   
    @IBOutlet var currentScore: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
