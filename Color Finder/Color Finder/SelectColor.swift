//
//  SelectColor.swift
//  Color Finder
//
//  Created by Laurent Cazette on 13/09/2022.
//

import SwiftUI

struct SelectColor: View {
    @State private var bgColor = Color(.sRGB, red: 0, green: 0, blue: 0)
    @State private var capturedImage: UIImage? = nil
    let TestImage = UIImage.init(named: "car")
    var body: some View {
        NavigationView {
            VStack {
                ColorPicker("Select the wanted Color", selection: $bgColor)
                    .padding()
                NavigationLink("Search", destination: ColorDetectionView(capturedImage: $capturedImage))
                Image(uiImage: cropPicture(inputImage: TestImage!) ?? UIImage())
                    .resizable()
            }
        }
        
    }
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

struct SelectColor_Previews: PreviewProvider {
    static var previews: some View {
        SelectColor()
    }
}
