//
//  FinishViewController.swift
//  iQuiz
//
//  Created by Maxwell London on 5/14/22.
//

import UIKit

class FinishViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func restartQuiz(_ sender: Any) {
        let story = storyboard?.instantiateViewController(identifier: "menu") as! ViewController

        story.modalPresentationStyle = .fullScreen
        present(story, animated: true)
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
