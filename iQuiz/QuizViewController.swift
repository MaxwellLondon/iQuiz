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
    var amountOfQuestions = 0
    
    @IBOutlet var questionLabel: UILabel!
    
    //Math, Marvel, Science
    var questionAmount: [Int] = [0, 0, 0]
    
    var mathQuestions: [String] = []
    var marvelQuestions: [String] = []
    var scienceQuestions: [String] = []
    
    var mathAnswers: [[String]] = []
    var marvelAnswers: [[String]] = []
    var scienceAnswers: [[String]] = []
    var correctMath: [String] = []
    var correctMarvel: [String] = []
    var correctScience: [String] = []
    
    
    
    struct WelcomeElement: Codable {
        let title, desc: String
        let questions: [Question]
    }
    
    struct Question: Codable {
        let text, answer: String
        let answers: [String]
    }
    
    typealias Welcome = [WelcomeElement]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let questions = FileManager.default.contents(atPath: dir!.path + "/response.txt")
        
        do {
            let result = try JSONDecoder().decode(Welcome.self, from: questions!)
            
            for quiz in result {
                let questions = quiz.questions
                let quiz = quiz.title
                for question in questions {
                    switch quiz {
                    case "Science!":
                        scienceQuestions.append(question.text)
                        scienceAnswers.append(question.answers)
                        correctScience.append(question.answer)
                        questionAmount[0] += 1
                    case "Marvel Super Heroes":
                        marvelQuestions.append(question.text)
                        marvelAnswers.append(question.answers)
                        correctMarvel.append(question.answer)
                        questionAmount[1] += 1
                    case "Mathematics":
                        mathQuestions.append(question.text)
                        mathAnswers.append(question.answers)
                        correctMath.append(question.answer)
                        questionAmount[2] += 1
                    default:
                        print("something went wrong")
                    }
                }
            }
        } catch {
            print(error)
        }
        print(mathAnswers)
    }
    
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func showAnswer(_ sender: Any) {
        let story = storyboard?.instantiateViewController(identifier: "answer") as! AnswerViewController
        
        story.currentQuestion = currentQuestion
        story.selectedQuiz = self.selectedQuiz
        
        
        switch selectedQuiz{
        case "Mathematics":
            story.correctAnswerText = "Correct Anwser: " + mathAnswers[currentQuestion][Int(correctMath[currentQuestion])! - 1]
            story.selectedQuestionText = "Question: " + mathQuestions[currentQuestion]
            
            if(selectedAnswer == mathAnswers[currentQuestion][Int(correctMath[currentQuestion])! - 1]){
                story.correctnessOutputText  = "Correct, nice job!"
                currentCorrect += 1
            } else {
                story.correctnessOutputText  = "Incorrect, better luck next time"
            }
            story.amountOfQuestions = questionAmount[0]
        case "Marvel Super Heroes":
            story.correctAnswerText = "Correct Anwser: " + marvelAnswers[currentQuestion][Int(correctMarvel[currentQuestion])! - 1]
            story.selectedQuestionText = "Question: " + marvelQuestions[currentQuestion]
            
            if(selectedAnswer == marvelAnswers[currentQuestion][Int(correctMarvel[currentQuestion])! - 1]){
                story.correctnessOutputText  = "Correct, nice job!"
                currentCorrect += 1
            } else {
                story.correctnessOutputText  = "Incorrect, better luck next time"
            }
            story.amountOfQuestions = questionAmount[1]
        case "Science!":
            story.correctAnswerText = "Correct Anwser: " + scienceAnswers[currentQuestion][Int(correctScience[currentQuestion])! - 1]
            story.selectedQuestionText = "Question: " + scienceQuestions[currentQuestion]
            
            if(selectedAnswer == scienceAnswers[currentQuestion][Int(correctScience[currentQuestion])! - 1]){
                story.correctnessOutputText  = "Correct, nice job!"
                currentCorrect += 1
            } else {
                story.correctnessOutputText  = "Incorrect, better luck next time"
            }
            story.amountOfQuestions = questionAmount[2]
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
        case "Science!":
            cell.quizTextLabel.text = scienceAnswers[currentQuestion][indexPath.row]
            questionLabel.text = scienceQuestions[currentQuestion]
        default:
            print("An invalid quiz category was selected")
        }
        return cell
    }
    
    
}
