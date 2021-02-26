//
//  items.swift
//  NewsSearch
//
//  Created by karlis.stekels on 22/02/2021.
//

import UIKit
import Gloss

class Items: JSONDecodable {
    
    var status: String
    var title: String
    var description: String
    var url: String
    var name: String?
    var urlToImage: String
    var image: UIImage?
    
    required init?(json: JSON) {
        self.status =       "status" <~~ json ?? ""
        self.title =        "title" <~~ json ?? ""
        self.description =  "description" <~~ json ?? ""
        self.url =          "url" <~~ json ?? ""
        self.name =         "name" <~~ json ?? ""
        self.urlToImage =   "urlToImage" <~~ json ?? ""
        
        DispatchQueue.main.async {
            self.image = self.compressedImage()
        }
    }
    
    //MARK: - Solution from Stack Overflow
    func compressedImage() -> UIImage {
        let returnImage = UIImage(named: "noImage")
        
        guard URL(string: urlToImage) != nil else {
            return returnImage!
        }
    
        let image = UIImage(data: try! Data(contentsOf: URL(string: urlToImage)!))
        guard image != nil else {
            return returnImage!
        }
        
        let thumb = image?.resized(withPercentage: 0.40)
        return thumb!
    }
}

//MARK: - Stack Overflow
extension UIImage {
    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}
