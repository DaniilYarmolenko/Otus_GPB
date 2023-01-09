//
//  EventsViewController.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import UIKit

final class EventsViewController: UIViewController {
	private let output: EventsViewOutput
    var eventsView = [UIViewController]()
    var eventPageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    var isLoading: Bool = true
    let interfaceSegmented = DDSegmentControl()
    
    var pageControllSegment: PageViewControllerSegmentedAdapter
    init(output: EventsViewOutput) {
        self.output = output
        pageControllSegment = PageViewControllerSegmentedAdapter(pageViewController: eventPageVC, viewControllers: [], segmentControl: interfaceSegmented)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        view.backgroundColor = .white
        [interfaceSegmented, eventPageVC.view].forEach { [weak self] view in
            self?.view.addSubview(view)
        }
        eventPageVC.view.isHidden = !isLoading
        interfaceSegmented.isHidden = !isLoading
        output.viewDidLoad()
        setUp()
	}
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addViewConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
    }
    private func setUp() {
        setUpSegmentedControl()
        setUpPageControllSegment()
    }
    private func setUpPageControllSegment() {
        pageControllSegment = PageViewControllerSegmentedAdapter(pageViewController: eventPageVC, viewControllers: eventsView, segmentControl: interfaceSegmented)
        
    }
    private func setUpSegmentedControl() {
        interfaceSegmented.setButtonTitles(buttonTitles: [LabelConstants.TodayEventLabelText, LabelConstants.FutureEventLabelText, LabelConstants.SearchEventLabelText])
        interfaceSegmented.selectorViewColor = .black
        interfaceSegmented.selectorTextColor =  .black
        interfaceSegmented.textUnSelectedColor = .lightGray
        interfaceSegmented.titleFontUnSelected = UIFont(name: FontConstants.MoniqaLightItalicHeading , size: 26) ?? .systemFont(ofSize: 26)
        interfaceSegmented.titleFontSelected = UIFont(name:FontConstants.MoniqaMediumNarrow, size: 30) ?? .systemFont(ofSize: 30)
        interfaceSegmented.backgroundColor = .clear
    }
}

extension EventsViewController: EventsViewInput {
    func receiveViews(with views: [UIViewController]) {
        eventsView = views
        isLoading = false
        eventPageVC.view.isHidden = isLoading
        interfaceSegmented.isHidden = isLoading
        setUp()
    }
}
