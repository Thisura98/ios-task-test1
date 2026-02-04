//
//  CounterViewModel.swift
//  taskTest1
//
//  Created by Thisura Dodangoda on 2026-02-04.
//

import Combine

class CounterClassViewModel{
    
    @Published var counter: Int = 0
    
    func setCount(_ value: Int){
        counter = value
    }

}

/**
 TODO: This crashes
 Needs to be refactored (Actor ViewModel doesn't make sense - find a different use case -
 Example: Multi-state changes | UI reads from a Class / Actor ever 1 second to see it's values.
 
 2026-02-04 - Learnt the hard way that Actors are not meant to be ViewModels.
 Actors enforce async boundaries, and are great for tracking mutable state with it.
 BUT they are not great for coordinating (or as replacements for) UI elements
 because Actors are MEANT to be used in Async environments.
 
 Example use cases: Cache (image, data), Rate Limiter, Session manager, Analytics queue, etc.
 Read more:
 https://chatgpt.com/s/t_6982fc9e40d08191b33f607255ebe47c
 */
actor CounterActorViewModel{
    
    @Published var counter: Int = 0
    
    func setCount(_ value: Int){
        counter = value
    }
    
}
