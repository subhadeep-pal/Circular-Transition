//
//  ViewController.swift
//  Custom Transition
//
//  Created by 01HW934413 on 19/04/17.
//  Copyright © 2017 01HW934413. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    var selectedButton: UIButton!
    
    var transition: AnimationController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        circleButton(button: button1)
        circleButton(button: button2)
        circleButton(button: button3)
        circleButton(button: button4)
        
        transition = AnimationController()
    }
    
    func circleButton(button: UIButton){
        button.layer.cornerRadius = button.frame.width / 2
        button.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        selectedButton = sender
        performSegue(withIdentifier: "next", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? SecondViewController{
            
            controller.transitioningDelegate = self
            controller.modalPresentationStyle = .custom
        }
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
        transition.transition = Transition.presenting
        transition.bgColor = selectedButton.backgroundColor
        transition.buttonOrigin = selectedButton.center
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transition = .dismissing
        transition.bgColor = selectedButton.backgroundColor
        transition.buttonOrigin = selectedButton.center
        return transition
    }
    
}

