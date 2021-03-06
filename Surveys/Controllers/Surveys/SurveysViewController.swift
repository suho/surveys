//
//  SurveysViewController.swift
//  Surveys
//
//  Created by Su Ho V. on 6/5/19.
//  Copyright © 2019 suho. All rights reserved.
//

import UIKit

final class SurveysViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageContainer: UIView!
    @IBOutlet weak var pageControl: ISPageControl!
    @IBOutlet weak var surveyButton: UIButton!
    var viewModel: SurveysViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupUI()
    }

    private func setupUI() {
        setupNavigationBar()
        setupCollectionView()
        setupPageControl()
        setupSurveyButton()
    }

    private func setupViewModel() {
        viewModel.delegate = self
        viewModel.fetch()
    }
}

// MARK: - Action
extension SurveysViewController {
    private func updateUI() {
        collectionView.reloadData()
        pageControl.numberOfPages = viewModel.numberOfItems(in: 0)
    }

    private func refreshUI() {
        collectionView.reloadData()
        collectionView.setContentOffset(.zero, animated: false)
        pageControl.numberOfPages = viewModel.numberOfItems(in: 0)
        surveyButton.isHidden = viewModel.numberOfItems(in: 0) == 0
    }

    @objc private func onPressRefreshButton() {
        viewModel.fetch()
    }

    @objc private func onPressMenuButton() {
        showAlert(title: Constants.surveysApp, message: Constants.authorSuHo)
    }

    @IBAction private func onPressSurveyButton(_ sender: Any) {
        let currentIndex = pageControl.currentPage
        guard let itemViewModel = try? viewModel.viewModelForItem(at: currentIndex) else { return }
        let controller = SurveyDetailViewController()
        controller.viewModel = itemViewModel
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - Setup UI
extension SurveysViewController {
    private func setupNavigationBar() {
        navigationItem.title = Constants.surveys.uppercased()
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(onPressRefreshButton))
        navigationItem.setLeftBarButton(refresh, animated: false)
        let menu = UIBarButtonItem(image: UIImage(named: "ic-menu"), style: .plain, target: self, action: #selector(onPressMenuButton))
        navigationItem.setRightBarButton(menu, animated: false)
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = UIColor.whaleBlue
        collectionView.register(nibWithCellClass: SurveyItemCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        if let bar = navigationController?.navigationBar {
            collectionView.contentInset = Configuration.contentInset(with: bar)
        }
    }

    private func setupPageControl() {
        let trailingConstant = (Measure.screenSize.width - pageControl.height) / 2
        let trailingAnchor = pageContainer
            .trailingAnchor
            .constraint(equalTo: view.trailingAnchor,
                        constant: trailingConstant)
        trailingAnchor.isActive = true
        pageContainer.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
    }

    private func setupSurveyButton() {
        surveyButton.isHidden = true
        surveyButton.titleLabel?.font = UIFont.systemFont(ofSize: Configuration.surveyFontSize)
        surveyButton.titleLabel?.textColor = .white
        surveyButton.backgroundColor = .cardinalRed
        surveyButton.titleLabel?.text = Constants.takeTheSurvey
    }
}

// MARK: - SurveysViewModelDelegate
extension SurveysViewController: SurveysViewModelDelegate {
    func viewModel(_ viewModel: SurveysViewModel, performAction action: SurveysViewModel.Action) {
        switch action {
        case .didFetch:
            refreshUI()
        case .didLoadMore:
            updateUI()
        case .didFail(let error):
            showError(error)
        case .showLoading(let isLoading):
            if isLoading {
                ProgressView.show()
            } else {
                ProgressView.hide()
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension SurveysViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellViewModel = try? viewModel.viewModelForItem(at: indexPath.item) else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(withClass: SurveyItemCell.self, for: indexPath)
        cell.bind(cellViewModel)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension SurveysViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.height
        let index = Int((scrollView.contentOffset.y / offset).rounded())
        pageControl.currentPage = index
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if viewModel.shouldLoadMore(at: indexPath) {
            viewModel.loadMore()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SurveysViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Measure.screenSize
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
}

// MARK: - Configuration
extension SurveysViewController {
    private enum Configuration {
        static let surveyFontSize: CGFloat = 20
        static let controlSize: CGSize = CGSize(width: 7, height: 7)
        static func contentInset(with bar: UINavigationBar) -> UIEdgeInsets {
            let navigationBarHeight = bar.height
            let statusBarHeight = Measure.statusBarHeight
            return .init(top: -navigationBarHeight - statusBarHeight, left: 0, bottom: 0, right: 0)
        }
    }
}

// MARK: - Constants
private extension Constants {
    static let surveys = "Surveys"
    static let surveysApp = "Surveys App"
    static let authorSuHo = "Author @suho"
    static let takeTheSurvey = "Take the survey"
}
