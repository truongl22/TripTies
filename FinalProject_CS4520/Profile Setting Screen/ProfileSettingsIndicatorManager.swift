//
//  ProfileSettingsIndicatorManager.swift
//  FinalProject_CS4520
//
//  Created by Aleksei Shilov on 6/25/23.
//

import Foundation

extension ProfileSettingViewController:ProgressSpinnerDelegate{
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
