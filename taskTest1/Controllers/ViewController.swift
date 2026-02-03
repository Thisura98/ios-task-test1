//
//  ViewController.swift
//  taskTest1
//
//  Created by Thisura Dodangoda on 2026-02-03.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var startButton: UIButton!
    @IBOutlet private weak var stopButton: UIButton!
    
    private let taskRunner = TaskRunner()
    private var currentTask: Task<Void, Never>?
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var status: TaskStatus = .initial
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        $status
            .sink { [weak self] status in self?.statusLabel.text = status.toString() }
            .store(in: &cancellables)
        
        $status
            .map { $0 != .running }
            .assign(to: \.isEnabled, on: startButton)
            .store(in: &cancellables)
        
        $status
            .map { $0 == .running }
            .assign(to: \.isEnabled, on: stopButton)
            .store(in: &cancellables)
    }

    @IBAction func startButtonTapped(_ sender: Any) {
        status = .creating
        currentTask = taskRunner.createAndRunTask()
        status = .running
    }
    
    @IBAction func stopButtonTapped(_ sender: Any) {
        status = .stopped
        currentTask?.cancel()
    }
}

