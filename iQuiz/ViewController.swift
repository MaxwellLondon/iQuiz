//
//  ViewController.swift
//  iQuiz
//
//  Created by Maxwell London on 5/4/22.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func displaySettings(_ sender: Any) {
        let alert = UIAlertController(title: "Settings go here", message: "TODO", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet var tableView: UITableView!
    
    let categories: [String] = ["Mathematics", "Marvel Super Heroes", "Science"]
    let descriptions: [String] = ["Test your math capabilities!", "How well do you know Marvel Comics?", "So you think you're a scientist, huh?"]
    let imageNames: [String] = ["math", "marvel", "science"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        let image = UIImage(named: imageNames[indexPath.row])
        
        cell.cellIMG.image = image
        cell.cellLabel.text = categories[indexPath.row]
        cell.cellSubLabel.text = descriptions[indexPath.row]
        
        return cell
    }
    
    
}

