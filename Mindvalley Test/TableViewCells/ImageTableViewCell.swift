//
//  ImageTableViewCell.swift
//  Mindvalley Test
//
//  Created by Venugopalan, Vimal on 12/2/18.
//  Copyright © 2018 Venugopalan, Vimal. All rights reserved.
//

import UIKit
import CellAnimator

class ImageTableViewCell: UITableViewCell {
    @IBOutlet weak var rawImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var indicator:UIActivityIndicatorView!

    
    func setCellData(data:ImageDataModel, forIndex index:Int){
        self.rawImageView.image = getImageWithColor(color: .white, size: self.rawImageView.frame.size)
        self.indicator.startAnimating()
        if let imageURL = data.imageUrl{
            self.setImage(url: imageURL, completionHandler: {[unowned self] image in
                DispatchQueue.main.async {
                    if index == 2{
                        print("error")
                    }
                    if(self.tag == index) {
                        self.rawImageView.image = image
                        CellAnimator.animateCell(cell: self, withTransform: CellAnimator.TransformWave, andDuration: 1)

                        self.indicator.stopAnimating()
                        self.indicator.isHidden = true
                    }
                }
            })
        }
        self.likesLabel.text = String.init(format: "Likes: %d", data.likes ?? "")
        if let date = data.createdAt{
            self.createdAtLabel.text = String.init(format: "Created: %@", date.timeAgo(numericDates: true))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setImage(url:URL, completionHandler:@escaping (UIImage)->Void){
        CacheAPI.downloadImages(url:url, completion: {(image, error) in
            if error != nil{
                if let image = UIImage.init(named: "noImageAvailable"){
                    completionHandler(image)
                }
            }
            if let downloadedImage = image{
                completionHandler(downloadedImage)
            }
            else{
                if let image = UIImage.init(named: "noImageAvailable"){
                    completionHandler(image)
                }
            }
            
        })
        
    }
    
    func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }

}
