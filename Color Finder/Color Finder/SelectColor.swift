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
    var TestImage : UIImage = UIImage(named: "car") ?? UIImage()
    var croppedPicture : UIImage
    init() {
        self.croppedPicture = cropPicture(inputImage: TestImage)!
    }
    var body: some View {
        NavigationView {
            VStack {
                ColorPicker("Select the wanted Color", selection: $bgColor)
                    .padding()
                NavigationLink("Search", destination: ColorDetectionView(capturedImage: $capturedImage))
                Image(uiImage: croppedPicture)
                    .resizable()
                    .onAppear {
                        var red = CGFloat(0)
                        var green = CGFloat(0)
                        var blue = CGFloat(0)
                        var alpha = CGFloat(0)
                        
                        croppedPicture.getPixelColor(pos: CGPoint(x: 0, y: 0)).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
                        print(Double(red/255), Double(green/255), Double(blue/255), Double(alpha))
                    }
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

extension UIImage {
      func getPixelColor(pos: CGPoint) -> UIColor {

          guard let pixelData = self.cgImage!.dataProvider?.data else {
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

struct SelectColor_Previews: PreviewProvider {
    static var previews: some View {
        SelectColor()
    }
}
