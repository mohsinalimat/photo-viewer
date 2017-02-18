//
//  ViewController.swift
//  PhotoViewer
//
//  Created by Mohamed Hamed on 2/18/17.
//  Copyright © 2017 Mohamed Hamed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView

        if let vc = storyboard?.instantiateViewController(withIdentifier: "PhotoViewerViewController") as? PhotoViewerViewController {
            vc.image = tappedImage.image
            vc.allowedDismissDirection = .both
            vc.directionLock = false
            vc.maskType = InteractiveMaskType.black
            vc.showInteractive()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

