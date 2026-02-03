//
//  TaskStatus.swift
//  taskTest1
//
//  Created by Thisura Dodangoda on 2026-02-03.
//

import Foundation

enum TaskStatus{
    case initial
    case creating
    case running
    case stopped
    
    func toString() -> String{
        return String(describing: self).capitalized
    }
}
