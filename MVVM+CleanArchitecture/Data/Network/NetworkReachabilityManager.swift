//
//  NetworkReachabilityManager.swift
//  MVVM+CleanArchitecture
//
//  Created by Aruna Udayanga on 31/08/2024.
//

import Network
import Combine

class NetworkReachabilityManager: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkReachabilityMonitor")
    
    @Published var isConnected: Bool = true
    private var cancellables = Set<AnyCancellable>()
    
    var onConnected: (() -> Void)?

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
                if path.status == .satisfied {
                    self?.onConnected?()
                }
            }
        }
        monitor.start(queue: queue)
    }
    
    deinit {
        monitor.cancel()
    }
}
