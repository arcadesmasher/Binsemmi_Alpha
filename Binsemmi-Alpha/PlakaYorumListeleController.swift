//
//  PlakaYorumListeleController.swift
//  Binsemmi-Alpha
//
//  Created by Deniz on 26.06.2017.
//  Copyright © 2017 Deniz. All rights reserved.
//

import Foundation
import UIKit

class PlakaYorumListeleController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    var comments : [BnsCommentData] = []
    //
    @IBOutlet weak var colView: UICollectionView!
    @IBOutlet weak var plateNo: UILabel!
    @IBOutlet weak var averageScore: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        colView.dataSource = self
        colView.delegate = self
        plateNo.text = comments[0].GetPlateNo()
        averageScore.text = "\(getAverageScore())"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func setDriverComments(drvComms : [BnsCommentData])
    {
        comments = drvComms
    }
    
    private func getAverageScore() -> Int
    {
        var retInt = 0
        for i in 0 ... comments.count - 1
        {
            retInt += comments[i].GetDriverPoint()
        }
        return retInt / comments.count
    }
    
    // MARK: - UICollectionViewDataSource protocol
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.comments.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        // get a reference to our storyboard cell

        let cell = colView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CommentsCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.location.text = self.comments[indexPath.item].GetStreet() + ", " +
                            self.comments[indexPath.item].GetTown() + ", " +
                            self.comments[indexPath.item].GetRegion() + "," +
                            self.comments[indexPath.item].GetCity()
        cell.score.text = "\(self.comments[indexPath.item].GetDriverPoint())"
        cell.comments.text = self.comments[indexPath.item].GetComment()
        cell.user.text = self.comments[indexPath.item].GetCommentator()
        
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.black.cgColor
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        let plate = plateNo.text
        let comms = (collectionView.cellForItem(at: indexPath) as! CommentsCollectionViewCell).comments.text
        let loc = (collectionView.cellForItem(at: indexPath) as! CommentsCollectionViewCell).location.text
        let scr = (collectionView.cellForItem(at: indexPath) as! CommentsCollectionViewCell).score.text
        let commentator = (collectionView.cellForItem(at: indexPath) as! CommentsCollectionViewCell).user.text
        
        var bilgiMesaji = "Sorguladığınız plakaya dair bilgiler aşağıdadır.\n"
        bilgiMesaji += "Plaka No: " + plate! + "\n"
        bilgiMesaji += "Rastlandığı lokasyon: " + loc! + "\n"
        bilgiMesaji += "Yorumlar: " + comms! + "\n"
        bilgiMesaji += "Yorumu yapan: " + commentator! + "\n"
        bilgiMesaji += "Sürücü puanı: " + scr! + "\n"

        let msgDisp = MessageDisplayer()
        msgDisp.dispMessage(sender: self, mesaj: bilgiMesaji)
        
    }
    
}

class CommentsCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var user: UILabel!
}
