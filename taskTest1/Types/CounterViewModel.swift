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

actor CounterActorViewModel{
    
    @Published var counter: Int = 0
    
    func setCount(_ value: Int){
        counter = value
    }
    
}
