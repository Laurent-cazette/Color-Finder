//
//  ColorDetection.swift
//  Color Finder
//
//  Created by Laurent Cazette on 13/09/2022.
//
import SwiftUI

struct ColorDetectionView: View {
    
    let cameraService = CameraService()
    @Binding var capturedImage: UIImage?
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        ZStack {
            cameraView(cameraService: cameraService) { result in
                switch result {
                case .success(let photo):
                    if let data = photo.fileDataRepresentation() {
                        capturedImage = UIImage(data: data)
                        print(convertUIColorToInt(inputImage: capturedImage!))
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
    //si la différence est supérieur à 10% return 0
    difference = abs(SelectedColor[0] - foundColor[0]) + abs(SelectedColor[1] - foundColor[1]) + abs(SelectedColor[2] - foundColor[2])
    let differencePourcentage = (300 - difference) / 3
    return differencePourcentage
}
