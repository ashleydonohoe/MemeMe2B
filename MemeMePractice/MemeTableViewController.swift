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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: #selector(MemeTableViewController.addMeme))
    }
    
    override func viewWillAppear(animated: Bool) {
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
        print(memes)
        memeTable.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell")! as UITableViewCell
        let meme = memes[indexPath.row]

        cell.textLabel?.text = meme.topText
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
    func addMeme() {
        performSegueWithIdentifier("addMeme", sender: self)
    }
}

