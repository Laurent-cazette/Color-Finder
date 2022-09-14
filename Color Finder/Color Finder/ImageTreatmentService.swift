//
//  ImageTreatmentService.swift
//  Color Finder
//
//  Created by Laurent Cazette on 14/09/2022.
//

import SwiftUI

class ImageTreatmentService {

    
    
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
