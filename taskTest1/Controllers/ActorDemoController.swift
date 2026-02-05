//
//  ActorDemoController.swift
//  taskTest1
//
//  Created by Thisura Dodangoda on 2026-02-04.
//

import UIKit
import Combine

class ActorDemoController: UIViewController {
    
    @IBOutlet private weak var counter1Label: UILabel!
    @IBOutlet private weak var counter2Label: UILabel!
    @IBOutlet private weak var counter3Label: UILabel!
    @IBOutlet private weak var controlSwitch: UISwitch!
    
    var useClassBasedState: Bool {
        return controlSwitch?.isOn ?? false
    }
    
    let vm = CounterClassViewModel()
    let classState = ClassBasedCounterState()
    let actorState = ActorBasedCounterState()
    
    var cancellables: Set<AnyCancellable> = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Publishers.CombineLatest3(vm.$counter1, vm.$counter2, vm.$counter3)
            .sink(receiveValue: { [weak self] in self?.updateLabels($0, $1, $2)})
            .store(in: &cancellables)
    }
    
    private func updateLabels(_ v1: Int, _ v2: Int, _ v3: Int){
        counter1Label.text = "\(v1)"
        counter2Label.text = "\(v2)"
        counter3Label.text = "\(v3)"
    }
    
    private func runDemoWithClass(){
        print("Running demo with class...")
        Task{
            try await classState.update()
            vm.counter1 = classState.count
        }
        Task{
            try await classState.update()
            vm.counter2 = classState.count
        }
        Task{
            try await classState.update()
            vm.counter3 = classState.count
        }
    }
    
    private func runDemoWithActor(){
        print("Running demo with actor...")
        Task{
            try await actorState.update()
            vm.counter1 = await actorState.count
        }
        Task{
            try await actorState.update()
            vm.counter2 = await actorState.count
        }
        Task{
            try await actorState.update()
            vm.counter3 = await actorState.count
        }
    }
    
    @IBAction func switchClicked(_ sender: Any) {
        print("Switch Clicked! useClassBaseState: \(useClassBasedState)")
    }
    
    @IBAction func startClicked(_ sender: Any) {
        Task{
            updateLabels(0, 0, 0)
            classState.reset()
            await actorState.reset()
            
            if useClassBasedState{
                runDemoWithClass()
            }
            else{
                runDemoWithActor()
            }
        }
    }
    
}
