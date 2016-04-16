//
//  MemeCollectionViewController.swift
//  MemeMePart2
//
//  Created by Gabriele on 4/3/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]!
    
    @IBOutlet var memeCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(MemeCollectionViewController.addMeme))
        
        getMemes()

    }
    
    func getMemes() {
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        getMemes()
        // Checks for device orientation and will set spacing and dimension based on portrait vs. landscape
        var space: CGFloat!
        var dimension: CGFloat!
        
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation)) {
            space = 3.0
            dimension = (self.view.frame.size.width - (2 * space)) / 3.0
        } else {
            space = 5.0
            dimension = (self.view.frame.size.width - (2 * space)) / 5.0
        }
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
        memeCollection.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CustomMemeCell", forIndexPath: indexPath) as! CustomMemeViewCell
        let meme = self.memes[indexPath.item]
        cell.memeImageView.image = meme.memedImage
        
        return cell
    }
    
    func addMeme() {
        performSegueWithIdentifier("addMeme", sender: self)
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("memeDisplayViewController") as! MemeDetailViewController
        detailController.meme = memes[indexPath.row]
        navigationController!.pushViewController(detailController, animated:true)
    }
}
