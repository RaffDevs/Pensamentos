//
//  SettingsViewController.swift
//  Pensamentos
//
//  Created by Rafael Veronez Dias on 24/01/23.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var changeAutoSwtich: UISwitch!
    @IBOutlet weak var changeAutoLabel: UILabel!
    @IBOutlet weak var changeAutoTimeSlider: UISlider!
    
    @IBOutlet weak var colorSchemeSegControl: UISegmentedControl!
    
    let config = Configuration.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Refresh"), object: nil, queue: nil) { notificationData in
            print("Fui chamado!")
            self.formatView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        formatView()
    }
    
    func formatView() {
        changeAutoSwtich.setOn(config.autoRefresh, animated: true )
        changeAutoTimeSlider.setValue(Float(config.timeInterval), animated: true)
        colorSchemeSegControl.selectedSegmentIndex = config.colorScheme
        
        changeTimeIntervalLabel(with: config.timeInterval)
    }
    
    func changeTimeIntervalLabel(with value: Double) {
        changeAutoLabel.text = "Mudar após \(Int(value)) segundos"
    }
    

    @IBAction func changeAutoRefresh(_ sender: UISwitch) {
        config.autoRefresh = sender.isOn
    }
    
    
    @IBAction func changeTimeInterval(_ sender: UISlider) {
        let step: Float = 1
        let value = Double(round(sender.value / step) * step)
        changeTimeIntervalLabel(with: value)
        config.timeInterval = value
    }
    
    
    
    @IBAction func changeColorScheme(_ sender: UISegmentedControl) {
        config.colorScheme = sender.selectedSegmentIndex
    }
}
