//
//  QuotesViewController.swift
//  Pensamentos
//
//  Created by Rafael Veronez Dias on 24/01/23.
//

import UIKit

class QuotesViewController: UIViewController {

    @IBOutlet weak var photoImageview: UIImageView!
    @IBOutlet weak var backgroundImageview: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    let quotesManager = QuotesManager()
    let config = Configuration.shared
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Refresh"), object: nil, queue: nil) { notificationData in
            print("Fui chamado!")
            self.formatView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        formatView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        prepareQuote()
    }
    
    func formatView() {
        view.backgroundColor = config.colorScheme == 0 ? .white : UIColor(red: 156.0/255.0, green: 68.0/255.0 , blue: 15.0/255.0, alpha: 1.0)
        
        quoteLabel.textColor = config.colorScheme == 0 ? .black : .white
        authorLabel.textColor = config.colorScheme == 0 ? UIColor(red: 192.0/255.0, green: 96.0/255.0 , blue: 49.0/255.0, alpha: 1.0) : .yellow
        
        prepareQuote()
 
    }
    
    func prepareQuote() {
        timer?.invalidate()
        
        if (config.autoRefresh) {
            timer = Timer.scheduledTimer(withTimeInterval: config.timeInterval, repeats: true) { (timer) in
                self.showRandomQuote()
            }
        }
        
        showRandomQuote()

    }
    
    func showRandomQuote() {
        let quote = quotesManager.getRandomQuotes()
        quoteLabel.text = quote.quote
        authorLabel.text = quote.author
        photoImageview.image = UIImage(named: quote.image)
        backgroundImageview.image = photoImageview.image
        
        quoteLabel.alpha = 0
        authorLabel.alpha = 0
        photoImageview.alpha = 0
        backgroundImageview.alpha = 0
        topConstraint.constant = 50
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 2.5) {
            self.quoteLabel.alpha = 1
            self.authorLabel.alpha = 1
            self.photoImageview.alpha = 1
            self.backgroundImageview.alpha = 0.25
            self.topConstraint.constant = 10
            
            self.view.layoutIfNeeded()
        }
    }
    

}
