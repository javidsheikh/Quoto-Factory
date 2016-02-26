//
//  QuoteDetailViewController.swift
//  Quoto Factory
//
//  Created by Javid Sheikh on 26/02/2016.
//  Copyright © 2016 Javid Sheikh. All rights reserved.
//

import UIKit

class QuoteDetailViewController: UIViewController {
    
    var newQuoto: NewQuoto!

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(newQuoto.quotoAuthor)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.quoteLabel.text = self.newQuoto.quotoQuote
        self.authorLabel.text = self.newQuoto.quotoAuthor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func selectQuote(sender: UIButton) {
    }

    @IBAction func getAnotherQuote(sender: UIButton) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
