//
//  ContentView.swift
//  CustomShapes
//
//  Created by Maxim Macari on 22/12/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Rating(value: 0.5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Rating: View {
    
    //Slider value
    @State var value: CGFloat
    
    var body: some View {
        VStack{
            Text("Are you having fun?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding(.top, 20)
            
            Spacer(minLength: 0)
            
            //Eyes
            HStack(spacing: 20){
                ForEach(1...2, id: \.self){ _ in
                    ZStack {
                        Eyes()
                            .stroke(Color.black, lineWidth: 3)
                            .frame(width: 100)
                        
                        Eyes(value: value)
                            .stroke(Color.black, lineWidth: 3)
                            .frame(width: 100)
                            .rotationEffect(.init(degrees: 180))
                            .offset(y: -100)
                        
                        //Eye dot
                        
                        Circle()
                            .fill(Color.black)
                            .frame(width: 13, height: 13)
                            .offset(y: -30)
                    }
                    .frame(height: 100)
                }
                
            }
            
            Smile(value: value)
                .stroke(Color.black, lineWidth: 3)
                .frame(height: 100)
                .padding(.top, 40)
            
            //Custom Slider
            
            GeometryReader{ reader in
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                    
                    Color.black
                        .frame(height: 2)
                        .padding(.horizontal)
                    
                    
                    Image(systemName: "arrow.right")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 45, height: 45)
                        .background(Color.black)
                        .cornerRadius(5)
                        .offset(x: value * (reader.frame(in: .global).width) - 45)
                        .gesture(DragGesture().onChanged({ (value) in
                            let width = reader.frame(in: .global).width - 45
                            //since horizontal padding = 30
                            let drag = value.location.x - 30
                            
                            //limmiting
                            if drag > reader.size.width - width && drag <= width {
                                self.value = drag / width
                            }
                            
                        }))
                    
                    
                })
            }
            .padding()
            .frame(height: 45)
            
            
            
            Spacer(minLength: 0)
            
            //Button
            Button(action: {
                
            }, label: {
                Text("Done")
                    .fontWeight(.semibold)
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width / 2)
                    .background(Color.black)
            })
            .padding(.bottom)
        }
        .background(
            (value <= 0.3 ? Color.red : (value > 0.3 && value <= 0.7 ? Color.yellow : Color.green))
                .ignoresSafeArea(.all, edges: .all)
                .animation(.easeInOut)
        )
    }
}


struct Smile: Shape {
    
    var value: CGFloat
    
    func path(in rect: CGRect) -> Path {
        return Path{ path in
            let center = rect.width / 2
            
            let downRadius: CGFloat = (115 * value) - 32
            
            path.move(to: CGPoint(x: center - 150, y: 0))
            
            let to1 = CGPoint(x: (center), y: downRadius)
            let control1 = CGPoint(x: center - 145, y: 0)
            let control2 = CGPoint(x: (center) - 145, y: downRadius)
            
            let to2 = CGPoint(x: (center + 150), y: 0)
            let control3 = CGPoint(x: (center + 145), y: downRadius)
            let control4 = CGPoint(x: (center) + 145, y: 0)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}

struct Eyes: Shape {
    var value: CGFloat?
    func path(in rect: CGRect) -> Path {
        return Path{ path in
            let center = rect.width / 2
            
            let downRadius: CGFloat = 55 * (value ?? 1)
            
            path.move(to: CGPoint(x: center - 40, y: 0))
            
            let to1 = CGPoint(x: (center), y: downRadius)
            let control1 = CGPoint(x: center - 40, y: 0)
            let control2 = CGPoint(x: (center) - 40, y: downRadius)
            
            let to2 = CGPoint(x: (center + 40), y: 0)
            let control3 = CGPoint(x: (center + 40), y: downRadius)
            let control4 = CGPoint(x: (center) + 40, y: 0)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}
