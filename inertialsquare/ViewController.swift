//
//  ViewController.swift
//  inertialsquare
//
//  Created by Илья Мудрый on 18.07.2023.
//

import UIKit

final class ViewController: UIViewController {

	// MARK: Constants

	private enum Size {
		static let width = 100.0
	}

	// MARK: Subviews

	private lazy var square: UIView = {
		let view = UIView(
			frame: CGRect(
				x: view.center.x - Size.width / 2,
				y: view.center.y - Size.width / 2,
				width: Size.width,
				height: Size.width
			)
		)
		view.backgroundColor = .white
		view.layer.cornerRadius = 10.0
		view.layer.cornerCurve = .continuous
		view.layer.masksToBounds = true
		return view
	}()

	// MARK: Properties

	private lazy var animator = UIDynamicAnimator(referenceView: view)
	private var snap: UISnapBehavior?
}

// MARK: - Lifecycle

extension ViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
		addGestureRecognizer()
	}
}

// MARK: - Private

private extension ViewController {

	// MARK: Configure UI
	func configureUI() {
		view.backgroundColor = UIColor(red: 126/255.0, green: 0/255, blue: 3/255, alpha: 1)
		view.addSubview(square)
	}

	// MARK: Gesture Recognizer

	func addGestureRecognizer() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handle))
		view.addGestureRecognizer(tapGesture)
	}

	@objc private func handle(_ gesture: UITapGestureRecognizer) {

		let tapPoint = gesture.location(in: view)

		if let snap {
			animator.removeBehavior(snap)
		}

		snap = UISnapBehavior(item: square, snapTo: tapPoint)

		if let snap {
			animator.addBehavior(snap)
		}
	}
}
