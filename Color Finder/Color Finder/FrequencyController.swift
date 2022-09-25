//
//  FrequencyController.swift
//  Color Finder
//
//  Created by Laurent Cazette on 16/09/2022.
//

import Foundation
import UIKit
import SwiftUI
import AVFoundation
import OSLog


class FrequencyController : UIViewController {
    var timer:Timer?
    let SystemSoundID: SystemSoundID = 1103
    var capturedImage : UIImage?
    let inputColor : Color?
    var cameraService: CameraService?
    
    init(camera: CameraService, Image: UIImage, Color: Color) {
        self.capturedImage = Image
        self.cameraService = camera
        self.inputColor = Color
        super.init(nibName: nil, bundle: nil)
        self.timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.timerLoop), userInfo: nil, repeats: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    deinit {
        self.timer?.invalidate()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    
//    func setTimer(Frequency: Double) {
//        var interval : Double
//        if(timer != nil) {
//            timer!.invalidate()
//            self.timer = nil
//        }
//        print("timer invalidate")
//        if(Frequency > 70) {
//            interval = 0.01
//        } else {
//            interval = 1.5
//        }
//        timer = Timer.scheduledTimer( timeInterval: interval, target: self, selector: #selector(self.timerLoop), userInfo: nil, repeats: false)
//    }
    
    @objc func timerLoop() {
        if(capturedImage != nil && inputColor != nil) {
            let croppedPicture = cropPicture(inputImage: capturedImage!)
            let pictureData = convertUIImageToFloat(inputImage: croppedPicture!)
            let colorData = convertColorToFloat(inputColor: inputColor!)
            let Frequency = Double(calculateFrequency(SelectedColor: colorData, foundColor: pictureData))
            print("frequency = ", Frequency)
            if(Frequency >= 70) {
                AudioServicesPlaySystemSound(SystemSoundID)
            }
        }
    }
    
    func calculateFrequency(SelectedColor: [Float], foundColor: [Float]) -> Float {
        var difference: Float = 0.0
        difference = abs(SelectedColor[0] - foundColor[0]) + abs(SelectedColor[1] - foundColor[1]) + abs(SelectedColor[2] - foundColor[2])
        let differencePerrcentage = (300 - difference) / 3
        if(differencePerrcentage < 70) {
            return 0
        }
        return differencePerrcentage
    }

    func determineFrequency(inputImage: UIImage, inputColor: Color) -> Double {
        let croppedImage = cropPicture(inputImage: inputImage)!
        let imageData = convertUIImageToFloat(inputImage: croppedImage)
        let colorData = convertColorToFloat(inputColor: inputColor)
        let Frequency = Double(calculateFrequency(SelectedColor: colorData, foundColor: imageData))
        return Frequency
        
    }
    
    func convertColorToFloat(inputColor: Color) -> [Float] {
        let resultArray: [Float] = [Float(inputColor.components!.r * 255), Float(inputColor.components!.g * 255), Float(inputColor.components!.b * 255), Float(inputColor.components!.a)]
        return resultArray
    }

    func convertUIImageToFloat(inputImage: UIImage) -> [Float] {
        var resultArray = [Float]()
        var red = CGFloat(0)
        var green = CGFloat(0)
        var blue = CGFloat(0)
        var alpha = CGFloat(0)

        inputImage.getPixelColor(pos: CGPoint(x: 0, y: 0)).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        resultArray.append(contentsOf: [Float(red * 255.0), Float(green * 255.0), Float(blue * 255.0), Float(alpha)])
        return resultArray
    }

    func cropPicture(inputImage: UIImage) -> UIImage? {
        let targetRect = CGRect(x: inputImage.size.width / 4,
                               y: inputImage.size.height / 4,
                               width: inputImage.size.width / 2,
                               height: inputImage.size.width / 2)
        
        guard let cutImageRef: CGImage = inputImage.cgImage?.cropping(to: targetRect) else {
            return nil
        }
        let croppedImage: UIImage = UIImage(cgImage: cutImageRef)
        return croppedImage
    }
}

extension UIImage {
      func getPixelColor(pos: CGPoint) -> UIColor {

          guard let pixelData = self.cgImage?.dataProvider?.data else {
              print("An error occured while trying to get the data of the picture")
              return UIColor(red: 0, green: 0, blue: 0, alpha: 100)
          }
          let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)

          let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4

          let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
          let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
          let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
          let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)

          return UIColor(red: r, green: g, blue: b, alpha: a)
      }
  }

extension Color {
    struct Components {
        var r, g, b, a: Float
    }
    
    var components: Components? {
        guard let components = UIColor(self).cgColor.components?.compactMap(Float.init),
              components.count == 4
        else { return nil}
        return Components(r: components[0], g: components[1], b: components[2], a: components[3])
    }
}
