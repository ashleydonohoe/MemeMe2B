//
//  MemeDetailViewController.swift
//  MemeMePart2
//
//  Created by Gabriele on 4/3/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var meme: Meme!

    @IBOutlet weak var memeImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets meme image
        memeImage.image = meme.memedImage

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
