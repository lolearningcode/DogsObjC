//
//  CAPDetailViewController.swift
//  DogsObjC
//
//  Created by Lo Howard on 5/22/19.
//  Copyright © 2019 Lo Howard. All rights reserved.
//

import UIKit

class CAPDetailViewController: UIViewController {

    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var dogNameLabel: UILabel!
    
    @objc var dogImageURL: NSURL? {
        didSet {
            loadViewIfNeeded()
            
            CAPBreedNetworkClient.shared().fetchImageData((dogImageURL as URL?)!, completion: { (data, error) in
//                guard let data = data else {return}
                DispatchQueue.main.async {
                    self.dogImageView.image = UIImage(data: data)
                }
            })
        }
    }
    
    @objc var breed: CAPDogs?{
        didSet{
            loadViewIfNeeded()
            dogNameLabel.text = breed?.name.capitalized
        }
    }

    @objc var subBreed: CAPDogSubBreed?{
        didSet{
            loadViewIfNeeded()
            guard let subBreedName = subBreed?.name,
                let breedName = breed?.name else {return}
            dogNameLabel.text = "\(subBreedName) \(breedName)".capitalized
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
