//
//  CounterTrackerClass.swift
//  taskTest1
//
//  Created by Thisura Dodangoda on 2026-02-04.
//

protocol CounterSnapshot{
    func getSnapshot() async -> [Int]
}

class ClassBasedCounterState: CounterSnapshot{
    var c1: Int = 0
    var c2: Int = 0
    var c3: Int = 0
    
    func getSnapshot() -> [Int] {
        return [c1, c2, c3]
    }
    
    func update(counterIndex: Int, _ value: Int){
        switch(counterIndex){
        case 0: c1 += value
        case 1: c2 += value
        case 2: c3 += value
        default:
            fatalError()
        }
    }
}

actor ActorBasedCounterState: CounterSnapshot{
    
    var c1: Int = 0
    var c2: Int = 0
    var c3: Int = 0
    
    func getSnapshot() -> [Int] {
        return [c1, c2, c3]
    }
    
    func update(counterIndex: Int, _ value: Int){
        switch(counterIndex){
        case 0: c1 += value
        case 1: c2 += value
        case 2: c3 += value
        default:
            fatalError()
        }
    }
    
}
