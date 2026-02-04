//
//  TaskCollection.swift
//  taskTest1
//
//  Created by Thisura Dodangoda on 2026-02-04.
//

import Foundation

class TaskCollection{
    
    var tasks: [Task<Void, Never>] = []
    
    init(tasks: [Task<Void, Never>]) {
        self.tasks = tasks
    }
    
    func cancelAll(){
        for task in tasks {
            task.cancel()
        }
        tasks.removeAll(keepingCapacity: false)
    }
    
}
