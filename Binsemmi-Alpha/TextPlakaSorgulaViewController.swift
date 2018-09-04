//
//  TextPlakaSorgulaViewController.swift
//  Binsemmi-Alpha
//
//  Created by Deniz on 22.05.2017.
//  Copyright © 2017 Deniz. All rights reserved.
//

import Foundation
import UIKit

class TextPlakaSorgulaViewController : UIViewController, UITextViewDelegate
{
    
    @IBOutlet weak var txtPlateNo: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.txtPlateNo.delegate = self as? UITextFieldDelegate
    }
    
    @IBAction func gonder_Clicked(_ sender: Any)
    {
        let dalOperations = DALOperations()
        dalOperations.setDriverComments(plateNo: txtPlateNo.text!, completionHandler: {(UIBackgroundFetchResult) -> Void in
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField : UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    
}
