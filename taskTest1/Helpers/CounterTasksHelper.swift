//
//  CounterTasksHelper.swift
//  taskTest1
//
//  Created by Thisura Dodangoda on 2026-02-04.
//
import Foundation

class CounterTasksHelper{
    
    private var taskId = 0
    
    private func getTaskId() -> Int{
        let id = taskId
        taskId += 1
        return id
    }
    
    func generateCounterTask(_ intervalInMs: Int, _ delay: Int, _ notifier: @escaping (CounterTaskParam) -> Void) -> Task<Void, Never>{
        let taskId = getTaskId()
        return Task.detached {
            do{
                try await Task.sleep(for: .seconds(delay))
                for _ in 0..<Int.max {
                    let polarity = Int.random(in: 1..<5).quotientAndRemainder(dividingBy: 2).remainder == 0 ? 1 : -1
                    let count = Int.random(in: 1...20) * polarity
                    try await Task.sleep(for: .milliseconds(intervalInMs))
                    
                    // print("From thread \(Thread.current.description) (is this the main thread? \(Thread.isMainThread)): Notifiying \(count)")
                    let params = CounterTaskParam(count: count, taskId: taskId)
                    notifier(params)
                }
            }
            catch{
                print("Counter task canceled or stopped!")
            }
        }
    }
    
    func generateMultipleCounterTasks(_ limit: Int, _ intervalInMs: Int, _ delay: Int, _ notifier: @escaping (CounterTaskParam) -> Void) -> TaskCollection{
        var tasks: [Task<Void, Never>] = []
        
        for _ in 0..<limit {
            tasks.append(generateCounterTask(intervalInMs, delay, notifier))
        }
        
        return TaskCollection(tasks: tasks)
    }
    
}
