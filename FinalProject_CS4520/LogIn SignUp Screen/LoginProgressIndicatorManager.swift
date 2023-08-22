//
//  LoginProgressIndicatorManager.swift
//  FinalProject_CS4520
//
//  Created by Aleksei Shilov on 6/21/23.
//
import Foundation
extension LogInViewController:ProgressSpinnerDelegate{
    func showActivityIndicator(){
        addChild(childProgressView)
        view.addSubview(childProgressView.view)
        childProgressView.didMove(toParent: self)
    }
    
    func hideActivityIndicator(){
        childProgressView.willMove(toParent: nil)
        childProgressView.view.removeFromSuperview()
        childProgressView.removeFromParent()
    }
}
