//
//  QuoteDetailViewController.swift
//  Quoto Factory
//
//  Created by Javid Sheikh on 26/02/2016.
//  Copyright © 2016 Javid Sheikh. All rights reserved.
//

import UIKit

class QuoteDetailViewController: UIViewController {
    
    // MARK: Variables
    var newQuoto: NewQuoto!
    
    var activityIndicator = UIActivityIndicatorView()
    
    // MARK: IBOutlets
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet var genericButton: [UIButton]!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categoryLabel.text = self.newQuoto.quotoCategory.capitalized
        self.getQuote(self.newQuoto.quotoCategory)
        
        for button in self.genericButton {
            button.layer.cornerRadius = 15
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: disable UI while http request is being made
    fileprivate func enableUI(_ enabled: Bool) {
        
        if !enabled {
            activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
            activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = .gray
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
        } else {
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    // MARK - getQuote function
    fileprivate func getQuote(_ category: String) {
        
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
            urlString = Constants.TheySaidSo.APIBaseURL + self.escapedParameters(randomParameters as [String : AnyObject])
        } else {
            urlString = Constants.TheySaidSo.APIBaseURL + self.escapedParameters(categoryParameters as [String : AnyObject])
        }
        
        print(urlString)
        
        let session = URLSession.shared
    
        let url = URL(string: urlString)!
                
        let task = session.dataTask(with: url) { (data, response, error) in
            
            // if an error occurs, print it and re-enable the UI
            func displayError(_ error: String) {
                print(error)
                print("URL at time of error: \(url)")
                DispatchQueue.main.async(execute: { () -> Void in
                    self.quoteLabel.text = "There was an error. Please check your network connection and try again."
                    self.authorLabel.text = ""
                    self.enableUI(true)
                })
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                displayError("There was an error with your request: \(String(describing: error))")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode , statusCode >= 200 && statusCode <= 299 else {
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
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
            } catch {
                displayError("Could not parse the data as JSON: '\(data)'")
                return
            }
            
            /* GUARD: Are the "photos" and "photo" keys in our result? */
            guard let contentsDictionary = parsedResult[Constants.TheySaidSoResponseKeys.Contents] as? [String:AnyObject] else {
                displayError("Cannot find key \(Constants.TheySaidSoResponseKeys.Contents) in \(parsedResult)")
                return
            }
            
            /* GUARD: Is "quote" in contentsDictionary? */
            guard let quote = contentsDictionary[Constants.TheySaidSoResponseKeys.Quote] as? String else {
                displayError("Unable to find key \(Constants.TheySaidSoResponseKeys.Quote) in contentsDictionary")
                return
            }
            
            /* GUARD: Is "author" in contentsDictionary? */
            guard let author = contentsDictionary[Constants.TheySaidSoResponseKeys.Author] as? String else {
                displayError("Unable to find key \(Constants.TheySaidSoResponseKeys.Author) in contentsDictionary")
                DispatchQueue.main.async(execute: { () -> Void in
                    print(quote)
                    self.enableUI(true)
                    self.quoteLabel.text = quote
                    self.authorLabel.text = ""
                })
                return
            }
            
            // Update UI
            DispatchQueue.main.async(execute: { () -> Void in
                
                self.enableUI(true)
                self.quoteLabel.text = quote
                self.authorLabel.text = author
            })
        }
        task.resume()
    }
    
    // MARK: IBActions
    @IBAction func selectQuote(_ sender: UIButton) {
        self.newQuoto.quotoQuote = self.quoteLabel.text!
        self.newQuoto.quotoAuthor = " - \(self.authorLabel.text!)"
        self.navigationController?.popToRootViewController(animated: true)
    }

    @IBAction func getAnotherQuote(_ sender: UIButton) {
        getQuote(self.newQuoto.quotoCategory)
    }
    
    // MARK: helper function
    fileprivate func escapedParameters(_ parameters: [String:AnyObject]) -> String {
        
        if parameters.isEmpty {
            return ""
        } else {
            var keyValuePairs = [String]()
            
            for (key, value) in parameters {
                
                // make sure that it is a string value
                let stringValue = "\(value)"
                
                // escape it
                let escapedValue = stringValue.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                
                // append it
                keyValuePairs.append(key + "=" + "\(escapedValue!)")
                
            }
            
            return "?\(keyValuePairs.joined(separator: "&"))"
        }
    }

}

