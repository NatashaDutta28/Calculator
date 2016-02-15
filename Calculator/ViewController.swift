//
//  ViewController.swift
//  Calculator
//
//  Created by Natasha Dutta on 22/09/15.
//  Copyright © 2015 Natasha Dutta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var answerLabel: UILabel!
    
    @IBOutlet weak var inputTextView: UITextView!

    @IBAction func enternumber(sender: UIButton){
     
        self.inputTextView.text = self.inputTextView.text + sender.titleForState(.Normal)!
        
        self.calculateAnswer()
        
    }
    
    @IBAction func deleteLastValue(sender: UIButton) {
        
        if self.inputTextView.text.characters.count > 1{
            
            self.inputTextView.text = EditingClass.deleteLastValueFromEquation(self.inputTextView.text)
            
            self.calculateAnswer()
            
        }
    }

    @IBAction func clearEquation(sender: UIButton) {
        
        self.inputTextView.text = ""
        
        self.calculateAnswer()
    }
    
    func calculateAnswer(){
        
        self.answerLabel.text = EditingClass.calculateAnswerForEquation(self.inputTextView.text)
        
    }

}

