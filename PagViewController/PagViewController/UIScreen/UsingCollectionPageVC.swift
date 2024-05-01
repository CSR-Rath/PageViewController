//
//  ViewController.swift
//  PagViewController
//
//  Created by Rath! on 30/4/24.
//

import UIKit

class UsingCollectionPageVC: CollectionWithPageViewController {

    let array: [String] = ["Title One",
                           "Title Two",
                           "Title Three",
                           "Title Four",
                           "Title Five",
                           "Title Six"
                           ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        super.arrayTitleName = array
        title  = "PagViewController"
        
        for (_, _) in array.enumerated(){
            let vc = UIViewController()
            vc.view.backgroundColor = super.randomColor()
            super.controllers.append(vc)
        }
        
    }
}

