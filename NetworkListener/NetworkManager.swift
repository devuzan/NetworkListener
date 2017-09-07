//
//  NetworkManager.swift
//  Listener
//
//  Created by Yusuf U on 07/09/2017.
//  Copyright © 2017 Mobixoft. All rights reserved.
//

import UIKit

protocol NetworkManagerListener: class {
    
    func networkStatusChanged(status: Reachability.NetworkStatus)
}


class NetworkManager: NSObject{
    
    static let sharedInstance = NetworkManager()
    private let reachability = Reachability()!
    private var listeners = [NetworkManagerListener]()

    private override init() { }
    
    func statusChanged(notification: Notification) {

        guard let reachability = notification.object as? Reachability else { return }
        switch reachability.currentReachabilityStatus {
        case .notReachable:
            debugPrint("No network")
        case .reachableViaWiFi:
            debugPrint("Wifi")
        case .reachableViaWWAN:
            print("Wan")
        }
        
        for listener in listeners{
            listener.networkStatusChanged(status: reachability.currentReachabilityStatus)
        }
    }

    
    func startMonitoring() {
        
        do {
            try reachability.startNotifier()
        }catch {
            print("Notifier start error!")
        }
        NotificationCenter.default.addObserver(self, selector: #selector(NetworkManager.statusChanged(notification:)), name: ReachabilityChangedNotification, object: reachability)
    }
    
    func stopMonitoring() {
        
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: reachability)
    }
    
    func addListener(listener: NetworkManagerListener) {
        
        startMonitoring()
        listeners.append(listener)
    }
    
    func removeListener(listener: NetworkManagerListener) {
        
        stopMonitoring()
        listeners = listeners.filter { $0 !== listener }
        
    }
    

}


