//
//  ColorDetection.swift
//  Color Finder
//
//  Created by Laurent Cazette on 13/09/2022.
//
import SwiftUI
import Foundation
import os.log

struct ColorDetectionView: View {
    
    let cameraService = CameraService()
    let inputColor : Color?
    @State var capturedImage : UIImage? = UIImage.imageWithSize(size: CGSize(width: 1, height: 1))
    
    var body: some View {
        var timerController = FrequencyController(camera: cameraService, Image: capturedImage!, Color: inputColor!)
        ZStack {
            cameraView(cameraService: cameraService) { result in
                switch result {
                case .success(let photo):
                    os_log("%{public}@", log: OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "application"), type: OSLogType.debug, "Photo OK")
                    if let data = photo.fileDataRepresentation() {
                        capturedImage = UIImage(data: data)
                    } else {
                        print("Error: no image data found")
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
//            if capturedImage != nil {
//                Image(uiImage: capturedImage!)
//            }
        }
        .onAppear() {
            cameraService.capturePhoto()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                testCapturePhoto()
                }
            }
        }

    func testCapturePhoto() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            print(convertUIImageToFloat(inputImage: capturedImage!))
            cameraService.capturePhoto()
            testCapturePhoto()
        }
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
}

extension UIImage {
     static func imageWithSize(size : CGSize, color : UIColor = UIColor.white) -> UIImage? {
         var image:UIImage? = nil
         UIGraphicsBeginImageContext(size)
         if let context = UIGraphicsGetCurrentContext() {
               context.setFillColor(color.cgColor)
               context.addRect(CGRect(origin: CGPoint.zero, size: size));
               context.drawPath(using: .fill)
               image = UIGraphicsGetImageFromCurrentImageContext();
        }
        UIGraphicsEndImageContext()
        return image
    }
}
