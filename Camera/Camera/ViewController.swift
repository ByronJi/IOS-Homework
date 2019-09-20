//
//  ViewController.swift
//  Camera
//
//  Created by Byron on 2019/5/10.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MobileCoreServices


class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var takePictureButton: UIButton!
    var avPlayerVC:AVPlayerViewController!
    var image:UIImage?
    var movieURL:URL?
    var lastChosenMediaType:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            takePictureButton.isHidden = true
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateDisplay()
    }
    
    @IBAction func shootPictureOrVideo(sender:UIButton){
        pickMediaFromSource(UIImagePickerController.SourceType.camera)
    }
    
    @IBAction func selectExistingPictureOrVideo(sender:UIButton){
        pickMediaFromSource(UIImagePickerController.SourceType.photoLibrary)
    }

    func updateDisplay(){
        if let mediaType = lastChosenMediaType{
            if mediaType == (kUTTypeImage as NSString) as String
            {
                imageView.image = image!
                imageView.isHidden = false
                if avPlayerVC != nil {
                    avPlayerVC!.view.isHidden = true
                }
            } else if mediaType == (kUTTypeMovie as NSString) as String{
                if avPlayerVC == nil {
                    avPlayerVC = AVPlayerViewController()
                    let avPlayerView = avPlayerVC!.view
                    avPlayerView?.frame = imageView.frame
                    avPlayerView?.clipsToBounds = true
                    view.addSubview(avPlayerView!)
                    setAVPlayerViewLayoutConstraits()
                    
                }
                
                if let url = movieURL{
                    imageView.isHidden = true
                    avPlayerVC.player = AVPlayer(url: url)
                    avPlayerVC!.view.isHidden = false
                    avPlayerVC!.player!.play()
                }
            }
        }
    }
    
    func setAVPlayerViewLayoutConstraits(){
        let avPlayerView = avPlayerVC!.view
        avPlayerView?.translatesAutoresizingMaskIntoConstraints = false
        let views = ["avPlayerView":avPlayerView!,"takePictureButton":takePictureButton!]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[avPlayerView]|", options: .alignAllLeft, metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[avPlayerView]-O-[takePictureButton]|", options: .alignAllLeft, metrics: nil, views: views))
    }
    
    func pickMediaFromSource(_ sourceType:UIImagePickerController.SourceType){
        let mediaTypes =  UIImagePickerController.availableMediaTypes(for: sourceType)!
        if UIImagePickerController.isSourceTypeAvailable(sourceType) && mediaTypes.count > 0{
            let picker = UIImagePickerController()
            picker.mediaTypes = mediaTypes
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = sourceType
            present(picker,animated: true,completion: nil)
        } else {
            let alertController = UIAlertController(title: "Error acess meida", message: "Unsuported Media source", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(OKAction)
            present(alertController,animated: true,completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        lastChosenMediaType = info[UIImagePickerController.InfoKey.mediaType] as? String
        if let mediaType = lastChosenMediaType{
            if mediaType == (kUTTypeImage as NSString) as String{
                image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            } else if mediaType == (kUTTypeMovie as NSString) as String{
                movieURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL
            }
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

