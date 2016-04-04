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
        
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: #selector(MemeCollectionViewController.addMeme))
        // Do any additional setup after loading the view.
        
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        memeCollection.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CustomMemeCell", forIndexPath: indexPath) as! CustomMemeViewCell
        let meme = self.memes[indexPath.item]
        //cell.memeLabel.text = "\(meme.topText) \(meme.bottomtext)"
        cell.memeImageView.image = meme.memedImage
        
        return cell
    }
    
    func addMeme() {
        performSegueWithIdentifier("addMeme", sender: self)
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("memeDisplayViewController") as! MemeDetailViewController
        detailController.meme = memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated:true)
    }
}
