
import SwiftUI

struct LoadingView: View {
    
    @State private var animateDegrees: Double = 0
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "circle.hexagongrid.fill")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50,
                       height: 50,
                       alignment: .center)
                .rotationEffect(Angle.degrees(animateDegrees))
                .onAppear {
                    let animation: Animation =
                        .linear(duration: 2)
                        .repeatForever(autoreverses: false)

                    withAnimation(animation) {
                        animateDegrees = 360
                    }
                }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.black)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
