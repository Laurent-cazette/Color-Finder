//
//  ColorDetection.swift
//  Color Finder
//
//  Created by Laurent Cazette on 13/09/2022.
//
import SwiftUI

struct ColorDetectionView: View {
    
    let cameraService = CameraService()
    let timerController = FrequencyController()
    @Binding var capturedImage: UIImage?
    
    var body: some View {
        var framesCount = 0
        let TestImage : UIImage = UIImage(named: "car") ?? UIImage()
        ZStack {
            cameraView(cameraService: cameraService) { result in
                switch result {
                case .success(let photo):
                    if let data = photo.fileDataRepresentation() {
                        framesCount = framesCount + 1
                        if (framesCount > 20) {
                            capturedImage = UIImage(data: data)
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
        .onAppear() {
//            timerController.setTimer(Frequency: Double(calculateFrequency(SelectedColor: [100, 100, 100, 1], foundColor: convertUIImageToFloat(inputImage: TestImage))))
//            print("timer set")
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
