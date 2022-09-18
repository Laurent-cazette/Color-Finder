//
//  SelectColor.swift
//  Color Finder
//
//  Created by Laurent Cazette on 13/09/2022.
//

import SwiftUI

struct SelectColor: View {
    @State private var bgColor = Color(.sRGB, red: 0, green: 0, blue: 0)
    var TestImage : UIImage = UIImage(named: "car") ?? UIImage()
    var croppedPicture : UIImage
    init() {
        self.croppedPicture = cropPicture(inputImage: TestImage)!
    }
    var body: some View {
        VStack {                ColorPicker("Select the wanted Color", selection: $bgColor)
                .padding()
            NavigationLink("Search", destination: ColorDetectionView(inputColor: bgColor))
        }
    }
}

func convertColorToFloat(inputColor: Color) -> [Float] {
    let resultArray: [Float] = [Float(inputColor.components!.r * 255), Float(inputColor.components!.g * 255), Float(inputColor.components!.b * 255), Float(inputColor.components!.a)]
    return resultArray
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

extension Color {
    struct Components {
        var r, g, b, a: Float
    }
    
    var components: Components? {
        guard let components = UIColor(self).cgColor.components?.compactMap(Float.init),
              components.count == 4
        else { return nil}
        return Components(r: components[0], g: components[1], b: components[2], a: components[3])
    }
}

struct SelectColor_Previews: PreviewProvider {
    static var previews: some View {
        SelectColor()
    }
}
