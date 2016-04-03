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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
    }
}

