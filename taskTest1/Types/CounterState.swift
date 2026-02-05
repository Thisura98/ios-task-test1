//
//  CounterTrackerClass.swift
//  taskTest1
//
//  Created by Thisura Dodangoda on 2026-02-04.
//

import Foundation

fileprivate let durationInMs = 1000

class ClassBasedCounterState{
    
    var count: Int = 0
    
    func update() async throws {
        try await Task.sleep(for: .milliseconds(durationInMs))
        count += 1
    }
    
    func reset(){
        count = 0
    }
    
}

actor ActorBasedCounterState{
    
    var count: Int = 0
    
    func update() async throws {
        try await Task.sleep(for: .milliseconds(durationInMs))
        count += 1
    }
    
    func reset(){
        count = 0
    }
    
}
