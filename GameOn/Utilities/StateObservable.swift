//
//  StateObservable.swift
//  GameOn
//
//  Created by Andika on 10/08/21.
//

import Foundation
import Network

class StateObservable: ObservableObject {
    // MARK: - Constant
    static let shared = StateObservable()
    let monitor = NWPathMonitor()
    let queue = DispatchQueue.global(qos: .background)

    // MARK: - Publisher
    @Published var connection: NWPath.Status = .satisfied
    @Published var passedOnBoarding: Bool

    // MARK: - Initializer
    init() {
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
            passedOnBoarding = true
        } else {
            passedOnBoarding = false
        }

        monitor.start(queue: queue)

        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                OperationQueue.main.addOperation {
                    self.connection = .satisfied
                }
            } else {
                OperationQueue.main.addOperation {
                    self.connection = .unsatisfied
                }
            }
        }
    }

    func passOnboarding() {
        UserDefaults.standard.set(true, forKey: "passed_onboarding")
    }
}
