//
//  MemeTableViewController.swift
//  MemeMePart2
//
//  Created by Gabriele on 3/28/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//


import UIKit

class MemeTableViewController: UITableViewController {
    var memes: [Meme]!
    
    
    @IBOutlet var memeTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell")! as UITableViewCell
        let meme = self.memes[indexPath.row]

        cell.textLabel?.text = meme.topText
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
    
    
    @IBAction func addMeme(sender: AnyObject) {
        
    }
}

