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
    
    var useActorBaseCounterState: Bool {
        return controlSwitch?.isOn ?? true
    }
    
    let helper = CounterTasksHelper()
    let vm = CounterClassViewModel()
    let c1 = ClassBasedCounterState()
    let c2 = ActorBasedCounterState()
    
    var counterTasks: TaskCollection?
    var stateWatcherTask: Task<Void, Never>?
    var cancellables: Set<AnyCancellable> = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Publishers.CombineLatest3(vm.$counter1, vm.$counter2, vm.$counter3)
            .sink(receiveValue: { [weak self] in self?.updateLabels($0, $1, $2)})
            .store(in: &cancellables)
        
        counterTasks = helper.generateMultipleCounterTasks(3, 100, 2, { [weak self] count in
            self?.handleCount(count)
        })
        
        stateWatcherTask = Task{ [weak self] in
            guard let s = self else { return }
            do{
                while(true){
                    try await Task.sleep(for: .seconds(1))
                    if (s.useActorBaseCounterState){
                        await s.vm.updateFrom(s.c1)
                        print("SW: update from c1")
                    }
                    else{
                        await s.vm.updateFrom(s.c2)
                        print("SW: update from c2")
                    }
                }
            }
            catch{
                print("State watcher task stopped")
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        counterTasks?.cancelAll()
        stateWatcherTask?.cancel()
    }
    
    private func updateLabels(_ s1: String, _ s2: String, _ s3: String){
        counter1Label.text = s1
        counter2Label.text = s2
        counter3Label.text = s3
    }
    
    private func handleCount(_ params: CounterTaskParam) {
        c1.update(counterIndex: params.taskId, params.count)
        Task{
            await c2.update(counterIndex: params.taskId, params.count)
        }
    }
    
    @IBAction func switchClicked(_ sender: Any) {
        print("Switch Clicked!")
    }
    
}
