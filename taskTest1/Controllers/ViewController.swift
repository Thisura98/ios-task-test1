//
//  ViewController.swift
//  taskTest1
//
//  Created by Thisura Dodangoda on 2026-02-03.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var button: UIButton!
    
    private let taskRunner = TaskRunner()
    
    var status: String{
        get { label?.text ?? "" }
        set{ label?.text = newValue }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonTapped(_ sender: Any) {
        status = "Creating task"
        let task = taskRunner.createAndRunTask()
        status = "Running task..."
    }
}

