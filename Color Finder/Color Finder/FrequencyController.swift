//
//  FrequencyController.swift
//  Color Finder
//
//  Created by Laurent Cazette on 16/09/2022.
//

import Foundation
import UIKit
import AVFoundation


class FrequencyController : UIViewController {
    private var timer : Timer?
    let SystemSoundID: SystemSoundID = 1103
    
        init() {
            super.init(nibName: nil, bundle: nil)
            self.timer = Timer.scheduledTimer( timeInterval: 1, target: self, selector: #selector(self.playBip), userInfo: nil, repeats: true)
        }

        override func viewDidLoad() {
            super.viewDidLoad()

        }
    
    deinit {
        self.timer?.invalidate()
    }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) is not supported")
        }

    
    func setTimer(Frequency: Double) {
        self.timer!.invalidate()
        self.timer = Timer.scheduledTimer( timeInterval: abs(Frequency / 1000 - 1), target: self, selector: #selector(self.playBip), userInfo: nil, repeats: true)
    }
    
    @objc func playBip() {
        AudioServicesPlaySystemSound(SystemSoundID)
    }
}
