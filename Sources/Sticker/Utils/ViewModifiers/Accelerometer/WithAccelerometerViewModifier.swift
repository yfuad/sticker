//
//  File.swift
//  Sticker
//
//  Created by Benjamin Pisano on 15/11/2024.
//

import SwiftUI
import CoreMotion

private struct WithAccelerometerViewModifier<ModifiedContent: View>: ViewModifier {
    let makeView: (AnyView, AccelerometerAttitude) -> ModifiedContent

    private let motionManager = CMMotionManager()
    private let queue = OperationQueue()

    @State private var attitude: AccelerometerAttitude = .init()
    @State private var referenceAttitude: AccelerometerAttitude?

    func body(content: Content) -> some View {
        makeView(AnyView(content), attitude)
            .onAppear {
                startMotionUpdates()
            }
            .onDisappear {
                stopMotionUpdates()
            }
    }

    private func startMotionUpdates() {
        guard motionManager.isDeviceMotionAvailable else { return }
        motionManager.deviceMotionUpdateInterval = 0.1
        motionManager.startDeviceMotionUpdates(to: queue) { motion, error in
            guard let motion = motion, error == nil else { return }
            var currentAttitude: AccelerometerAttitude = .init(attitude: motion.attitude)

            DispatchQueue.main.async {
                if referenceAttitude == nil {
                    referenceAttitude = currentAttitude
                }

                if let referenceAttitude {
                    currentAttitude = currentAttitude - referenceAttitude
                }

                attitude = currentAttitude
            }
        }
    }

    private func stopMotionUpdates() {
        motionManager.stopDeviceMotionUpdates()
    }
}

extension View {
    func withAccelerometer<ModifiedContent: View>(
        @ViewBuilder _ makeView: @escaping (_ view: AnyView, _ attitude: AccelerometerAttitude) -> ModifiedContent
    ) -> some View {
        modifier(WithAccelerometerViewModifier(makeView: makeView))
    }
}
