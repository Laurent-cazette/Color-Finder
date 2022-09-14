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
    var body: some View {
        NavigationView {
            VStack {
                ColorPicker("Select the wanted Color", selection: $bgColor)
                    .padding()
                NavigationLink("Search", destination: ColorDetectionView(capturedImage: $capturedImage))
                Image("car")
                    .resizable()
            }
        }
        
    }
}

struct SelectColor_Previews: PreviewProvider {
    static var previews: some View {
        SelectColor()
    }
}
