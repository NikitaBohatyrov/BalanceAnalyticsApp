import SwiftUI

extension View {
    func dismissDragGesture(action: @escaping () -> Void) -> some View {
        self
            .gesture(
                DragGesture()
                    .onEnded { drag in
                        withAnimation {
                            if drag.translation.width > 100 {
                                action()
                            }
                        }
                    }
            )
    }
}
