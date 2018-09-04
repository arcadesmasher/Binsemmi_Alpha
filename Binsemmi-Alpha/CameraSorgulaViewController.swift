//
//  CameraSorgulaViewController.swift
//  Binsemmi-Alpha
//
//  Created by Deniz on 23.05.2017.
//  Copyright © 2017 Deniz. All rights reserved.
//

import Foundation
import UIKit
import TesseractOCR

class CameraSorgulaViewController : UIViewController, UIImagePickerControllerDelegate, G8TesseractDelegate
{
    
    private var image = UIImage()
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad()
    {
        plakaTarat()
    }
    
    public func setImage(takenPhoto: UIImage)
    {
        image = takenPhoto
    }
    
    public func plakaTarat()
    {
        if let tesseract = G8Tesseract(language: "eng")
        {
            tesseract.delegate = self
            let tempImage = image.g8_grayScale().g8_blackAndWhite().g8_blackAndWhite().g8_blackAndWhite().g8_blackAndWhite().g8_blackAndWhite().g8_blackAndWhite().g8_blackAndWhite().g8_blackAndWhite()
            print("image ok")
            tesseract.image = tempImage
            print("tesseract got the resized image")
            tesseract.charWhitelist = "0123456789ABCDEFGHIJKLMNOPRQSTUVWXYZ"
            print("char white list ok")
            tesseract.recognize()
            print("recognition ok")
            label.text = tesseract.recognizedText
            print("text printing ok")
            print(tesseract.recognizedText)
            let plateNo = tesseract.recognizedText.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
            let dalOperations = DALOperations()
            dalOperations.setDriverComments(plateNo: plateNo, completionHandler: {(UIBackgroundFetchResult) -> Void in
                let driverComments = dalOperations.getDriverComments()
                if(driverComments.count < 1)
                {
                    let msgDisp = MessageDisplayer()
                    msgDisp.dispMessage(sender: self, mesaj: "Sorguladığınız plakaya dair veri bulunamadı...")
                }
                else
                {
                    //sadece PlakaYorumListeleController çağırılsaydı, ViewController ezilecekti
                    //yani yandaki menü asla gözükmeyecekti.
                    //bu yüzden önce view controller tekrar display edilir
                    //sonrasında ise PlakaYorumListeleController açılır.
                    let mainController = self.storyboard?.instantiateViewController(withIdentifier: "View Controller") as! ViewController
                    mainController.setIsCommentsViewOpen(sw: true)
                    self.present(mainController, animated: true, completion: nil)
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "Plaka Yorum Listele") as! PlakaYorumListeleController
                    controller.setDriverComments(drvComms: driverComments)
                    mainController.addChildViewController(controller)
                    mainController.containerView.addSubview(controller.view)
                }
            })
        }
    }
    
    func progressImageRecognition(for tesseract: G8Tesseract!)
    {
        //print("Progress: \(tesseract.progress)")
    }
    
}
