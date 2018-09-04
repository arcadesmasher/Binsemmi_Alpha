//
//  ViewController.swift
//  Binsemmi-Alpha
//
//  Created by Deniz on 21.05.2017.
//  Copyright © 2017 Deniz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    private var isNavBarHidden : Bool = true
    private var navBarLoc : Float = -166
    private var isAnyOperationDone : Bool = false
    private var isCommentsViewOpen : Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navBarView.frame.origin.x = CGFloat(navBarLoc)
        navBarView.layer.shadowOpacity = 1
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        //imagePickerController metodundan sonra delegate buraya bağlı olduğu için viewDidAppear bir türlü açılıyor.
        //ilk ekranın açılmaması için isAnyOperationsDone flag'i eklendi.
        if isAnyOperationDone == false && isCommentsViewOpen == false
        {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "Dummy") as! DummyViewController
            containerView.addSubview(controller.view)
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //View Controller, ayrıca TextPlakaSorgu gibi viewlardan da çağırılmalı ki
    //TextPlakaSorgu'nun yaptığı gibi PlakaYorumList açılmaya çalışılırken
    //ViewController ezilmesin, ekranda tek hakim olan view PlakaYorumList olmasın.
    //bu flag bu yüzden tutulmakta.
    public func setIsCommentsViewOpen(sw : Bool)
    {
        isCommentsViewOpen = sw
    }
    
    @IBAction func menuButton_Clicked(_ sender: Any)
    {
        switch(isNavBarHidden)
        {
            case true:  isNavBarHidden = false
                        navBarLoc = 0
            case false: isNavBarHidden = true
                        navBarLoc = -166
        }
        
        //if navBar hidden kontrolünün konmasının sebebi, navBar'da kamera açıldıktan sonra isHidden = true olmasından.
        if(navBarView.isHidden)
        {
            navBarLoc = -166
            self.navBarView.frame.origin.x = CGFloat(navBarLoc)
            navBarView.isHidden = false
            navBarLoc = 0
            self.navBarView.frame.origin.x = CGFloat(navBarLoc)
        }
        UIView.animate(withDuration: 0.3, animations: { self.navBarView.frame.origin.x = CGFloat(self.navBarLoc) })
        
    }
    
    @IBAction func plakaEkle_Clicked(_ sender: Any)
    {
        isAnyOperationDone = true
        isNavBarHidden = true
        navBarLoc = -166
        UIView.animate(withDuration: 0.3, animations: { self.navBarView.frame.origin.x = CGFloat(self.navBarLoc) })
        containerView.willRemoveSubview(containerView.subviews[0])
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "Plaka Ekle") as! PlakaEkleViewController
        self.addChildViewController(controller)
        containerView.addSubview(controller.view)
    }
    
    @IBAction func plakaTarat_Clicked(_ sender: Any)
    {
        isAnyOperationDone = true
        isNavBarHidden = true
        navBarView.isHidden = isNavBarHidden
        containerView.willRemoveSubview(containerView.subviews[0])
        takePhoto()
    }

    @IBAction func plakaSorgula_Clicked(_ sender: Any)
    {
        isAnyOperationDone = true
        navBarLoc = -166
        UIView.animate(withDuration: 0.3, animations: { self.navBarView.frame.origin.x = CGFloat(self.navBarLoc) })
        containerView.willRemoveSubview(containerView.subviews[0])
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "Plaka Sorgula") as! TextPlakaSorgulaViewController
        self.addChildViewController(controller)
        containerView.addSubview(controller.view)
    }
    
    public func takePhoto()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        picker.dismiss(animated: true, completion: nil)
        containerView.willRemoveSubview(containerView.subviews[0])
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "Plaka Tarat") as! CameraSorgulaViewController
        controller.setImage(takenPhoto: pickedImage!)
        self.addChildViewController(controller)
        containerView.addSubview(controller.view)
    }
    
}

