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
    let ImageTreatmentService: ImageTreatmentService
    let TestImage = UIImage.init(named: "car")
    @State private var croppedImage: UIImage? = nil
    init(service: ImageTreatmentService) {
        self.ImageTreatmentService = service
        
        croppedImage = ImageTreatmentService.cropPicture(inputImage: TestImage ?? UIImage())!
    }
    var body: some View {
        NavigationView {
            VStack {
                ColorPicker("Select the wanted Color", selection: $bgColor)
                    .padding()
                NavigationLink("Search", destination: ColorDetectionView(capturedImage: $capturedImage))
                Image(uiImage: croppedImage!)
                
            }
        }
        
    }
}
                      
struct SelectColor_Previews: PreviewProvider {
    static var ImageTreatmentService: ImageTreatmentService?
    static var previews: some View {
        SelectColor(service: ImageTreatmentService!)
    }
}
