//
//  CounterViewModel.swift
//  taskTest1
//
//  Created by Thisura Dodangoda on 2026-02-04.
//

import Combine

class CounterClassViewModel{
    
    @Published var counter1: String = "0"
    @Published var counter2: String = "0"
    @Published var counter3: String = "0"
    
    func updateFrom(_ snapshot: CounterSnapshot) async {
        let values = await snapshot.getSnapshot()
        guard values.count == 3 else {
            print("Snapshot must return exactly 3 values but got \(values.count)")
            return
        }
        
        counter1 = String(values[0])
        counter2 = String(values[1])
        counter3 = String(values[2])
    }

}
