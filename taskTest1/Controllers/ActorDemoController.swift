//
//  ActorDemoController.swift
//  taskTest1
//
//  Created by Thisura Dodangoda on 2026-02-04.
//

import UIKit
import Combine

class ActorDemoController: UIViewController {
    
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var controlSwitch: UISwitch!
    
    let helper = CounterTasksHelper()
    var tasks: TaskCollection?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tasks = helper.generateMultipleCounterTasks(3, 100, 2, { count in
            print("ActorDemoController: Counter: \(count)")
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tasks?.cancelAll()
    }
    
    @IBAction func switchClicked(_ sender: Any) {
        print("Switch Clicked!")
    }
    
}
