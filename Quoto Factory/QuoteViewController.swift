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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getLuckyQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "lucky"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getSuccessQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "success"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getFamilyQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "family"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getFriendsQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "friends"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getAmbitionQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "ambition"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getCareerQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "career"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getLiteratureQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "literature"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getPhilosophyQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "philosophy"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getMotivationalQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "motivational"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getAdversityQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "adversity"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getWisdomQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "widsom"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getMemoriesQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "memories"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
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
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getInspirationalQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "inspirational"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getLifeQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "life"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getLoveQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "love"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getSportsQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "sports"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getManagementQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "management"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }

    @IBAction func getAngerQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "anger"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getStrengthQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "strength"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! QuoteDetailViewController
        controller.newQuoto = self.newQuoto 
    }

}
