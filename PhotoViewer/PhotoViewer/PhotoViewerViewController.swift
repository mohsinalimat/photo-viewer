//
//  PhotoViewerViewController.swift
//  PhotoViewer
//
//  Created by Mohamed Hamed on 2/18/17.
//  Copyright © 2017 Mohamed Hamed. All rights reserved.
//

import UIKit

class PhotoViewerViewController: InteractiveViewController {

    @IBOutlet weak var imageView: UIImageView!
    var image : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
