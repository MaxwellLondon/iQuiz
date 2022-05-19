//
//  ViewController.swift
//  iQuiz
//
//  Created by Maxwell London on 5/4/22.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBAction func displaySettings(_ sender: Any) {
        let alert = UIAlertController(title: "Settings go here", message: "TODO", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    var dataPath = ""
    
    @IBOutlet var tableView: UITableView!
    
    var categories: [String] = []
    var descriptions: [String] = []
    let imageNames: [String] = ["math", "marvel", "science"]
    
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
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        print(FileManager.default.fileExists(atPath: dir!.path + "/response.txt"))
        
        if(FileManager.default.fileExists(atPath: dir!.path + "/response.txt")) {
            let questions = FileManager.default.contents(atPath: dir!.path + "/response.txt")
            
            do {
                let result = try JSONDecoder().decode(Welcome.self, from: questions!)
                for i in result{
                    categories.append(i.title)
                    descriptions.append(i.desc)
                }
            } catch {
                print(error)
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as! CustomCell

        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        if(FileManager.default.fileExists(atPath: dir!.path + "/response.txt")){
            print("hello world")
            let story = storyboard?.instantiateViewController(identifier: "quiz") as! QuizViewController
            
            story.selectedQuiz = selectedCell.cellLabel.text!
            story.modalPresentationStyle = .fullScreen
            present(story, animated: true)
        } else {
            let alert = UIAlertController(title: "Invalid Action", message: "You must pull Quiz data from a valid URL", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        let image = UIImage(named: imageNames[indexPath.row])
        
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        if(FileManager.default.fileExists(atPath: dir!.path + "/response.txt")) {
            let questions = FileManager.default.contents(atPath: dir!.path + "/response.txt")
            
            do {
                cell.cellIMG.image = image
                cell.cellLabel.text = categories[indexPath.row]
                cell.cellSubLabel.text = descriptions[indexPath.row]
            } catch {
                print(error)
            }
        }
        
        return cell
    }
}

