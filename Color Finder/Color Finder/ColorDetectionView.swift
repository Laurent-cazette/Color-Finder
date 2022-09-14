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
