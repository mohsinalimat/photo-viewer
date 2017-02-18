//
//  PhotoViewerViewController.swift
//  PhotoViewer
//
//  Created by Mohamed Hamed on 2/18/17.
//  Copyright © 2017 Mohamed Hamed. All rights reserved.
//

import UIKit

class PhotoViewerViewController: InteractiveViewController , UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var actionView: UIView!
   
    
    var image : UIImage!
    var navigationBar: UINavigationBar?

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        initScrollView()
        initNavbar()
        
    }
    
    func doneTapped(sender: Any) {
        dismiss(animated: true) { 
          print("dismissd")
        }
    }
    
    func initNavbar() {
        navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 44))
        self.view.addSubview(navigationBar!);
        let navItem = UINavigationItem(title: "");
        navigationBar?.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        navigationBar?.tintColor = .white
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action:  #selector(doneTapped(sender:)))
        navItem.rightBarButtonItem = doneButton
        
        navigationBar?.setItems([navItem], animated: false);
        transparentNavbar(bar: navigationBar!)
    }
    
    func transparentNavbar(bar: UINavigationBar) {
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
    }
    
    //Mark ScrollView
    func initScrollView() {
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        //Double Tap Zoom
        let doubleTap = UITapGestureRecognizer(target: self, action:  #selector(handleDoubleTapScrollView(recognizer:)))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
        //Single Tap 
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleSingleTapScrollView(recognizer:)))
        singleTap.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(singleTap)
        
        singleTap.require(toFail: doubleTap)
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        hideViews(hidden: true , withAnimation: false)
    }
    func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {
        if scrollView.zoomScale == 1 {
            scrollView.zoom(to: zoomRectForScale(scale: scrollView.maximumZoomScale, center: recognizer.location(in: recognizer.view)), animated: true)
            hideViews(hidden: true, withAnimation: false)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }
    
    func handleSingleTapScrollView(recognizer: UITapGestureRecognizer) {
        if scrollView.zoomScale == 1 {
            hideViews(hidden: !actionView.isHidden)
        } else {
            UIView.animate(withDuration: 1, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                 self.scrollView.zoomScale = 1
            }, completion: { (void) in
                self.hideViews(hidden: false)
            })
        }
    }
    
    func hideViews(hidden: Bool , withAnimation: Bool = true) {
        
        if withAnimation == true {
            UIView.transition(with: view, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {() -> Void in
                self.actionView.isHidden = hidden
                self.navigationBar?.isHidden = hidden
            }, completion: { _ in })
        } else {
            self.actionView.isHidden = hidden
            self.navigationBar?.isHidden = hidden
        }
    }
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imageView.frame.size.height / scale
        zoomRect.size.width  = imageView.frame.size.width  / scale
        let newCenter = imageView.convert(center, from: scrollView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
