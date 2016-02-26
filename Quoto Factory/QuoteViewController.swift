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
    
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func enableUI(enabled: Bool) {
        
        if !enabled {
            activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
            activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = .Gray
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        } else {
            activityIndicator.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
        }
    }
    
    private func getQuote(category: String, isRandom: Bool) {
        
        self.enableUI(false)
        
        var urlString: String
        
        if isRandom {
            urlString = Constants.TheySaidSo.APIBaseURL + Constants.TheySaidSo.RandomExtension + "?" + Constants.TheySaidSo.APIKey
        } else {
            urlString = Constants.TheySaidSo.APIBaseURL + Constants.TheySaidSo.CategoryExtension + category + "&" + Constants.TheySaidSo.APIKey
        }
        
        let session = NSURLSession.sharedSession()
        
        let url = NSURL(string: urlString)!
        
        let request = NSURLRequest(URL: url)
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            // if an error occurs, print it and re-enable the UI
            func displayError(error: String) {
                print(error)
                print("URL at time of error: \(url)")
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                displayError("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                displayError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                displayError("No data was returned by the request!")
                return
            }
            
            // parse the data
            let parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            } catch {
                displayError("Could not parse the data as JSON: '\(data)'")
                return
            }
            
            /* GUARD: Are the "photos" and "photo" keys in our result? */
            guard let contentsDictionary = parsedResult["contents"] as? [String:AnyObject] else {
                displayError("Cannot find keys 'contents' and 'quotes' in \(parsedResult)")
                return
            }
            
            guard let quote = contentsDictionary["quote"] as? String, author = contentsDictionary["author"] as? String else {
                displayError("Unable to find keys 'quote' and 'author' in quotesObject")
                return
            }
            
            print(quote)
            print(author)
            self.newQuoto.quotoQuote = quote
            self.newQuoto.quotoAuthor = author
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                self.enableUI(true)

            })
            
        }
        task.resume()

    }

    
    @IBAction func getRandom(sender: UIButton) {
        getQuote("", isRandom: true)
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getArtQuote(sender: UIButton) {
        getQuote("art", isRandom: false)
    }
    
    @IBAction func getFunnyQuote(sender: UIButton) {
        getQuote("funny", isRandom: false)
    }
    
    @IBAction func getInspireQuote(sender: UIButton) {
        getQuote("inspire", isRandom: false)
    }
    
    @IBAction func getLifeQuote(sender: UIButton) {
        getQuote("life", isRandom: false)
    }
    
    @IBAction func getLoveQuote(sender: UIButton) {
        getQuote("love", isRandom: false)
    }
    
    @IBAction func getSportsQuote(sender: UIButton) {
        getQuote("sports", isRandom: false)
    }
    
    @IBAction func getManagementQuote(sender: UIButton) {
        getQuote("management", isRandom: false)
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! QuoteDetailViewController
        controller.newQuoto = self.newQuoto
    }

}
