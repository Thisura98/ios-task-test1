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
    let vm1 = CounterClassViewModel()
    let vm2 = CounterActorViewModel()
    
    var tasks: TaskCollection?
    var cancellables: Set<AnyCancellable> = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        vm1.$counter
            .receive(on: DispatchQueue.main)
            .map { String($0) }
            .assign(to: \.text, on: counterLabel)
            .store(in: &cancellables)
        
        vm2.$counter
            .map { String($0) }
            .assign(to: \.text, on: counterLabel)
            .store(in: &cancellables)
        
        tasks = helper.generateMultipleCounterTasks(3, 100, 2, { [weak self] count in
            self?.handleCount(count)
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tasks?.cancelAll()
    }
    
    private func handleCount(_ params: CounterTaskParam){
        // debug
        vm2.setCount(params.count)
    }
    
    @IBAction func switchClicked(_ sender: Any) {
        print("Switch Clicked!")
    }
    
}
