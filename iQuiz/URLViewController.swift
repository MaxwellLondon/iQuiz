//
//  URLViewController.swift
//  iQuiz
//
//  Created by Maxwell London on 5/16/22.
//

import UIKit
import Foundation


class URLViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textField: UITextField!
    
    @IBOutlet var textBox: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField.delegate = self
        
        let settings = UserDefaults()
        
        settings.set("https://tednewardsandbox.site44.com/questions.json", forKey: "URL")
        
        textBox.text = settings.string(forKey: "URL")
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    struct WelcomeElement: Codable {
        let title, desc: String
        let questions: [Question]
    }
    
    // MARK: - Question
    struct Question: Codable {
        let text, answer: String
        let answers: [String]
    }
    
    //let result = try JSONDecoder().decode(Welcome.self, from: data)
    
    typealias Welcome = [WelcomeElement]
    
    @IBAction func checkURLValidity(_ sender: Any) {
        if(Reachability.isConnectedToNetwork()){
            let url = URL(string: self.textField.text!)!
           
            DispatchQueue.global().async {
                
                let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                    guard let data = data else { return }
                    do{
                        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                            
                            let fileURL = dir.appendingPathComponent("response.txt")
                            
                            do {
                                try data.write(to: fileURL)
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
                task.resume()
                
                let seconds = 4.0
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    let story = self.storyboard?.instantiateViewController(identifier: "menu") as! ViewController

                    story.modalPresentationStyle = .fullScreen
                    self.present(story, animated: true)
                }
            }
        } else {
            let alert = UIAlertController(title: "Network Error", message: "You are not connected to the internet", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        //        let story = storyboard?.instantiateViewController(identifier: "menu") as! ViewController
        //
        //        story.modalPresentationStyle = .fullScreen
        //        present(story, animated: true)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
