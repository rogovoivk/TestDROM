//
//  CollectionViewCell.swift
//  TestDROM
//
//  Created by Vladoslav on 26.07.2022.
//

import UIKit

class CustomCollectionCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionCell"

    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = nil
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true

        return imageView
    }()
    
    private var imageURL: URL?
    

    let imageCeche = NSCache<NSURL, UIImage>()
    
    func setupURL(url: URL) {
        
        imageURL = url
        let nsUrl = NSURL(string: url.absoluteString)
        print("nsUrl: \(nsUrl)")
        
        imageView.image = nil
        print(nsUrl!)
        if let immageFromCache = imageCeche.object(forKey: nsUrl!){
            if nsUrl!.absoluteString == "https://www.bfoto.ru/foto/river/bfoto_ru_4763.jpg"{
                print("няяяяяяяяя")
            }
            self.imageView.image = immageFromCache
            return
        }
        
        if let imgUrl = imageURL {
            
            URLSession.shared.dataTask(with: imgUrl, completionHandler: { data, response, error in
                if error != nil {
                    print(error)
                    return
                }
                
                DispatchQueue.main.async{
                    let imageToCache = UIImage(data: data!)
                    self.imageCeche.setObject(imageToCache!, forKey: nsUrl!)
                    
                    self.imageView.image = imageToCache
                    print("url: \(imgUrl)")
                    
                    self.addSubview(self.imageView)
                    
                    self.imageView.isHidden = false
                    self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
                    self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
                    self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
                    self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
                }
            }).resume()
            
           
        }
        
        
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .purple
        
    }
    
}

