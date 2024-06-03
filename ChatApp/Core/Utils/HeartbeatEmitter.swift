//
//  HeartbeatEmitter.swift
//  ChatApp
//
//  Created by Jason Ngo on 21/05/2024.
//

import Foundation

protocol HeartbeatModifier {
    func beat()
}

class HeartbeatEmitter {
    
    private var timer: Timer!
    var delegate: HeartbeatModifier?
    
    init() {
        setupTimer()
    }
    
    func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(notifyDelegate), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common)
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    @objc
    func notifyDelegate() {
        delegate?.beat()
    }
}
