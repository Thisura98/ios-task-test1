//
//  TaskRunner.swift
//  taskTest1
//
//  Created by Thisura Dodangoda on 2026-02-03.
//

class TaskRunner{
    
    public func createAndRunTask() -> Task<Void, Never>{
        
        let task = Task{
            await demoTask()
        }
        
        return task
        
    }
    
    private func demoTask() async{
        for i in 0..<20{
            print("demoTask: \(i)")
            do{
                try await Task.sleep(for: .seconds(1))
            }
            catch is CancellationError{
                print("Task was canceled!")
                break
            }
            catch{
                print("Task throw an unhandled error \(error)")
                break
            }
        }
    }
    
}
