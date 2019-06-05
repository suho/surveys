//
//  SurveysViewController.swift
//  Surveys
//
//  Created by Su Ho V. on 6/5/19.
//  Copyright © 2019 suho. All rights reserved.
//

import UIKit

final class SurveysViewController: ViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var surveyButton: UIButton!

    override func setupUI() {
        super.setupUI()
        setupCollectionView()
        setupSurveyButton()
    }

    private func setupCollectionView() {

    }

    private func setupSurveyButton() {
        surveyButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        surveyButton.titleLabel?.textColor = App.Color.surveyTitle
        surveyButton.backgroundColor = App.Color.surveyButton
        surveyButton.titleLabel?.text = App.String.takeTheSurvey
    }

    @IBAction func onPressSurveyButton(_ sender: Any) {
    }
}
