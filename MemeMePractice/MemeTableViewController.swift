//
//  MemeTableViewController.swift
//  MemeMePart2
//
//  Created by Gabriele on 3/28/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//


import UIKit

class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var memes: [Meme]!
    
    @IBOutlet var memeTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(MemeTableViewController.addMeme))
        getMemes()
    }
    
    override func viewWillAppear(animated: Bool) {
        getMemes()
        memeTable.reloadData()
    }
    
    func getMemes() {
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell")! as UITableViewCell
        let meme = memes[indexPath.row]

        cell.textLabel?.text = meme.topText + " " + meme.bottomtext
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
    func addMeme() {
        performSegueWithIdentifier("addMeme", sender: self)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("memeDisplayViewController") as! MemeDetailViewController
        detailController.meme = memes[indexPath.row]
        navigationController!.pushViewController(detailController, animated:true)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            memes.removeAtIndex(indexPath.row)
            memeTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            memeTable.reloadData()
        }
    }
}

