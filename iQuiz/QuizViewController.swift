//
//  QuizViewController.swift
//  iQuiz
//
//  Created by Maxwell London on 5/12/22.
//

import UIKit

class QuizViewController: UIViewController {
    
    var selectedQuiz = "N/A"
    var selectedAnswer = "N/A"
    var currentQuestion: Int = 0
    var currentCorrect = 0
    
    @IBOutlet var questionLabel: UILabel!
    
    let mathQuestions = ["What is 1+1", "What is 5x5?", "What is 4x6"]
    let marvelQuestions = ["Who is spiderman?", "What year did the first spiderman come out?", "How many marvel movies are there?"]
    let scienceQuestions = ["As you go down into a well, your weight: ", "Multiple Choice: Bees must collect nectar from approximately how many flowers to make 1 pound of honeycomb? Is it", "Albacore is a type of: "]
    
    let mathAnswers = [["2", "7", "10", "5"], ["30", "40", "25", "10"], ["80", "90", "70", "24"]]
    let marvelAnswers = [["a spider", "a villan", "a marvel character", "spidey"], ["2001", "2002", "2003", "2004"], ["21", "22", "23", "24"]]
    let scienceAnswers = [["increases slightly", "decreases slightly", "stays the same", "increases drastically"], ["10 thousand", "2 mil", "20 mil", "50 mil"], ["shell fish", "tuna", "marble", "metoroid"]]
    let correctMath = ["2", "25", "24"]
    let correctMarvel = ["spidey", "2002", "23"]
    let correctScience = ["decreases slightly", "2 mil", "tuna"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func showAnswer(_ sender: Any) {
        let story = storyboard?.instantiateViewController(identifier: "answer") as! AnswerViewController

        story.currentQuestion = currentQuestion
        story.selectedQuiz = self.selectedQuiz
        
        switch selectedQuiz{
        case "Mathematics":
            story.correctAnswerText = correctMath[currentQuestion]
            story.selectedQuestionText = "Question: " + mathQuestions[currentQuestion]
            
            if(selectedAnswer == correctMath[currentQuestion]){
                story.correctnessOutputText  = "Correct, nice job!"
                currentCorrect += 1
            } else {
                story.correctnessOutputText  = "Incorrect, better luck next time"
            }
            story.correctAnswerText = "Correct Anwser: " + correctMath[currentQuestion]
        case "Marvel Super Heroes":
            story.correctAnswerText = correctMarvel[currentQuestion]
            story.selectedQuestionText = "Question: " + marvelQuestions[currentQuestion]
            
            if(selectedAnswer == correctMarvel[currentQuestion]){
                story.correctnessOutputText  = "Correct, nice job!"
                currentCorrect += 1
            } else {
                story.correctnessOutputText  = "Incorrect, better luck next time"
            }
            story.correctAnswerText = "Correct Anwser: " + correctMarvel[currentQuestion]
        case "Science":
            story.correctAnswerText = correctScience[currentQuestion]
            story.selectedQuestionText = "Question: " + scienceQuestions[currentQuestion]
            
            if(selectedAnswer == correctScience[currentQuestion]){
                story.correctnessOutputText  = "Correct, nice job!"
                currentCorrect += 1
            } else {
                story.correctnessOutputText  = "Incorrect, better luck next time"
            }
            story.correctAnswerText = "Correct Anwser: " + correctScience[currentQuestion]
        default:
            print("An invalid quiz category was selected")
        }
        
        story.modalPresentationStyle = .fullScreen
        story.currentCorrect = self.currentCorrect
        present(story, animated: true)
    }
}

extension QuizViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAnswer = tableView.cellForRow(at: indexPath) as! QuizViewCell
        
        self.selectedAnswer = selectedAnswer.quizTextLabel.text!
    }
}

extension QuizViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizCell", for: indexPath) as! QuizViewCell
        
        cell.quizTextLabel.text = marvelAnswers[currentQuestion][indexPath.row]
        
        switch selectedQuiz{
        case "Mathematics":
            cell.quizTextLabel.text = mathAnswers[currentQuestion][indexPath.row]
            questionLabel.text = mathQuestions[currentQuestion]
        case "Marvel Super Heroes":
            cell.quizTextLabel.text = marvelAnswers[currentQuestion][indexPath.row]
            questionLabel.text = marvelQuestions[currentQuestion]
        case "Science":
            cell.quizTextLabel.text = scienceAnswers[currentQuestion][indexPath.row]
            questionLabel.text = scienceQuestions[currentQuestion]
        default:
            print("An invalid quiz category was selected")
        }
        return cell
    }
    
    
}
