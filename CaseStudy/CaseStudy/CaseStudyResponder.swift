//
//  CaseStudyResponder.swift
//  CaseStudy
//
//  Created by Enes Pusa on 2.11.2023.
//


import Foundation
import UIKit

/*
 This is where we can capture all the responder chain events for our app.
 */

@objc protocol CaseStudyResponder {
    @objc optional func didTapScan(sender: UIButton?)
    @objc optional func didTapHome(sender: UIButton?)
}
