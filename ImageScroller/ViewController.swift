//
//  ViewController.swift
//  ImageScroller
//
//  Created by Ian Li on 11/30/16.
//  Copyright © 2016 Ian Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var scrollView: UIScrollView!
    var imageView: UIImageView!
    var dataLabel: UILabel!
    var vLine: UIView!
    var hLine: UIView!
    var centralPoint: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.black
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        imageView = UIImageView(image: UIImage(named: "dragonball"))
        scrollView.contentSize = imageView.bounds.size
        
        dataLabel = UILabel(frame: CGRect(x: 10, y: 30, width: 0, height: 0))
        dataLabel.text = "Data gonna show here"
        dataLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        dataLabel.textColor = UIColor.white
        dataLabel.numberOfLines = 0
        dataLabel.sizeToFit()
        
        scrollView.delegate = self
        
        defautZoom(scrollView: scrollView, imageView: imageView)
        scrollView.zoomScale = scrollView.minimumZoomScale
        
        vLine = UIView(frame: CGRect(x: view.bounds.width/2, y: 0, width: 2, height: view.bounds.height))
        hLine = UIView(frame: CGRect(x: 0, y: view.bounds.height/2, width: view.bounds.width, height: 2))
        vLine.backgroundColor = UIColor.red
        hLine.backgroundColor = UIColor.red
        
        
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        view.addSubview(dataLabel)
        view.addSubview(vLine)
        view.addSubview(hLine)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillLayoutSubviews() {
        //print("rotated")
        //print("views: \(view.bounds)")
        //print("scrollView: \(scrollView.bounds)")
        
    
        defautZoom(scrollView: scrollView, imageView: imageView)
        if(scrollView.zoomScale<scrollView.minimumZoomScale){
            scrollView.zoomScale = scrollView.minimumZoomScale
        }
        arrangeToCenter(scrollView: scrollView, imageView: imageView)
        

        vLine.frame = CGRect(x: view.bounds.width/2, y: 0, width: 2, height: view.bounds.height)
        hLine.frame = CGRect(x: 0, y: view.bounds.height/2, width: view.bounds.width, height: 2)
        
        //this line is IMPORTANT
        let ph = centralPoint.y - scrollView.bounds.height/2
       
        scrollView.contentOffset.x = centralPoint.x - scrollView.bounds.width/2
        scrollView.contentOffset.y = ph
       
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func defautZoom(scrollView: UIScrollView, imageView: UIImageView){
        let width = scrollView.bounds.width/imageView.bounds.width
        let height = scrollView.bounds.height/imageView.bounds.height
        let mini = min(width, height)
        
        scrollView.minimumZoomScale = mini
        scrollView.maximumZoomScale = 3
    }
    
    func arrangeToCenter(scrollView: UIScrollView, imageView: UIImageView){
        let vSpace = (imageView.frame.height<scrollView.frame.height) ?
        (scrollView.bounds.height-imageView.frame.height)/2 : 0
        
        let hSpace = (imageView.frame.width<scrollView.frame.width) ?
            (scrollView.bounds.width-imageView.frame.width)/2 : 0
        scrollView.contentInset = UIEdgeInsets.init(top: vSpace, left: hSpace, bottom: vSpace, right: hSpace)
    }
    
    func getCentralPoint(scrollView: UIScrollView){
        print(scrollView.contentOffset)
        let x = scrollView.contentOffset.x + scrollView.bounds.width/2
        let y = scrollView.contentOffset.y + scrollView.bounds.height/2
        centralPoint = CGPoint(x: x, y: y)
        
    }
}

extension ViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrolled")
        dataLabel.text = "Offest: \(scrollView.contentOffset) \n"+"Zoom: \(scrollView.zoomScale)"
        dataLabel.sizeToFit()
        arrangeToCenter(scrollView: scrollView, imageView: imageView)
        getCentralPoint(scrollView: scrollView)
    }
}
