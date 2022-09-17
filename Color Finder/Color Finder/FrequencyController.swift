//
//  FrequencyController.swift
//  Color Finder
//
//  Created by Laurent Cazette on 16/09/2022.
//

import Foundation
import UIKit

class FrequencyController : NSObject {
    private var timer : Timer?
    
    override init() {
        super.init()
        
        self.timer = Timer.scheduledTimer( timeInterval: 3, target: self, selector: #selector(self.playBip), userInfo: nil, repeats: true)
    }
    
    func setTimer(Frequency: Double) {
        self.timer!.invalidate()
        self.timer = Timer.scheduledTimer( timeInterval: 0, target: self, selector: #selector(self.playBip), userInfo: nil, repeats: false)
    }
    
    @objc func playBip() {
        print ("bip")
    }
}
