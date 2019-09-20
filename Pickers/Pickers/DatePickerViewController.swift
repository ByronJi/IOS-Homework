//
//  DatePickerViewController.swift
//  Pickers
//
//  Created by Byron on 2019/3/27.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

   
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let date = NSDate()
        datePicker.setDate(date as Date, animated: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onButtonPressed(_ sender: UIButton) {
        let date = datePicker.date
        let messsage = "The date abd time you select is \(date)"
        let alert = UIAlertController(title: "Date and time selected", message: messsage, preferredStyle: .alert)
        let action = UIAlertAction(title: "That's so true!", style: .default, handler: nil)
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
    }
    
}
