import SwiftUI

struct CurvedLineView: View {
    let points: [CGPoint]
    
    var body: some View {
        Path { path in
            guard let firstPoint = points.first else { return }
            path.move(to: firstPoint)
            for i in 1..<points.count {
                let previousPoint = points[i - 1]
                let currentPoint = points[i]
                let controlPoint = CGPoint(x: (previousPoint.x + currentPoint.x) / 2, y: (previousPoint.y + currentPoint.y) / 2)
                path.addQuadCurve(to: currentPoint, control: controlPoint)
            }
        }
        .stroke(Color(.gradient), lineWidth: 2)
    }
}
