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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .Plain, target: self, action: #selector(MemeDetailViewController.shareMeme(_:)))

    }
    
    func shareMeme(sender: UIBarButtonItem) {
        let imageToShare = memeImage.image
        let controller = UIActivityViewController(activityItems: [imageToShare!], applicationActivities: nil)
        controller.completionWithItemsHandler = {
            (activity, success, items, error) in
            if success {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        presentViewController(controller, animated: true, completion: nil)
    }

}
