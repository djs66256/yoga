//
//  AutoLayoutViewController.swift
//  YogaKitSample
//
//  Created by daniel on 2017/5/25.
//  Copyright © 2017年 facebook. All rights reserved.
//

import UIKit
import YogaKit

class AutoLayoutViewController: UIViewController {
    
    let rootContainer = YGRootView()
    let label1 = UILabel()
    let container1 = UIView()
    let label2 = UILabel()
    let container2 = UIView()
    let label3 = UILabel()
    
    let models : [[String : String]] = [
        [
            "label1" : "label1",
            "label2" : "label2",
            "label3" : "label3",
        ],[
            "label1": "label1 label1 label1 label1 label1 label1 label1 label1 label1 label1 label1 label1"
        ]]
    var modelIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "change model", style: .plain, target: self, action: #selector(changeModel(_:)))
        
        self.label1.font = UIFont.systemFont(ofSize: 20)
        self.label1.numberOfLines = 0
        self.label2.font = UIFont.systemFont(ofSize: 20)
        self.label2.numberOfLines = 0
        self.label3.font = UIFont.systemFont(ofSize: 20)
        self.label3.numberOfLines = 0

        self.rootContainer.backgroundColor = UIColor.lightGray
        self.container1.backgroundColor = UIColor.green
        self.container2.backgroundColor = UIColor.red
        
        self.view.addSubview(self.rootContainer)
        self.rootContainer.addSubview(self.label1)
        self.rootContainer.addSubview(self.container1)
        self.rootContainer.addSubview(self.container2)
        self.container1.addSubview(self.label2)
        self.container2.addSubview(self.label3)
        
        self.rootContainer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(
            NSLayoutConstraint(item: self.rootContainer,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: self.view,
                               attribute: .top,
                               multiplier: 1,
                               constant: 40))
        self.view.addConstraint(
            NSLayoutConstraint(item: self.rootContainer,
                               attribute: .left,
                               relatedBy: .equal,
                               toItem: self.view,
                               attribute: .left,
                               multiplier: 1,
                               constant: 20))
        self.view.addConstraint(
            NSLayoutConstraint(item: self.rootContainer,
                               attribute: .right,
                               relatedBy: .equal,
                               toItem: self.view,
                               attribute: .right,
                               multiplier: 1,
                               constant: -20))
        self.view.addConstraint(
            NSLayoutConstraint(item: self.rootContainer,
                               attribute: .bottom,
                               relatedBy: .equal,
                               toItem: self.view,
                               attribute: .bottom,
                               multiplier: 1,
                               constant: -60))
        
        self.rootContainer.configureLayout { (layout) in
            layout.isEnabled = true
            layout.flexDirection = .column
            layout.alignItems = .stretch
        }
        //self.rootContainer.dimensionFlexibility = .flexibleHeigth
        
        self.label1.configureLayout { (layout) in
            layout.isEnabled = true
        }
        
        self.container1.configureLayout { (layout) in
            layout.isEnabled = true
            layout.flexDirection = .column
            layout.alignItems = .stretch
            layout.flexShrink = 0
        }
        
        self.label2.configureLayout { (layout) in
            layout.isEnabled = true
            layout.margin = 20
        }
        
        self.container2.configureLayout { (layout) in
            layout.isEnabled = true
        }
        
        applyModel()
    }
    
    func changeModel(_ sender:Any) {
        applyModel()
    }
    
    func applyModel() {
        let model = models[modelIndex]
        label1.text = model["label1"]
        label2.text = model["label2"]
        label3.text = model["label3"]
        
        
        label1.isHidden = label1.text == nil
        label1.yoga.isEnabled = label1.text != nil
        container1.isHidden = label2.text == nil
        container1.yoga.isEnabled = label2.text != nil
        container2.isHidden = label3.text == nil
        container2.yoga.isEnabled = label3.text != nil
        
        
        self.rootContainer.invalidateIntrinsicContentSize()
        self.rootContainer.invalidateFlexLayout()
        
        modelIndex = modelIndex + 1
        if modelIndex >= models.count {
            modelIndex = 0
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.rootContainer.yoga.applyLayout(preservingOrigin: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
