//
//  MemeCollectionViewController.swift
//  MemeMePart2
//
//  Created by Gabriele on 4/3/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController{
    
    var memes: [Meme]!
    @IBOutlet var memeCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CustomMemeCell", forIndexPath: indexPath) as! CustomMemeViewCell
        let meme = self.memes[indexPath.row]
        
        cell.memeLabel.text = meme.topText
        cell.memeImageView.image = meme.memedImage
        
        return cell
    }
    

}
