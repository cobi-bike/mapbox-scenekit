//
//  AtomicPropertyWrapper.swift
//  MapboxSceneKit
//
//  Created by Andreas Hanft on 30.04.20.
//  Copyright © 2020 MapBox. All rights reserved.
//

import Foundation

@propertyWrapper
struct Atomic<T> {
    private var value: T
    private let lock = NSLock()
    init(wrappedValue value: T) {
        self.value = value
    }
    var wrappedValue: T {
      get { getValue() }
      set { setValue(newValue: newValue) }
    }
    func getValue() -> T {
        lock.lock()
        defer { lock.unlock() }
        return value
    }
    mutating func setValue(newValue: T) {
        lock.lock()
        defer { lock.unlock() }
        value = newValue
    }
}
