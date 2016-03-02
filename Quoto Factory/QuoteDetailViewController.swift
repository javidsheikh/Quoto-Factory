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
    
    var activityIndicator = UIActivityIndicatorView()

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet var genericButton: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.        
        self.categoryLabel.text = self.newQuoto.quotoCategory.capitalizedString
        print(self.newQuoto.quotoCategory)
        getQuote(self.newQuoto.quotoCategory)
        
        for button in self.genericButton {
            button.layer.cornerRadius = 15
        }
    }
    
    override func viewWillAppear(animated: Bool) {
//        self.quoteLabel.text = self.newQuoto.quotoQuote
//        self.authorLabel.text = self.newQuoto.quotoAuthor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func enableUI(enabled: Bool) {
        
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
    
    private func getQuote(category: String) {
        
        self.enableUI(false)
        
        var urlString: String
        
        let randomParameters = [
            Constants.TheySaidSoParameterKeys.APIKey: Constants.TheySaidSoParameterValues.APIKey
        ]
        
        let categoryParameters = [
            Constants.TheySaidSoParameterKeys.Length: Constants.TheySaidSoParameterValues.Length,
            Constants.TheySaidSoParameterKeys.Category: category,
            Constants.TheySaidSoParameterKeys.APIKey: Constants.TheySaidSoParameterValues.APIKey
        ]
        
        if category == "Random" {
            urlString = Constants.TheySaidSo.APIBaseURL + self.escapedParameters(randomParameters)
        } else {
            urlString = Constants.TheySaidSo.APIBaseURL + self.escapedParameters(categoryParameters)
        }
        
        print(urlString)
        
        let session = NSURLSession.sharedSession()
    
        let url = NSURL(string: urlString)!
        
        // ************* CHECK **************
        let request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10)
        // **********************************
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            // if an error occurs, print it and re-enable the UI
            func displayError(error: String) {
                print(error)
                print("URL at time of error: \(url)")
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.quoteLabel.text = "There was an error. Please check your network connection and try again."
                    self.authorLabel.text = ""
                    self.enableUI(true)
                })
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
            guard let contentsDictionary = parsedResult[Constants.TheySaidSoResponseKeys.Contents] as? [String:AnyObject] else {
                displayError("Cannot find key \(Constants.TheySaidSoResponseKeys.Contents) in \(parsedResult)")
                return
            }
        
            guard let quote = contentsDictionary[Constants.TheySaidSoResponseKeys.Quote] as? String else {
                displayError("Unable to find key \(Constants.TheySaidSoResponseKeys.Quote) in contentsDictionary")
                return
            }
            
            guard let author = contentsDictionary[Constants.TheySaidSoResponseKeys.Author] as? String else {
                displayError("Unable to find key \(Constants.TheySaidSoResponseKeys.Author) in contentsDictionary")
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    print(quote)
                    self.enableUI(true)
                    self.quoteLabel.text = quote
                    self.authorLabel.text = ""
                })
                return
            }
            
            print(quote)
            print(author)
                    
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                self.enableUI(true)
                self.quoteLabel.text = quote
                self.authorLabel.text = author
            })
                
        }
        task.resume()
        
    
    }

    @IBAction func selectQuote(sender: UIButton) {
        self.newQuoto.quotoQuote = self.quoteLabel.text!
        self.newQuoto.quotoAuthor = " - \(self.authorLabel.text!)"
        self.navigationController?.popToRootViewControllerAnimated(true)
//        self.performSegueWithIdentifier("segueToMainVC", sender: self)
    }

    @IBAction func getAnotherQuote(sender: UIButton) {
        getQuote(self.newQuoto.quotoCategory)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "segueToMainVC" {
//            let controller = segue.destinationViewController as! MainViewController
//            controller.newQuoto = self.newQuoto
//        }
//        if segue.identifier == "segueBackToQuoteVC" {
//            let controller = segue.destinationViewController as! QuoteViewController
//            controller.newQuoto = self.newQuoto
//        }
//    }
    private func escapedParameters(parameters: [String:AnyObject]) -> String {
        
        if parameters.isEmpty {
            return ""
        } else {
            var keyValuePairs = [String]()
            
            for (key, value) in parameters {
                
                // make sure that it is a string value
                let stringValue = "\(value)"
                
                // escape it
                let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
                
                // append it
                keyValuePairs.append(key + "=" + "\(escapedValue!)")
                
            }
            
            return "?\(keyValuePairs.joinWithSeparator("&"))"
        }
    }

}

