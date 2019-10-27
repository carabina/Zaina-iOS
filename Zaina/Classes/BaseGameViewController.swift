//
//  BaseGameViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 7/21/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class BaseGameViewController: UIViewController {

  // MARK: - IBOutlet

  @IBOutlet private weak var sceneView: SceneView!

  // MARK: - Properties

  private var timer: Timer?

  // MARK: - ViewController lifecycle

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    startTimer()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    stopTimer()
  }

  private func startTimer() {
    timer = Timer.scheduledTimer(timeInterval: 0.016, target: self, selector: #selector(update), userInfo: nil, repeats: true)
  }

  private func stopTimer() {
    timer?.invalidate()
    timer = nil
  }

  /// override to make changes or move objects.
  @objc
  func update() {
    checkIfObjectsCollided()
  }

  /// check if any two objects collided.
  func checkIfObjectsCollided() {
    let subviews = sceneView.subviews.compactMap({ $0 as? ObjectView })
    for object1 in subviews {
      for object2 in subviews {
        if object1 != object2 { 
          if object1.frame.intersects(object2.frame) {
            object1.onCollisionEnter(with: object2)
            object2.onCollisionEnter(with: object1)
            objectsDidCollide(object1: object1, object2: object2)
            return
          } else {
            object1.onCollisionEnter(with: nil)
            object2.onCollisionEnter(with: nil)
          }
        }
      }
    }
  }

  /// override this method to get notify when two objects collided
  func objectsDidCollide(object1: ObjectView, object2: ObjectView) { }

}