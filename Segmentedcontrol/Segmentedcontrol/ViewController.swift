//
//  ViewController.swift
//  Segmentedcontrol
//
//  Created by Enes on 19.11.2024.
//

import UIKit

class ViewController: UIViewController {
       private var segmentedControl: CustomSegmentedControl!

       override func viewDidLoad() {
           super.viewDidLoad()
           view.backgroundColor = .white
           setupSegmentedControl()
       }

       // A single function to configure the segmented control
       private func setupSegmentedControl() {
           // 1. Create the segmented control
           segmentedControl = CustomSegmentedControl(segments: ["First", "Second", "Third"])
           
           // 2. Handle segment change using a closure
           segmentedControl.segmentChanged = { [weak self] selectedIndex in
               self?.handleSegmentSelection(for: selectedIndex)
           }
           
           // 3. Add the segmented control to the view and configure its layout
           view.addSubview(segmentedControl)
           segmentedControl.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
               segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
               segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
               segmentedControl.heightAnchor.constraint(equalToConstant: 40)
           ])
       }

       // Handles the actions for each segment selection
       private func handleSegmentSelection(for index: Int) {
           switch index {
           case 0:
               print("First segment selected")
           case 1:
               print("Second segment selected")
           case 2:
               print("Third segment selected")
           default:
               print("Invalid segment selected")
           }
       }
   }
