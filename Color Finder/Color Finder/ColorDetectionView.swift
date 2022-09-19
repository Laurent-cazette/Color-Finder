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
    let inputColor : Color
    @State var capturedImage: UIImage?

    var body: some View {
        let timerController = FrequencyController()
        var framesCount = 0
        ZStack {
            cameraView(cameraService: cameraService) { result in
                switch result {
                case .success(let photo):
                    if let data = photo.fileDataRepresentation() {
                        framesCount = framesCount + 1
                        if (framesCount > 20) {
                            cameraService.capturePhoto()
                            capturedImage = UIImage(data: data)
                            timerController.setTimer(Frequency: determineFrequency(inputImage: capturedImage!, inputColor: inputColor))
                            framesCount = 0
                        }
                    } else {
                        print("Error: no image data found")
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }
    }
}

func calculateFrequency(SelectedColor: [Float], foundColor: [Float]) -> Float {
    var difference: Float = 0.0
    difference = abs(SelectedColor[0] - foundColor[0]) + abs(SelectedColor[1] - foundColor[1]) + abs(SelectedColor[2] - foundColor[2])
    let differencePerrcentage = (300 - difference) / 3
    print(differencePerrcentage)
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
    print(Frequency)
    return Frequency
    
}
