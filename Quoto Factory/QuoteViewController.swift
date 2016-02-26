//
//  QuoteViewController.swift
//  Quoto Factory
//
//  Created by Javid Sheikh on 23/02/2016.
//  Copyright © 2016 Javid Sheikh. All rights reserved.
//

import UIKit

class QuoteViewController: UIViewController {
    
    var newQuoto: NewQuoto!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let navController = navigationController as! NavigationController
        self.newQuoto = navController.newQuoto
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getRandom(sender: UIButton) {
        self.newQuoto.quotoCategory = "random"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getArtQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "art"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getFunnyQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "funny"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)    }
    
    @IBAction func getInspireQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "inspire"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)    }
    
    @IBAction func getLifeQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "life"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)    }
    
    @IBAction func getLoveQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "love"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)    }
    
    @IBAction func getSportsQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "sports"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)    }
    
    @IBAction func getManagementQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "management"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! QuoteDetailViewController
        controller.newQuoto = self.newQuoto 
    }

}
